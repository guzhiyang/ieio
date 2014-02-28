//
//  AgreeInviteRequest.h
//  certne
//
//  Created by apple on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@protocol AgreeInviteRequestDelegate;

@interface AgreeInviteRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;

    id<AgreeInviteRequestDelegate>      _delegate;
}

@property (retain, nonatomic) NSMutableData                     *receivedData;
@property (assign, nonatomic) id<AgreeInviteRequestDelegate>    delegate;

-(void)sendAgreeInviteRequestWithSessionID:(NSString *)sessionID fuid:(NSInteger)fuid;

-(void)cancle;

@end

@protocol AgreeInviteRequestDelegate <NSObject>

-(void)agreeInviewRequestDidFinish:(AgreeInviteRequest *)agreeInviteRequest statusResponse:(StatusResponse *)statusResponse;

-(void)agreeInviewRequestDidFailed:(AgreeInviteRequest *)agreeInviteRequest error:(NSError *)error;

@end
