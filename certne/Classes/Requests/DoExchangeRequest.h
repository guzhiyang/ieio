//
//  DoExchangeRequest.h
//  certne
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoExchangeResponseParser.h"

@protocol DoExchangeRequestDelegate;

@interface DoExchangeRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnetion;
    
    __unsafe_unretained id<DoExchangeRequestDelegate>   _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<DoExchangeRequestDelegate>   delegate;

/**
 *	@brief	完成交换请求
 *
 *	@param 	sessionid 	登录标识
 *	@param 	uid 	用户id
 */
-(void)sendDoExchangeRequestWithSessionid:(NSString *)sessionid Uid:(NSString *)uid;

/**
 *	@brief	释放链接
 */
-(void)cancle;

@end

@protocol DoExchangeRequestDelegate <NSObject>

-(void)DoExchangeRequestDidFinished:(DoExchangeRequest *)doExchangeRequest doExchangeResponse:(StatusResponse *)doExchangeResponse;

-(void)DoExchangeRequestDidFailed:(DoExchangeRequest *)doExchagneRequest error:(NSError *)error;

@end
