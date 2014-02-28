//
//  SetNewPswRequest.m
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SetNewPswRequest.h"
#import "Foundation.h"

@implementation SetNewPswRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

#pragma mark - Custom event methods

-(void)sendSetNewPswRequestWithMobile:(NSString *)mobile code:(NSInteger)code newPsw:(NSString *)newPsw
{
    NSString *post = [NSString stringWithFormat:@"mobile=%@&code=%i&new_password=%@",mobile,code,newPsw];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@User/saveNewPassword",ALIYUNURL];
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
    SetNewPswResponseParser *parser = [[SetNewPswResponseParser alloc] init];
    id parserObject = [parser setNewPswResponseParserWithJsonData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[SetNewPswResponse class]]) {
        SetNewPswResponse *setNewPswResponse = (SetNewPswResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SetNewPswRequestDidFinished:setNewPswResponse:)]) {
            [_delegate SetNewPswRequestDidFinished:self setNewPswResponse:setNewPswResponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SetNewPswRequestDidFailed:error:)]) {
            [_delegate SetNewPswRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SetNewPswRequestDidFailed:error:)]) {
        [_delegate SetNewPswRequestDidFailed:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    self.receivedData = nil;
    [super dealloc];
}

@end
