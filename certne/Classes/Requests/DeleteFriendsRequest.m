//
//  DeleteFriendsRequest.m
//  certne
//
//  Created by apple on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DeleteFriendsRequest.h"
#import "Foundation.h"

@implementation DeleteFriendsRequest
@synthesize delegate     = _delegate;
@synthesize receivedData = _receivedData;

-(void)sendDeleteFriendsRequestWithSessionid:(NSString *)sessionid uid:(NSInteger)uid
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&uid=%i",sessionid,uid];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Friends/removeFriends",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnection = [[NSURLConnection alloc] initWithRequest:URLRequest
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

#pragma mark- URLConnection delegate methods

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
    StatusResponseParser *parser = [[StatusResponseParser alloc] init];
    id parserObject = [parser StatusResponseParserWithJsonData:self.receivedData];
    if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]) {
        StatusResponse *statusResoponse = (StatusResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(deleteFriendsRequestDidFinished:status:)]) {
            [_delegate deleteFriendsRequestDidFinished:self status:statusResoponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(deleteFriendsRequestDidFailed:error:)]) {
            [_delegate deleteFriendsRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"SetPrivacyRequestDidFailed = %@",error);
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    self.receivedData = nil;
    [super dealloc];
}

@end
