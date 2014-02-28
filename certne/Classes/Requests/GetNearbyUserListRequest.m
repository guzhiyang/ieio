//
//  GetNearbyUserListRequest.m
//  certne
//
//  Created by apple on 13-12-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "GetNearbyUserListRequest.h"
#import "Foundation.h"

@implementation GetNearbyUserListRequest

-(void)sendGetNearbyUserListRequestWithSessionid:(NSString *)sessionid longitude:(CGFloat)longitude latitude:(CGFloat)latitude
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&longitude=%f&latitude=%f",sessionid,longitude,latitude];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Around/getUserList",ALIYUNURL];
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
        self.receivedData = [[NSMutableData alloc] init];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receivedString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"附近好友 列表:%@",receivedString);
    [receivedString release];
    
    NearbyUserListParser *parser = [[NearbyUserListParser alloc] init];
    id parserObject = [parser NearbyUserListParserWithJsonData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NearbyUserList class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetNearbyUserListRequestDidFinished:nearbyUserList:)]) {
            NearbyUserList *nearbyUserList = (NearbyUserList *)parserObject;
            [_delegate GetNearbyUserListRequestDidFinished:self nearbyUserList:nearbyUserList];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetNearbyUserListRequestDidFailed:error:)]) {
            [_delegate GetNearbyUserListRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(GetNearbyUserListRequestDidFailed:error:)]) {
        [_delegate GetNearbyUserListRequestDidFailed:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    self.receivedData = nil;
    [super dealloc];
}

@end
