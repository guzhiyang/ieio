//
//  SaveUserInfoRequest.h
//  certne
//
//  Created by apple on 13-12-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"
#import "Foundation.h"

@protocol SaveUserInfoRequestDelegate;

@interface SaveUserInfoRequest : NSObject
{
    NSURLConnection                 *_URLConnection;
    NSMutableData                   *_receivedData;
    
    id<SaveUserInfoRequestDelegate> _delegate;
}

@property (retain, nonatomic) NSMutableData                     *receivedData;
@property (assign, nonatomic) id<SaveUserInfoRequestDelegate>   delegate;

/**
 *	@brief	上传用户信息
 *
 *	@param 	avatar      头像地址
 *	@param 	name        登录链接标识
 *	@param 	name        姓名
 *	@param 	position 	职位
 *	@param 	company 	公司
 *	@param 	mobile      手机
 *	@param 	telphone 	电话
 *	@param 	fax         传真
 *	@param 	email       邮箱
 *	@param 	qq          qq
 *	@param 	department 	部门
 *	@param 	industry 	行业
 *	@param 	website 	网址
 *	@param 	address 	地址
 *	@param 	zipcode 	邮编
 */
-(void)sendSaveUserInfoRequestWithUserAvatar:(NSString *)avatar sessionid:(NSString *)sessionid name:(NSString *)name position:(NSString *)position company:(NSString *)company mobile:(NSString *)mobile telphone:(NSString *)telphone fax:(NSString *)fax email:(NSString *)email qq:(NSString *)qq department:(NSString *)department industry:(NSString *)industry website:(NSString *)website address:(NSString *)address zipcode:(NSInteger)zipcode;

/**
 *	@brief	断开连接
 */
-(void)cancle;

@end

@protocol SaveUserInfoRequestDelegate <NSObject>

-(void)SaveUserInfoRequestDidFinished:(SaveUserInfoRequest *)saveUserInfoRequest saveUserInfoResponse:(StatusResponse *)response;
-(void)SaveUserInfoRequestDidFailed:(SaveUserInfoRequest *)saveUserInfoRequest error:(NSError *)error;

@end
