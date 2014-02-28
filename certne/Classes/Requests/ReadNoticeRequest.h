//
//  ReadNoticeRequest.h
//  certne
//
//  Created by apple on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@protocol ReadNoticeRequestDelegate;

@interface ReadNoticeRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<ReadNoticeRequestDelegate>   _delegate;
}

@property (retain, nonatomic) NSMutableData                     *receivedData;
@property (assign, nonatomic) id<ReadNoticeRequestDelegate>     delegate;

-(void)sendReadNoticeRequestWithSessionID:(NSString *)sessionID;

-(void)cancle;

@end

@protocol ReadNoticeRequestDelegate <NSObject>

-(void)readNoticeRequestDidFinish:(ReadNoticeRequest *)readNoticeRequest statusResponse:(StatusResponse *)statusResponse;

-(void)readNoticeRequestDidFailed:(ReadNoticeRequest *)readNoticeRequest error:(NSError *)error;

@end