//
//  HeadImageDownLoader.m
//  certne
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HeadImageDownLoader.h"

@implementation HeadImageDownLoader
@synthesize receivedData=_receivedData;
@synthesize URLString=_URLString;
@synthesize totalLength=_totalLength;

-(id)initWithURLString:(NSString *)URLString delegate:(id<HeadImageDownLoaderDelegate>)delegate
{
    self=[super init];
    if (self) {
        self.URLString=URLString;
        self.delegate=delegate;
        
        NSString *encodedURLString=[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *URL=[NSURL URLWithString:encodedURLString];
        NSMutableURLRequest *URLRequest=[NSMutableURLRequest requestWithURL:URL];
        [URLRequest setHTTPMethod:@"GET"];
        [URLRequest setTimeoutInterval:60];
        [URLRequest setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];//--忽略远程和本地数据直接从地址下载
        _URLConnection=[[NSURLConnection alloc]initWithRequest:URLRequest
                                                      delegate:self
                                              startImmediately:YES];
    }
    return self;
}

-(void)cancle
{
    if (_URLConnection) {
        [_URLConnection cancel];
        [_URLConnection release];
        _URLConnection = nil;
    }
}

#pragma mark- NSURLConnectionDataDelegate methods

//--返回下载头像的进度
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *HTTPURLResponse=(NSHTTPURLResponse *)response;
    if (HTTPURLResponse.statusCode==200) {
        _totalLength=HTTPURLResponse.expectedContentLength;
        if (_totalLength==NSURLResponseUnknownLength) {
            
        }
        self.receivedData=[NSMutableData data];
    }else{
        if ([(NSObject *)_delegate respondsToSelector:@selector(downLoaderFaild:error:)]) {
            [_delegate downLoaderFaild:self error:nil];
        }
    }
}

//--得到用户头像数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(downLoaderReceivedData:)]) {
            [_delegate downLoaderReceivedData:self];
        }
    }
}

//--用户头像下载结束操作
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(downLoadFinish:)]) {
            [_delegate downLoadFinish:self];
        }
    }
}

//--错误信息返回
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate) {
        if ([(NSObject *)_delegate respondsToSelector:@selector(downLoaderFaild:error:)]) {
            [_delegate downLoaderFaild:self error:error];
        }
    }
}

#pragma mark-Memory management methods

-(void)dealloc
{
    [self cancle];
    self.receivedData = nil;
    self.URLString    = nil;
    
    [super dealloc];
}


@end
