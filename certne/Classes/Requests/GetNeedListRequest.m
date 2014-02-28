//
//  GetNeedListRequest.m
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "GetNeedListRequest.h"
#import "Foundation.h"

@implementation GetNeedListRequest

-(void)sendGetNeedListRequestWithSessionid:(NSString *)sessionid
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@",sessionid];
    NSData  *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@SupplyInfo/getNeedList",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLResquest = [NSMutableURLRequest requestWithURL:URL];
    [URLResquest setHTTPMethod:@"POST"];
    [URLResquest setHTTPBody:postData];
    [URLResquest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnection = [[NSURLConnection alloc] initWithRequest:URLResquest
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
    NSHTTPURLResponse   *httpResponse = (NSHTTPURLResponse *)response;
    
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
    NSLog(@"需求信息:%@",receivedString);
    [receivedString release];
    
    PublicInfoResponseParser *parser = [[PublicInfoResponseParser alloc] init];
    id parserObject = [parser PublicInfoResponseParserWithJsonData:self.receivedData];
    if ([[parserObject class] isSubclassOfClass:[PublicInfoResponse class]]) {
        PublicInfoResponse *publicInfoResponse = (PublicInfoResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(getNeedListRequestDidFinished:publicInfoResponse:)]) {
            [_delegate getNeedListRequestDidFinished:self publicInfoResponse:publicInfoResponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(getNeedListRequestDidFailed:error:)]) {
            [_delegate getNeedListRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(getNeedListRequestDidFailed:error:)]) {
        [_delegate getNeedListRequestDidFailed:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    self.receivedData = nil;
    [super dealloc];
}

@end
