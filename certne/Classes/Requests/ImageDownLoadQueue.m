//
//  ImageDownLoadQueue.m
//  certne
//
//  Created by apple on 13-11-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ImageDownLoadQueue.h"

@implementation ImageDownLoadQueue
@synthesize delegate=_delegate;

-(id)initWithConcurrent:(NSInteger)concurrent delegate:(id<ImageDownLoadQueueDelegate>)aDelegate
{
    self=[super init];
    if (self) {
        _delegate=aDelegate;
        _cacheDictionary=[[NSMutableDictionary alloc] initWithCapacity:50];
        
        _downLoadQueue=[[NSOperationQueue alloc] init];
        [_downLoadQueue setMaxConcurrentOperationCount:1];
    }
    return self;
}

-(BOOL)addImageURL:(NSString *)imageURL
{
    if (nil==imageURL || 0==[imageURL length])
        return NO;
    
    BOOL ret=YES;
    NSObject    *object=(NSObject *)[_cacheDictionary objectForKey:imageURL];
    if (object) {
        if ([[object class] isSubclassOfClass:[NSData class]]) {
            if (_delegate) {
                NSData *imageData=(NSData *)object;
                [_delegate downLoadImageSuccess:imageURL imageData:imageData];
                ret=YES;
            }else
                ret=NO;
        }else
            ret=YES;
        return ret;
    }
    
    ImageDownLoadRequestOperation *imageDownLoadRequest=[[ImageDownLoadRequestOperation alloc]initWithImageURLString:imageURL];
    imageDownLoadRequest.delegate=self;
    [_downLoadQueue addOperation:imageDownLoadRequest];
    [imageDownLoadRequest release];
    
    NSString *requestingFlag=@"";
    [_cacheDictionary setObject:requestingFlag forKey:imageURL];
    
    return YES;
}

#pragma mark- DownLoadImageRequest delegate methods

-(void)downLoadImageSuccess:(NSString *)imageURL withImageData:(NSData *)imageData
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(downLoadImageSuccess:imageData:)]) {
        [_cacheDictionary setObject:imageData forKey:imageURL];
        [_delegate downLoadImageSuccess:imageURL imageData:imageData];
    }
}

-(void)downLoadImageFaild:(NSString *)imageURL withError:(NSError *)error
{
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(downLoadImageFailed:error:)]) {
        [_delegate downLoadImageFailed:imageURL error:error];
    }
}

#pragma mark- Memory menagement methods

-(void)dealloc
{
    [_cacheDictionary release];
    [_downLoadQueue release];
    
    _cacheDictionary=nil;
    _downLoadQueue=nil;
    [super dealloc];
}

@end
