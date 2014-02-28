//
//  LoginRequest.m
//  certne
//
//  Created by apple on 13-8-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "LoginRequest.h"
#import "LoginUserInfoParser.h"
#import "Foundation.h"

@implementation LoginRequest

-(void)sendLoginRequestWithUseMobile:(NSString *)mobile password:(NSString *)password
{
    [self cancle];
    
    NSString *URLString = [NSString stringWithFormat:@"%@User/login", ALIYUNURL];
    NSString *post = [NSString stringWithFormat:@"mobile=%@&password=%@",mobile,password];
    NSData  *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *encodeURLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    [URLRequest setHTTPBody:postData];
    
    _URLConnection=[[NSURLConnection alloc]initWithRequest:URLRequest
                                                  delegate:self
                                          startImmediately:YES];
}

/**
 *	@brief	检测请求返回状态 //--2.0 ~ 4.3 已经弃用的方法
 *
 *	@param 	connection
 *	@param 	response
 */
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if (httpResponse.statusCode==200) {
        self.receivedData = [NSMutableData data];
    }else{
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    LoginUserInfoParser *parser=[[LoginUserInfoParser alloc] init];
    id parserObject=[parser loginUserInfoParserWithJSONData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NSError class]])
    {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loginRequestFailed:error:)])
        {
            [_delegate loginRequestFailed:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[LoginUserInfo class]])
    {        
        LoginUserInfo *loginUserInfo=(LoginUserInfo *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loginRequestFinished:loginUserInfo:)]) {
            [_delegate loginRequestFinished:self loginUserInfo:loginUserInfo];
        }
    }
    [parser release];
}

//--连接失败，执行代理
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.description);
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loginRequestFailed:error:)]) {
        [_delegate loginRequestFailed:self error:error];
    }
}

//--释放连接
-(void)cancle
{
    if (_URLConnection) {
        [_URLConnection cancel];
        [_URLConnection release];
        _URLConnection=nil;
    }
}

-(void)dealloc
{
    self.receivedData=nil;
    [self cancle];
    [super dealloc];
}

@end
