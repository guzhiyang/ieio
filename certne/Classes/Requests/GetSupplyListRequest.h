//
//  GetSupplyListRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicInfoResponseParser.h"

@protocol GetSupplyListRequestDelegate;

@interface GetSupplyListRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    __unsafe_unretained id<GetSupplyListRequestDelegate>    _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<GetSupplyListRequestDelegate>    delegate;

/**
 *	@brief	发送获取好友供求信息列表
 *
 *	@param 	mobile 	用户手机号
 *	@param 	sessionid 	用户登陆标识
 */
-(void)sendPublicBuinessMessageRequestWithSessionid:(NSString *)sessionid;

/**
 *	@brief	释放请求
 */
-(void)cancle;

@end

@protocol GetSupplyListRequestDelegate <NSObject>

-(void)getSupplyListRequestDidFinished:(GetSupplyListRequest *)getSupplyListRequest publicInfoResponse:(PublicInfoResponse *)publicInfoResponse;

-(void)getSupplyListRequestDidFailed:(GetSupplyListRequest *)getSupplyListRequest error:(NSError *)error;

@end
