//
//  ImageDownLoadRequestOperation.h
//  certne
//
//  Created by apple on 13-11-22.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol   ImageDownLoadRequestDelegate;

@interface ImageDownLoadRequestOperation : NSOperation
{
    NSString            *_URLString;
    NSURLConnection     *_URLConnection;
    NSMutableData       *_receivedImageData;
    
    //--当请求失败或者成功结束 complete = true
    BOOL                complete;
    id<ImageDownLoadRequestDelegate>    _delegate;
}

@property (assign, readonly) BOOL      complete;
@property (assign, nonatomic) id<ImageDownLoadRequestDelegate>  delegate;

-(id)initWithImageURLString:(NSString *)imageURL;
-(void)cancleDownLoadImage;
-(void)resetConnection;

@end


@protocol ImageDownLoadRequestDelegate <NSObject>

-(void)downLoadImageSuccess:(NSString *)imageURL withImageData:(NSData *)imageData;
-(void)downLoadImageFaild:(NSString *)imageURL withError:(NSError *)error;

@end
