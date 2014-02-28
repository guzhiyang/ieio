//
//  FindPswRequest.m
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FindPswRequest.h"
#import "Foundation.h"

@implementation FindPswRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

#pragma mark - Custom event methods

-(void)sendFindPswRequestWithMobile:(NSString *)mobile
{
    NSString *post = [NSString stringWithFormat:@"mobile=%@",mobile];
    NSData  *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@User/getNewPassword",ALIYUNURL];
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
    NSString *receivedString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSData *decodeData = [[NSData alloc] initWithBase64Encoding:receivedString];
    
    FindPswResponseParser *parser = [[FindPswResponseParser alloc] init];
    id parserObject = [parser FindPswResponseParserWithJsonData:decodeData];
    
    if ([[parserObject class] isSubclassOfClass:[FindPswResponse class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(FindPswRequestDidFinished:findPswResponse:)]) {
            FindPswResponse *findPswResponse = (FindPswResponse *)parserObject;
            [_delegate FindPswRequestDidFinished:self findPswResponse:findPswResponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        [_delegate FindPswRequestDIdFailed:self error:(NSError *)parserObject];
    }
    
    [receivedString release];
    [decodeData release];
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate  && [(NSObject *)_delegate respondsToSelector:@selector(FindPswRequestDIdFailed:error:)]) {
        [_delegate FindPswRequestDIdFailed:self error:error];
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
