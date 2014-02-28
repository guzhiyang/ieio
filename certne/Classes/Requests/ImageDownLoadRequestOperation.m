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

@property (assign) BOOL     complete;//--真搞不懂这样写几个意思？

@end

@implementation ImageDownLoadRequestOperation
@synthesize delegate=_delegate;
@synthesize complete;

-(id)initWithImageURLString:(NSString *)imageURL
{
//    NSAssert(imageURL=nil, @"imageURL 不可以为nil");
    if (self=[super init]) {
        _URLString=[imageURL retain];
    }
    return self;
}

-(void)cancleDownLoadImage
{
    if (_URLConnection) {
        [_URLConnection cancel];
        [_URLConnection release];
        _URLConnection=nil;
    }
}

-(void)resetConnection
{
    [self cancleDownLoadImage];
}

-(void)main
{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    [self setComplete:NO];
    
    NSURL   *URL=[NSURL URLWithString:_URLString];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:URL];
    [request setTimeoutInterval:DownLoadImageTimeOut];
//    [request setHTTPMethod:@"GET"];
    [self resetConnection];
    _URLConnection=[[NSURLConnection alloc] initWithRequest:request
                                                   delegate:self
                                           startImmediately:YES];
    CFRunLoopRun();
    [pool release];
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
    if (httpResponse.statusCode==200) {
        _receivedImageData=[[NSMutableData data] retain];
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
    [self resetConnection];
    if (_receivedImageData) {
        [_receivedImageData release];
        _receivedImageData=nil;
    }
    [_URLString release];
    [super dealloc];
}

@end
