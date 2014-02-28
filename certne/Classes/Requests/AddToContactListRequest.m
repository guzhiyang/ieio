//
//  AddToContactListRequest.m
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AddToContactListRequest.h"
#import "Foundation.h"

@implementation AddToContactListRequest

-(void)sendAddToContactListRequestWithSessionID:(NSString *)sessionID cuid:(NSInteger)cuid
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&cuid=%i",sessionID,cuid];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Contacts/addLog",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnetion = [[NSURLConnection alloc] initWithRequest:URLRequest
                                                    delegate:self
                                            startImmediately:YES];
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
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(addToContactListRequestDidFinished:response:)]) {
            [_delegate addToContactListRequestDidFinished:self response:(StatusResponse *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[NSError class]]){
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(addToContactListRequestDidFailed:error:)]) {
            [_delegate addToContactListRequestDidFailed:self error:(NSError *)parserObject];
        }
    }
    
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(addToContactListRequestDidFailed:error:)]) {
        [_delegate addToContactListRequestDidFailed:self error:error];
    }
}

#pragma mark - Memory menagement methods

-(void)dealloc
{
    self.receivedData = nil;
    [super dealloc];
}

@end
