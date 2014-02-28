//
//  GetContactUserListRequest.m
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "GetContactUserListRequest.h"
#import "Foundation.h"
#import "Global.h"

@implementation GetContactUserListRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

-(void)sendGetContactUserListRequestWithSessionid:(NSString *)sessionid
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@",sessionid];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Contacts/getUserList",ALIYUNURL];
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
    RecentContactUserListParser *parser = [[RecentContactUserListParser alloc] init];
    id parserObject = [parser RecentContactUserListParserWithJsonData:self.receivedData];
    if ([[parserObject class] isSubclassOfClass:[RecentContactUserList class]]) {
        
        RecentContactUserList *recentContactUserList = (RecentContactUserList *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetContactUserListRequestDidFinished:recentContactUserList:)]) {
            [_delegate GetContactUserListRequestDidFinished:self recentContactUserList:recentContactUserList];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetContactUserListRequestDidFailed:error:)]) {
            [_delegate GetContactUserListRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetContactUserListRequestDidFailed:error:)]) {
        [_delegate GetContactUserListRequestDidFailed:self error:error];
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
