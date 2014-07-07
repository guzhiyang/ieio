//
//  PublishMessageRequest.h
//  certne
//
//  Created by apple on 13-12-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponseParser.h"

@protocol PublishMessageRequestDelegate;

@interface PublishMessageRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    __unsafe_unretained id<PublishMessageRequestDelegate>   _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<PublishMessageRequestDelegate>     delegate;

-(void)sendPublishMessageRequestWithMobile:(NSString *)mobile sessionid:(NSString *)sessionid imagesUrl:(NSString *)imageUrl desc:(NSString *)desc type:(NSInteger)type longitude:(CGFloat)longitude latitude:(CGFloat)latitude;

-(void)cancle;

@end

@protocol PublishMessageRequestDelegate <NSObject>

-(void)publishMessageRequestDidFinished:(PublishMessageRequest *)publishMessageRequest statusResponse:(StatusResponse *)statusResponse;

-(void)publishMessageRequestDidFailed:(PublishMessageRequest *)publishMessageRequest error:(NSError *)error;

@end
