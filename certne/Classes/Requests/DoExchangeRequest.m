//
//  DoExchangeRequest.m
//  certne
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DoExchangeRequest.h"
#import "Foundation.h"

@implementation DoExchangeRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

#pragma mark- Custom event methods

-(void)sendDoExchangeRequestWithSessionid:(NSString *)sessionid Uid:(NSString *)uid{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&exchange_uids=%@",sessionid,uid];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@CardExchange/doExchange",ALIYUNURL];
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

#pragma mark- connection delegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if (httpResponse.statusCode == 200) {
        self.receivedData = [[NSMutableData alloc] retain];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    DoExchangeResponseParser *parser = [[DoExchangeResponseParser alloc] init];
    id parserObject = [parser doExchangeResponseParserWithJsonData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NSError class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(DoExchangeRequestDidFailed:error:)]) {
            [_delegate DoExchangeRequestDidFailed:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(DoExchangeRequestDidFinished:doExchangeResponse:)]) {
            StatusResponse *doExchangeResponse = (StatusResponse *)parserObject;
            [_delegate DoExchangeRequestDidFinished:self doExchangeResponse:doExchangeResponse];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(DoExchangeRequestDidFailed:error:)]) {
        [_delegate DoExchangeRequestDidFailed:self error:error];
    }
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
    [super dealloc];
}

@end
