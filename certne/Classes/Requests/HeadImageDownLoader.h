//
//  HeadImageDownLoader.h
//  certne
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HeadImageDownLoaderDelegate;

@interface HeadImageDownLoader : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection         *_URLConnection;
    NSMutableData           *_receivedData;
    NSString                *_URLString;
    long long               _totalLength;
    __unsafe_unretained id<HeadImageDownLoaderDelegate>  _delegate;
}

@property(strong,nonatomic) NSMutableData       *receivedData;
@property(copy,  nonatomic) NSString            *URLString;
@property(assign,nonatomic) long long           totalLength;
@property(assign,nonatomic) id<HeadImageDownLoaderDelegate>  delegate;

-(id)initWithURLString:(NSString *)URLString delegate:(id<HeadImageDownLoaderDelegate>)delegate;

-(void)cancle;

@end

@protocol HeadImageDownLoaderDelegate <NSObject>

-(void)downLoaderReceivedData:(HeadImageDownLoader *)downLoader;
-(void)downLoadFinish:(HeadImageDownLoader *)downLoader;
-(void)downLoaderFaild:(HeadImageDownLoader *)downLoader error:(NSError *)error;

@end
