//
//  ImageDownLoadRequestOperation.m
//  certne
//
//  Created by apple on 13-11-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ImageDownLoadRequestOperation.h"
#define DownLoadImageTimeOut 30

@interface ImageDownLoadRequestOperation()

-(void)timeout;

@property (assign) BOOL     complete;

@end

@implementation ImageDownLoadRequestOperation
@synthesize delegate = _delegate;
@synthesize complete;

-(id)initWithImageURLString:(NSString *)imageURL
{
//    NSAssert(imageURL=nil, @"imageURL 不可以为nil");
    if (self=[super init]) {
        _URLString = [imageURL copy];
    }
    return self;
}

-(void)cancleDownLoadImage
{
    if (_URLConnection) {
        [_URLConnection cancel];
        _URLConnection=nil;
    }
}

-(void)resetConnection
{
    [self cancleDownLoadImage];
}

-(void)main
{
    [self setComplete:NO];
    
    NSURL   *URL=[NSURL URLWithString:_URLString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    [request setTimeoutInterval:DownLoadImageTimeOut];
//    [request setHTTPMethod:@"GET"];
    [self resetConnection];
    _URLConnection=[[NSURLConnection alloc] initWithRequest:request
                                                   delegate:self
                                           startImmediately:YES];
    CFRunLoopRun();
}

-(void)timeout
{
    NSLog(@"超出时间限制!");
}

-(BOOL)isExecuting
{
    return !complete;
}

-(BOOL)isFinished
{
    return complete;
}

-(BOOL)isConcurrent
{
    return YES;
}

#pragma mark- urlconnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        _receivedImageData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedImageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(downLoadImageSuccess:withImageData:)]) {
        [_delegate downLoadImageSuccess:_URLString withImageData:_receivedImageData];
    }
    [self setComplete:YES];
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(downLoadImageFaild:withError:)]) {
        [_delegate downLoadImageFaild:_URLString withError:error];
    }
    [self setComplete:YES];
    CFRunLoopStop(CFRunLoopGetCurrent());
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
    [self cancleDownLoadImage];
    [self resetConnection];
    if (_receivedImageData) {
        _receivedImageData = nil;
    }
}

@end
