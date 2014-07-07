//
//  GetNearbyUserListRequest.h
//  certne
//
//  Created by apple on 13-12-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyUserListParser.h"
#import "TapkuLibrary.h"

@protocol GetNearbyUserListRequestDelegate;

@interface GetNearbyUserListRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    TKLoadingView       *_loadingView;
    UIView              *_backgroundView;
    UIWindow            *_window;
    NSLock              *_lock;
    
    __unsafe_unretained id<GetNearbyUserListRequestDelegate>        _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<GetNearbyUserListRequestDelegate>      delegate;
@property (assign, nonatomic) BOOL      activity_hidden;
@property (assign, nonatomic) BOOL      background_hidden;

+(GetNearbyUserListRequest *)shareRequest;

-(void)sendGetNearbyUserListRequestWithSessionid:(NSString *)sessionid longitude:(CGFloat)longitude latitude:(CGFloat)latitude;

-(void)cancle;

@end

@protocol GetNearbyUserListRequestDelegate <NSObject>

-(void)GetNearbyUserListRequestDidFinished:(GetNearbyUserListRequest *)getNearbyUserListRequest nearbyUserList:(NearbyUserList *)nearbyUserList;

-(void)GetNearbyUserListRequestDidFailed:(GetNearbyUserListRequest *)getNearbyUserListRequest error:(NSError *)error;

@end
