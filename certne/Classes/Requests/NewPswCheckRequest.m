//
//  NewPswCheckRequest.m
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NewPswCheckRequest.h"
#import "Foundation.h"

@implementation NewPswCheckRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

#pragma mark - Custom event methods

-(void)sendNewPswCheckRequestWith:(NSString *)mobile code:(NSInteger)code
{
    NSString *post = [NSString stringWithFormat:@"mobile=%@&code=%i",mobile,code];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@User/checkNewPasswordCode",ALIYUNURL];
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

#pragma mark - URLConnection delegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse   *httpURLResponse = (NSHTTPURLResponse *)response;
    
    if (httpURLResponse.statusCode == 200) {
        self.receivedData = [[NSMutableData alloc] retain];
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
        
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(newPswCheckRequestDidFinished:sayHelloResponse:)]) {
            [_delegate newPswCheckRequestDidFinished:self sayHelloResponse:sayHelloResponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(newPswCheckRequestDidFialed:error:)]) {
            [_delegate newPswCheckRequestDidFialed:self error:(NSError *)parserObject];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(newPswCheckRequestDidFialed:error:)]) {
        [_delegate newPswCheckRequestDidFialed:self error:error];
    }
}

#pragma mark - Memroy menagement methods

-(void)dealloc
{
    [super dealloc];
}

@end
