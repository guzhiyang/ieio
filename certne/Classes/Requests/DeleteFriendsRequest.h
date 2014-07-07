//
//  DeleteFriendsRequest.h
//  certne
//
//  Created by apple on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponseParser.h"

@protocol DeleteFriendsRequestDelegate;

@interface DeleteFriendsRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    __unsafe_unretained id<DeleteFriendsRequestDelegate>    _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<DeleteFriendsRequestDelegate>      delegate;

-(void)sendDeleteFriendsRequestWithSessionid:(NSString *)sessionid uid:(NSInteger)uid;

-(void)cancle;

@end

@protocol DeleteFriendsRequestDelegate <NSObject>

-(void)deleteFriendsRequestDidFinished:(DeleteFriendsRequest *)deleteFriendsRequest status:(StatusResponse *)status;

-(void)deleteFriendsRequestDidFailed:(DeleteFriendsRequest *)deleteFriendsRequest error:(NSError *)error;

@end
