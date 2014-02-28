//
//  DeleteContactLogRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponseParser.h"

@protocol DeleteContactLogRequestDelegate;

@interface DeleteContactLogRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<DeleteContactLogRequestDelegate>     _delegate;
}

@property (retain, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<DeleteContactLogRequestDelegate>   delegate;

/**
 *	@brief	向服务器发送post请求，删除联系信息
 *
 *	@param 	sessionid 	登陆标识
 *	@param 	contactMobiles 	多个电话号码以逗号隔开，单个号码不需要
 */
-(void)sendDeleteContactLogRequestWithSessionid:(NSString *)sessionid contacts_mobiles:(NSString *)contactMobiles;

-(void)cancle;

@end

@protocol DeleteContactLogRequestDelegate <NSObject>

-(void)DeleteContactLogRequestDidFinished:(DeleteContactLogRequest *)deleteContactLogRequest status:(StatusResponse *)status;

-(void)DeleteContactLogRequestDidFailed:(DeleteContactLogRequest *)deleteContactLogRequest error:(NSError *)error;

@end
