//
//  GetMyFriendsInfoRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyFriendsInfoList.h"

@protocol GetMyFriendsInfoRequestDelegate;

@interface GetMyFriendsInfoRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<GetMyFriendsInfoRequestDelegate>     _delegate;
}

@property (retain, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<GetMyFriendsInfoRequestDelegate>   delegate;

-(void) sendGetMyFriendsInfoRequestWithSessionid:(NSString *)sessionid;

-(void) cancle;

@end

@protocol GetMyFriendsInfoRequestDelegate <NSObject>

-(void) GetMyFriendsInfoRequestDidFinished:(GetMyFriendsInfoRequest *)getMyFriendInfoRequest myFriendsInfoList:(MyFriendsInfoList*)myFriendsInfoList;
-(void) GetMyFriendsInfoRequestDidFailed:(GetMyFriendsInfoRequest *)getMyFriendInfoRequest error:(NSError *)error;

@end