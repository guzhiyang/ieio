//
//  SayHelloResponseRequest.m
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SayHelloResponseRequest.h"
#import "Foundation.h"

@implementation SayHelloResponseRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

-(void)sendSayHelloResponseRequestWithMobile:(NSString *)mobile session_id:(NSString *)session_id auid:(NSInteger)auid message:(NSString *)message
{
    NSString *post = [NSString stringWithFormat:@"mobile=%@&session_id=%@&auid=%i&message=%@",mobile,session_id,auid,message];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Around/sendMsg",ALIYUNURL];
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

#pragma mark - URLconnection delegate methods

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
    SayHelloResponseParser *parser = [[SayHelloResponseParser alloc] init];
    id parserObject = [parser SayHelloResponseParserWithJsonData:self.receivedData];
    if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]) {
        StatusResponse *sayHelloResponse = (StatusResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SayHelloResponseRequestDidFinished:sayhelloResponse:)]) {
            [_delegate SayHelloResponseRequestDidFinished:self sayhelloResponse:sayHelloResponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SayHelloResponseRequestDidFailed:error:)]) {
            [_delegate SayHelloResponseRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SayHelloResponseRequestDidFailed:error:)]) {
        [_delegate SayHelloResponseRequestDidFailed:self error:error];
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
