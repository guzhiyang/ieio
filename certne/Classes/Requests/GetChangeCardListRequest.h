//
//  GetChangeCardListRequest.h
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeCardListResponseParser.h"

@protocol GetChangeCardListRequestDelegate;

@interface GetChangeCardListRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    __unsafe_unretained id<GetChangeCardListRequestDelegate>    _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<GetChangeCardListRequestDelegate>  delegate;

/**
 *	@brief	发送获取交换列表请求
 *
 *	@param 	sessionid 	登录标识
 */
-(void)sendGetChangeCardListRequestWithSessionid:(NSString *)sessionid;

/**
 *	@brief	断开链接
 */
-(void)cancle;

@end

@protocol GetChangeCardListRequestDelegate <NSObject>

-(void)GetChangeCardListRequestDidFinished:(GetChangeCardListRequest *)getChangeCardListRequest changeCardListResponse:(ChangeCardListResponse *)cardListResponse;
-(void)GetChangeCardListRequestDidFaild:(GetChangeCardListRequest *)getChangeCardListRequest error:(NSError *)error;

@end
