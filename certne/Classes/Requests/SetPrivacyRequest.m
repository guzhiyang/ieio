//
//  SetPrivacyRequest.m
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SetPrivacyRequest.h"
#import "Foundation.h"

@implementation SetPrivacyRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

-(void)sendSetPrivacyRequestWithMobile:(NSString *)mobile session_id:(NSString *)session_id is_sharing_info:(NSInteger)is_sharing_info is_allow_add:(NSInteger)is_allow_add is_allow_search:(NSInteger)is_allow_search is_recommend_user:(NSInteger)is_recommend_user
{
    NSString *post = [NSString stringWithFormat:@"mobiel=%@&session_id=%@&is_sharing_info=%i&is_allow_add=%i&is_allow_search=%i&is_recommend_user=%i",mobile,session_id,is_sharing_info,is_allow_add,is_allow_search,is_recommend_user];
    NSData  *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@Setting/setPrivacy",ALIYUNURL];
    NSURL   *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest = [NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _urlConnection = [[NSURLConnection alloc] initWithRequest:URLRequest
                                                     delegate:self
                                             startImmediately:TIMEOUTINTERAL];
}

-(void)cancle
{
    if (_urlConnection) {
        [_urlConnection cancel];
        _urlConnection = nil;
    }
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
    NSLog(@"隐私设置返回信息 = %@",receivedString);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"SetPrivacyRequestDidFailed = %@",error);
}

#pragma mark - Memory menagemtn methods

-(void)dealloc
{
    [self cancle];
    self.receivedData = nil;
}

@end
