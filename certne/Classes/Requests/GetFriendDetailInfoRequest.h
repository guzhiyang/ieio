//
//  GetFriendDetailInfoRequest.h
//  certne
//
//  Created by apple on 13-12-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendInfoAndMessageParser.h"

@protocol GetFriendDetailInfoRequestDelegate;

@interface GetFriendDetailInfoRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<GetFriendDetailInfoRequestDelegate>      _delegate;
}

@property (retain, nonatomic)NSMutableData      *receivedData;
@property (assign, nonatomic) id<GetFriendDetailInfoRequestDelegate>    delegate;

-(void)sendGetFriendDetailInfoRequestWithSessionid:(NSString *)sessionid fuid:(NSInteger)uid;

-(void)cancle;

@end

@protocol GetFriendDetailInfoRequestDelegate <NSObject>

-(void)GetFriendDetailInfoRequestDidFinished:(GetFriendDetailInfoRequest *)getFriendDetailInfoRequest friendDetailInfo:(FriendInfoAndMessage *)friendDetailInfo;

-(void)GetFriendDetailInfoRequestDidFailed:(GetFriendDetailInfoRequest *)getFriendDetailInfoRequest error:(NSError *)error;

@end
