//
//  ImageDownLoadQueue.h
//  certne
//
//  Created by apple on 13-11-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownLoadRequestOperation.h"

@protocol   ImageDownLoadQueueDelegate;

@interface ImageDownLoadQueue : NSObject<ImageDownLoadRequestDelegate>
{
    NSOperationQueue        *_downLoadQueue;
    NSMutableDictionary     *_cacheDictionary;
    id<ImageDownLoadQueueDelegate>      _delegate;
}

@property (assign, nonatomic) id<ImageDownLoadQueueDelegate>    delegate;

-(id)initWithConcurrent:(NSInteger)concurrent delegate:(id<ImageDownLoadQueueDelegate>)aDelegate;
-(BOOL)addImageURL:(NSString *)imageURL;

@end

@protocol ImageDownLoadQueueDelegate <NSObject>

-(void)downLoadImageSuccess:(NSString *)imageURL imageData:(NSData *)imageData;
-(void)downLoadImageFailed:(NSString *)imageURL error:(NSError *)error;

@end
