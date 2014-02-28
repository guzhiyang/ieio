//
//  SendSuggestionRequest.m
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SendSuggestionRequest.h"
#import "Foundation.h"

@implementation SendSuggestionRequest

#pragma mark - Custom event methods

-(void)sendSuggestionRequestWithMobile:(NSString *)mobile sessionid:(NSString *)sessionid suggestion:(NSString *)suggestion
{
    NSString *post = [NSString stringWithFormat:@"mobile=%@&session_id=%@&suggestion=%@",mobile,sessionid,suggestion];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Setting/sendSuggestion",ALIYUNURL];
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
        StatusResponse *statusResponse = (StatusResponse *)parserObject;
        
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(sendSuggestionRequestDidFinished:statusResponse:)]) {
            [_delegate sendSuggestionRequestDidFinished:self statusResponse:statusResponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(sendSuggestionRequestDidFailed:error:)]) {
            [_delegate sendSuggestionRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(sendSuggestionRequestDidFailed:error:)]) {
        [_delegate sendSuggestionRequestDidFailed:self error:error];
    }
}

#pragma mark -  Memory menagement methods

- (void)dealloc
{
    self.receivedData = nil;
    [super dealloc];
}
@end
