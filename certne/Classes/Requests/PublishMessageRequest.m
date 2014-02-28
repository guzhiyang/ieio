//
//  PublishMessageRequest.m
//  certne
//
//  Created by apple on 13-12-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

/**
 *	@brief	发布供应需求请求
 */
#import "PublishMessageRequest.h"
#import "Foundation.h"

@implementation PublishMessageRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

#pragma mark - Custom event methods

-(void)sendPublishMessageRequestWithMobile:(NSString *)mobile sessionid:(NSString *)sessionid imagesUrl:(NSString *)imageUrl desc:(NSString *)desc type:(NSInteger)type longitude:(CGFloat)longitude latitude:(CGFloat)latitude
{
    NSString *post = [NSString stringWithFormat:@"mobile=%@&session_id=%@&imgs=%@&desc=%@&type=%i&longitude=%f&latitude=%f",mobile,sessionid,imageUrl,desc,type,longitude,latitude];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@SupplyInfo/createInfo",ALIYUNURL];
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
    StatusResponseParser *parser = [[StatusResponseParser alloc] init];
    id parserObject = [parser StatusResponseParserWithJsonData:self.receivedData];
    if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]) {
        StatusResponse *statusResponse = (StatusResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(publishMessageRequestDidFinished:statusResponse:)]) {
            [_delegate publishMessageRequestDidFinished:self statusResponse:statusResponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(publishMessageRequestDidFailed:error:)]) {
            [_delegate publishMessageRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(publishMessageRequestDidFailed:error:)]) {
        [_delegate publishMessageRequestDidFailed:self error:error];
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
