//
//  CardDoExchangeRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeCardResponseParser.h"

@protocol CardDoExchangeRequestDelegate;

@interface CardDoExchangeRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<CardDoExchangeRequestDelegate>   _delegate;
}

@property (retain, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<CardDoExchangeRequestDelegate>     delegate;

/**
 *	@brief	发送请求
 *
 *	@param 	sessionid 	登录标识
 *	@param 	longitude 	x坐标
 *	@param 	latitude 	y坐标
 */
-(void)sendCardDoExchangeRequestWithSessionid:(NSString *)sessionid longitude:(CGFloat)longitude latitude:(CGFloat)latitude;

/**
 *	@brief	断开链接
 */
-(void)cancle;

@end

@protocol CardDoExchangeRequestDelegate <NSObject>

/**
 *	@brief	交换请求发送成功
 *
 *	@param 	cardDoExchangeRequest 	CardDoExchangeRequest
 *	@param 	changeCardResponse 	返回结果
 */
-(void)CardDoExchangeRequestDidFinished:(CardDoExchangeRequest *)cardDoExchangeRequest changeCardResponse:(StatusResponse *)changeCardResponse;

/**
 *	@brief	交换请求发送失败
 *
 *	@param 	cardDoExchangeRequest 	CardDoExchangeRequest
 *	@param 	error 	返回错误信息
 */
-(void)CardDoExchangeRequestDidFailed:(CardDoExchangeRequest *)cardDoExchangeRequest error:(NSError *)error;

@end
