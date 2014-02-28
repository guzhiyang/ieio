//
//  GetChangeCardListRequest.m
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "GetChangeCardListRequest.h"
#import "Foundation.h"

@implementation GetChangeCardListRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

#pragma mark- Custom event methods

-(void)sendGetChangeCardListRequestWithSessionid:(NSString *)sessionid
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@",sessionid];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@CardExchange/getList",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnection = [[NSURLConnection alloc] initWithRequest:URLRequest
                                                     delegate:self
                                             startImmediately:TIMEOUTINTERAL];
}

-(void)cancle
{
    if (_URLConnection) {
        [_URLConnection cancel];
        [_URLConnection release];
        _URLConnection = nil;
    }
}

#pragma mark- URLConnection delegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if (httpResponse.statusCode == 200) {
        _receivedData = [NSMutableData data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ChangeCardListResponseParser *parser = [[ChangeCardListResponseParser alloc] init];
    id parserObject = [parser sendChangeCardListResponseParserWithJsonData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NSError class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetChangeCardListRequestDidFaild:error:)]) {
            [_delegate GetChangeCardListRequestDidFaild:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[ChangeCardListResponse class]]){
        ChangeCardListResponse *changeCardListResponse = (ChangeCardListResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetChangeCardListRequestDidFinished:changeCardListResponse:)]) {
            [_delegate GetChangeCardListRequestDidFinished:self changeCardListResponse:changeCardListResponse];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetChangeCardListRequestDidFaild:error:)]) {
        [_delegate GetChangeCardListRequestDidFaild:self error:error];
    }
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
    [self cancle];
    self.receivedData = nil;
    [super dealloc];
}

@end
