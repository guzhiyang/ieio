//
//  LoginOutRequest.m
//  certne
//
//  Created by apple on 14-1-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LoginOutRequest.h"
#import "Foundation.h"

@implementation LoginOutRequest
@synthesize delegate     = _delegate;
@synthesize receivedData = _receivedData;

-(void)sendLoginOutRequestWithSessionID:(NSString *)sessionID
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@",sessionID];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *URLString = [NSString stringWithFormat:@"%@User/loginOut",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnetion = [[NSURLConnection alloc] initWithRequest:URLRequest
                                                    delegate:self
                                            startImmediately:YES];
}

-(void)cancle
{
    if (_URLConnetion) {
        [_URLConnetion cancel];
        [_URLConnetion release];
        _URLConnetion = nil;
    }
}

#pragma mark - URLConnection delegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loginOutRequestDidFinished:)]) {
        [_delegate loginOutRequestDidFinished:self];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(loginOutRequestDidFinished:error:)]) {
        [_delegate loginOutRequestDidFinished:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [self cancle];
    self.receivedData = nil;
    [super dealloc];
}

@end
