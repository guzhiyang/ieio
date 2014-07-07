//
//  GetMyFriendsInfoRequest.m
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "GetMyFriendsInfoRequest.h"
#import "Foundation.h"
#import "MyFriendsInfoListParser.h"

@implementation GetMyFriendsInfoRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

-(void)sendGetMyFriendsInfoRequestWithSessionid:(NSString *)sessionid
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@",sessionid];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Friends/getMyFriends",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnection = [[NSURLConnection alloc] initWithRequest:URLRequest
                                                     delegate:self
                                             startImmediately:YES];
}

#pragma mark- URLConnection delegate methods

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
    MyFriendsInfoListParser *parser = [[MyFriendsInfoListParser alloc] init];
    id parserObject = [parser sendMyFriendsInfoListParserWithJsonData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NSError class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetMyFriendsInfoRequestDidFailed:error:)]) {
            [_delegate GetMyFriendsInfoRequestDidFailed:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[MyFriendsInfoList class]]){
        
        MyFriendsInfoList *myFriendList = (MyFriendsInfoList *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetMyFriendsInfoRequestDidFinished:myFriendsInfoList:)]) {
            [_delegate GetMyFriendsInfoRequestDidFinished:self myFriendsInfoList:myFriendList];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetMyFriendsInfoRequestDidFailed:error:)]) {
        [_delegate GetMyFriendsInfoRequestDidFailed:self error:error];
    }
}

-(void)cancle
{
    if (_URLConnection) {
        [_URLConnection cancel];
        _URLConnection = nil;
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [self cancle];
    self.receivedData = nil;
}

@end
