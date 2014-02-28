//
//  ImageDownLoader.h
//  certne
//
//  Created by apple on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageDownLoaderDelegate;

@interface ImageDownLoader : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection         *_URLConnection;
    NSMutableData           *_receivedData;
    NSString                *_URLString;
    long long               _totalLength;
    id<ImageDownLoaderDelegate>     _delegate;
}

@property (retain, nonatomic) NSMutableData                 *receivedData;
@property (copy, nonatomic) NSString                        *URLString;
@property (assign, nonatomic) long long                     totalLength;
@property (assign, nonatomic) id<ImageDownLoaderDelegate>   delegate;

-(id)initWithURLString:(NSString *)URLString delegate:(id<ImageDownLoaderDelegate>)delegate;

-(void)cancle;

@end

@protocol ImageDownLoaderDelegate <NSObject>

-(void)downLoaderReceivedData:(ImageDownLoader*)downLoader;
-(void)downLoadFinish:(ImageDownLoader *)downLoader;
-(void)downLoaderFaild:(ImageDownLoader *)downLoader error:(NSError *)error;

@end
