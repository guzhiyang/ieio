//
//  UpdateFriendsInfoRequest.h
//  certne
//
//  Created by apple on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponseParser.h"

@protocol UpdateFriendsInfoRequestDelegate;

@interface UpdateFriendsInfoRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    __unsafe_unretained id<UpdateFriendsInfoRequestDelegate>    _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<UpdateFriendsInfoRequestDelegate>  delegate;

-(void)sendUpdateFriendsInfoRequestWithSessionid:(NSString *)sessionid uid:(NSInteger)uid;

-(void)cancle;

@end

@protocol UpdateFriendsInfoRequestDelegate <NSObject>

-(void)updateFriendsInfoRequestDidFinished:(UpdateFriendsInfoRequest *)updateFriendsInfoRequest status:(StatusResponse *)status;

-(void)updateFriendsInfoRequestDidFailed:(UpdateFriendsInfoRequest *)updateFriendsInfoRequest error:(NSError *)error;

@end
