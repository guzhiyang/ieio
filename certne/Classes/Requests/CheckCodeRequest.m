//
//  CheckCodeRequest.m
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CheckCodeRequest.h"
#import "CheckCodeParser.h"
#import "Foundation.h"

@implementation CheckCodeRequest

-(void)sendCheckCodeRequestWithCode:(NSString *)code mobile:(NSString *)mobile
{
    [self cancle];
    
    NSString    *post=[NSString stringWithFormat:@"code=%@&mobile=%@",code,mobile];
    NSData      *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString=[NSString stringWithFormat:@"%@User/checkCode",ALIYUNURL];
    NSURL      *URL=[NSURL URLWithString:URLString];
    NSMutableURLRequest     *URLResquest=[NSMutableURLRequest requestWithURL:URL];
    [URLResquest setHTTPMethod:@"POST"];
    [URLResquest setTimeoutInterval:30];
    [URLResquest setHTTPBody:postData];
    
    _URLConnection=[[NSURLConnection alloc] initWithRequest:URLResquest
                                                   delegate:self
                                           startImmediately:YES];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse   *httpResponse=(NSHTTPURLResponse *)response;
    if (httpResponse.statusCode==200) {
        self.receivedData=[[NSMutableData alloc] retain];
    }else{
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receivedString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"获取的验证码::%@",receivedString);
    [receivedString release];
    
    CheckCodeParser *parser=[[CheckCodeParser alloc] init];
    id parserObject=[parser checkCodeResponseParserWithJSONData:self.receivedData];
    if ([[parserObject class] isSubclassOfClass:[NSError class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(checkCodeRequestDIDFaild:error:)]) {
            [_delegate checkCodeRequestDIDFaild:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[CheckCodeResponse class]]){
        CheckCodeResponse *checkCodeResponse=(CheckCodeResponse *)parserObject;
        if (_delegate && [(NSObject*)_delegate respondsToSelector:@selector(checkCodeRequestDidFinished:checkCodeResponse:)]) {
            [_delegate checkCodeRequestDidFinished:self checkCodeResponse:checkCodeResponse];
        }
    }
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(checkCodeRequestDIDFaild:error:)]) {
        [_delegate checkCodeRequestDIDFaild:self error:error];
    }
}

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
