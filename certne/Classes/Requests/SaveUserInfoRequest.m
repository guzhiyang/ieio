//
//  SaveUserInfoRequest.m
//  certne
//
//  Created by apple on 13-12-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SaveUserInfoRequest.h"
#import "SaveUserInfoResponseParser.h"

@implementation SaveUserInfoRequest
@synthesize receivedData = _receivedData;
@synthesize delegate     = _delegate;

-(void)sendSaveUserInfoRequestWithUserAvatar:(NSString *)avatar sessionid:(NSString *)sessionid name:(NSString *)name position:(NSString *)position company:(NSString *)company mobile:(NSString *)mobile telphone:(NSString *)telphone fax:(NSString *)fax email:(NSString *)email qq:(NSString *)qq department:(NSString *)department industry:(NSString *)industry website:(NSString *)website address:(NSString *)address zipcode:(NSInteger)zipcode
{
    NSString *post=[NSString stringWithFormat:@"mobile=%@&session_id=%@&avatar=%@&name=%@&company=%@&tel=%@&email=%@&fax=%@&qq=%@&department=%@&position=%@&industry=%@&website=%@&address=%@&zipcode=%i",mobile,sessionid,avatar,name,company,telphone,email,fax,qq,department,position,industry,website,address,zipcode];
    NSData *postData=[post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *URLString=[NSString stringWithFormat:@"%@User/saveUserInfo",ALIYUNURL];
    NSURL   *URL=[NSURL URLWithString:URLString];
    NSMutableURLRequest *URLRequest=[NSMutableURLRequest requestWithURL:URL];
    [URLRequest setHTTPMethod:@"POST"];
    [URLRequest setHTTPBody:postData];
    [URLRequest setTimeoutInterval:TIMEOUTINTERAL];
    
    _URLConnection=[[NSURLConnection alloc] initWithRequest:URLRequest
                                                   delegate:self
                                           startImmediately:TIMEOUTINTERAL];
}

#pragma mark- urlconnection methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode==200) {
        self.receivedData = [NSMutableData data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{    
    SaveUserInfoResponseParser *saveUserInfoResponseParser=[[SaveUserInfoResponseParser alloc] init];
    id parserObject=[saveUserInfoResponseParser SaveUserInfoResponseParserWithJSONData:self.receivedData];
    
    if ([[parserObject class] isSubclassOfClass:[NSError class]]) {
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SaveUserInfoRequestDidFailed:error:)]) {
            [_delegate SaveUserInfoRequestDidFailed:self error:(NSError *)parserObject];
        }
    }else if ([[parserObject class] isSubclassOfClass:[StatusResponse class]]){
        StatusResponse *saveUserInfoResponse=(StatusResponse *)parserObject;
        if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SaveUserInfoRequestDidFinished:saveUserInfoResponse:)]) {
            [_delegate SaveUserInfoRequestDidFinished:self saveUserInfoResponse:saveUserInfoResponse];
        }
    }
    [saveUserInfoResponseParser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(SaveUserInfoRequestDidFailed:error:)]) {
        [_delegate SaveUserInfoRequestDidFailed:self error:error];
    }
}

-(void)cancle
{
    if (_URLConnection) {
        [_URLConnection cancel];
        [_URLConnection release];
        _URLConnection=nil;
    }
}

-(void)dealloc
{
    [self cancle];
    self.receivedData=nil;
    [super dealloc];
}

@end
