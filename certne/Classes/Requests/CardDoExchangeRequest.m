//
//  CardDoExchangeRequest.m
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CardDoExchangeRequest.h"
#import "Foundation.h"

@implementation CardDoExchangeRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

-(void)sendCardDoExchangeRequestWithSessionid:(NSString *)sessionid longitude:(CGFloat)longitude latitude:(CGFloat)latitude
{
    NSString *post = [NSString stringWithFormat:@"session_id=%@&longitude=%f&latitude=%f",sessionid,longitude,latitude];
    NSData   *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@CardExchange/exchange",ALIYUNURL];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnection = [[NSURLConnection alloc] initWithRequest:URLRequest
                                                     delegate:self
                                             startImmediately:YES];
}

#pragma mark- URLConnection delegate methods

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
    NSLog(@"交换获取数据:%@",receivedString);
    
    ChangeCardResponseParser *parser = [[ChangeCardResponseParser alloc] init];
    id parserObject = [parser ChangeCardResponseParserWithJsonData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NSError class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(CardDoExchangeRequestDidFailed:error:)]) {
            [_delegate CardDoExchangeRequestDidFailed:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]){
        StatusResponse *changeCardResponse = (StatusResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(CardDoExchangeRequestDidFinished:changeCardResponse:)]) {
            [_delegate CardDoExchangeRequestDidFinished:self changeCardResponse:changeCardResponse];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(CardDoExchangeRequestDidFailed:error:)]) {
        [_delegate CardDoExchangeRequestDidFailed:self error:error];
    }
}

-(void)cancle
{
    if (_URLConnection == nil) {
        [_URLConnection cancel];
        _URLConnection = nil;
    }
}

#pragma mark- memory menagement methods

-(void)dealloc
{
    [self cancle];
    self.receivedData = nil;
}

@end
