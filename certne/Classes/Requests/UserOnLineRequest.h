//
//  UserOnLineRequest.h
//  certne
//
//  Created by apple on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponseParser.h"

@protocol UserOnLineRequestDelegate;

@interface UserOnLineRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<UserOnLineRequestDelegate>   _delegate;
}

@property (retain, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<UserOnLineRequestDelegate>     delegate;

-(void)sendUserOnLineRequestWithSessionID:(NSString *)sessionID longitude:(CGFloat)longitude latitude:(CGFloat)latitude deviceToken:(NSString *)deviceToken;

-(void)cancle;

@end

@protocol UserOnLineRequestDelegate <NSObject>

-(void)userOnLineRequestDidFinished:(UserOnLineRequest *)userOnLineRequest response:(StatusResponse *)response;

-(void)userOnLineRequestDidFailed:(UserOnLineRequest *)userOnLineRequest error:(NSError *)error;

@end