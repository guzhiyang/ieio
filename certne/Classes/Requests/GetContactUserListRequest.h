//
//  GetContactUserListRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecentContactUserListParser.h"

@protocol GetContactUserListRequestDelegate;

@interface GetContactUserListRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<GetContactUserListRequestDelegate>       _delegate;
}

@property (retain, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<GetContactUserListRequestDelegate>     delegate;

-(void)sendGetContactUserListRequestWithSessionid:(NSString *)sessionid;

-(void)cancle;

@end

@protocol GetContactUserListRequestDelegate <NSObject>

-(void)GetContactUserListRequestDidFinished:(GetContactUserListRequest *)getContactUserListRequest recentContactUserList:(RecentContactUserList *)recentContactUserList;

-(void)GetContactUserListRequestDidFailed:(GetContactUserListRequest *)getContactUserListRequest error:(NSError *)error;

@end
