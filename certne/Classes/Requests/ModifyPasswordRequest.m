//
//  ModifyPasswordRequest.m
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ModifyPasswordRequest.h"
#import "Foundation.h"

@implementation ModifyPasswordRequest
@synthesize recevedData = _recevedData;
@synthesize delegate    = _delegate;

#pragma mark - Custom event methods

-(void)sendModifyPasswordRequestWithSessionid:(NSString *)sessionid newPassword:(NSString *)newPassword
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&new_password=%@",sessionid,newPassword];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Setting/modifyPassword",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnetion = [[NSURLConnection alloc] initWithRequest:URLRequest
                                                    delegate:self
                                            startImmediately:TIMEOUTINTERAL];
}

-(void)cancle
{
    if (_URLConnetion) {
        [_URLConnetion cancel];
        [_URLConnetion release];
        _URLConnetion = nil;
    }
}

#pragma mark - URLConnection delegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if (httpResponse.statusCode == 200) {
        self.recevedData = [NSMutableData data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.recevedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    StatusResponseParser *parser = [[StatusResponseParser alloc] init];
    id parserObject =[parser StatusResponseParserWithJsonData:self.recevedData];
    if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]) {
        StatusResponse *statusResponse = (StatusResponse *)parserObject;
        
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(modifyPasswordRequestDidFinished:statusResponse:)]) {
            [_delegate modifyPasswordRequestDidFinished:self statusResponse:statusResponse];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(modifyPasswordRequestDidFailed:error:)]) {
            [_delegate modifyPasswordRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(modifyPasswordRequestDidFailed:error:)]) {
        [_delegate modifyPasswordRequestDidFailed:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    [self cancle];
    self.recevedData = nil;
    [super dealloc];
}

@end
