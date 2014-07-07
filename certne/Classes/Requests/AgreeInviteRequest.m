//
//  AgreeInviteRequest.m
//  certne
//
//  Created by apple on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AgreeInviteRequest.h"
#import "Foundation.h"
#import "StatusResponseParser.h"

@implementation AgreeInviteRequest

-(void)sendAgreeInviteRequestWithSessionID:(NSString *)sessionID fuid:(NSInteger)fuid
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&fuid=%i",sessionID,fuid];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *URLString = [NSString stringWithFormat:@"%@Around/agreeInvite",ALIYUNURL];
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
        _URLConnection = nil;
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
    StatusResponseParser *parser = [[StatusResponseParser alloc] init];
    id parserObject = [parser StatusResponseParserWithJsonData:self.receivedData];
    if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(agreeInviewRequestDidFinish:statusResponse:)]) {
            [_delegate agreeInviewRequestDidFinish:self statusResponse:(StatusResponse *)parserObject];
        }
    }else{
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(agreeInviewRequestDidFailed:error:)]) {
            [_delegate agreeInviewRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(agreeInviewRequestDidFailed:error:)]) {
        [_delegate agreeInviewRequestDidFailed:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [self cancle];
    self.receivedData = nil;
}

@end
