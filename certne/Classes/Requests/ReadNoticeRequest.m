//
//  ReadNoticeRequest.m
//  certne
//
//  Created by apple on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ReadNoticeRequest.h"
#import "Foundation.h"
#import "StatusResponseParser.h"

@implementation ReadNoticeRequest

-(void)sendReadNoticeRequestWithSessionID:(NSString *)sessionID
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@",sessionID];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *URLString = [NSString stringWithFormat:@"%@Around/readNotice",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnection = [[NSURLConnection alloc] initWithRequest:request
                                                     delegate:self
                                             startImmediately:YES];
}

-(void)cancle
{
    if (_URLConnection) {
        [_URLConnection cancel];
        [_URLConnection release];
        _URLConnection = nil;
    }
}

#pragma mark - URLConnection delegate methods

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
    NSString *receivedString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"查看消息:%@",receivedString);
    [receivedString release];
    
    StatusResponseParser *parser = [[StatusResponseParser alloc] init];
    id parserObject = [parser StatusResponseParserWithJsonData:self.receivedData];
    if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]) {
        StatusResponse *statusResponse = (StatusResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(readNoticeRequestDidFinish:statusResponse:)])
        {
            [_delegate readNoticeRequestDidFinish:self statusResponse:statusResponse];
        }
    }else{
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(readNoticeRequestDidFailed:error:)]) {
            [_delegate readNoticeRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(readNoticeRequestDidFailed:error:)]) {
        [_delegate readNoticeRequestDidFailed:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    self.receivedData = nil;
    [super dealloc];
}

@end
