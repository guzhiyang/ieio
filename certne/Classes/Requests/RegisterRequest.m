//
//  RegisterRequest.m
//  certne
//
//  Created by apple on 13-11-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RegisterRequest.h"
#import "Foundation.h"
#import "RegisterResponseParser.h"
#import "Foundation.h"

@implementation RegisterRequest

@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

-(void)sendRegiseterMoileNumber:(NSString *)mobileNumber password:(NSString *)passWord
{
    NSString *post      = [NSString stringWithFormat:@"mobile=%@&password=%@",mobileNumber,passWord];
    NSData *postData    = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *URLString = [NSString stringWithFormat:@"%@User/register", ALIYUNURL];
    NSURL *URL          = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    
    _urlConnection=[[NSURLConnection alloc] initWithRequest:URLRequest
                                                   delegate:self
                                           startImmediately:30];
}

#pragma mark- NSURLConnection 代理 该方法已过时，但是还可以用

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if (httpResponse.statusCode==200) {
        _receivedData=[[NSMutableData alloc] retain];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receivedString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSData *decodeData = [[NSData alloc] initWithBase64Encoding:receivedString];
    
    RegisterResponseParser *parser = [[RegisterResponseParser alloc] init];
    id parserObject = [parser requestResponseParserWithJsonData:decodeData];
    
    if ([[parserObject class] isSubclassOfClass:[NSError class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(connectionDidFailed:error:)]) {
            [_delegate connectionDidFailed:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[RegisterResponse class]]){
        RegisterResponse *registerResponse=(RegisterResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(connectionDidFinisnedWithRegister:registerResponse:)]) {
            [_delegate connectionDidFinisnedWithRegister:self registerResponse:registerResponse];
        }
    }
    
    [receivedString release];
    [decodeData release];
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error=%@",error.description);
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(connectionDidFailed:error:)]) {
        [_delegate connectionDidFailed:self error:error];
    }
}

#pragma mark- 断开连接

-(void)cancle
{
    if (_urlConnection) {
        [_urlConnection cancel];
        [_urlConnection release];
        _urlConnection=nil;
    }
}

#pragma mark- 内存管理

-(void)dealloc
{
    self.receivedData=nil;
    [super dealloc];
}

@end
