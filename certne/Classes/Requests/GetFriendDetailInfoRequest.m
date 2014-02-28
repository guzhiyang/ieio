//
//  GetFriendDetailInfoRequest.m
//  certne
//
//  Created by apple on 13-12-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "GetFriendDetailInfoRequest.h"
#import "Foundation.h"

@implementation GetFriendDetailInfoRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

#pragma mark - Custom event methods

-(void)sendGetFriendDetailInfoRequestWithSessionid:(NSString *)sessionid fuid:(NSInteger)uid
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&fuid=%i",sessionid,uid];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Friends/getFriendInfo",ALIYUNURL];
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

#pragma mark - URlConnection delegate methods

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
    FriendInfoAndMessageParser *parser = [[FriendInfoAndMessageParser alloc] init];
    id parserObject = [parser friendInfoAndMessageParserWithJsonData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[FriendInfoAndMessage class]]) {
        FriendInfoAndMessage *firendDetailInfo = (FriendInfoAndMessage *)parserObject;
        
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetFriendDetailInfoRequestDidFinished:friendDetailInfo:)]) {
            [_delegate GetFriendDetailInfoRequestDidFinished:self friendDetailInfo:firendDetailInfo];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetFriendDetailInfoRequestDidFailed:error:)]) {
            [_delegate GetFriendDetailInfoRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetFriendDetailInfoRequestDidFailed:error:)]) {
        [_delegate GetFriendDetailInfoRequestDidFailed:self error:error];
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
