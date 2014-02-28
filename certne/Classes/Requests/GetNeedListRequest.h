//
//  GetNeedListRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicInfoResponseParser.h"

@protocol GetNeedListRequestDelegate;

@interface GetNeedListRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<GetNeedListRequestDelegate>      _delegate;
}

@property (retain, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<GetNeedListRequestDelegate>    delegate;

-(void)sendGetNeedListRequestWithSessionid:(NSString *)sessionid;

-(void)cancle;

@end

@protocol GetNeedListRequestDelegate <NSObject>

-(void)getNeedListRequestDidFinished:(GetNeedListRequest *)getNeedListRequest publicInfoResponse:(PublicInfoResponse *)publicInfoResponse;

-(void)getNeedListRequestDidFailed:(GetNeedListRequest *)getNeedListRequest error:(NSError *)error;

@end
