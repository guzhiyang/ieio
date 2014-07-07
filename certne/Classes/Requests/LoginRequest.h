//
//  LoginRequest.h
//  certne
//
//  Created by apple on 13-8-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TapkuLibrary.h"
#import "LoginUserInfo.h"

@protocol LoginRequestDelegate;

@interface LoginRequest : NSObject
{
    NSURLConnection  *_URLConnection;
    NSMutableData    *_receivedData;
    
    UIWindow        *_window;
    NSLock          *_lock;
}

@property (assign, nonatomic) id<LoginRequestDelegate>  delegate;
@property (strong, nonatomic) NSMutableData     *receivedData;
@property (strong, nonatomic) UIView            *backgroundView;
@property (strong, nonatomic) TKLoadingView     *loadingView;
@property (assign, nonatomic) BOOL      activity_hidden;
@property (assign, nonatomic) BOOL      background_hidden;
@property (assign, nonatomic) BOOL      request_cancle;

+(LoginRequest *)shareRequest;

//--发送登录请求，发送用户的手机号和密码
-(void)sendLoginRequestWithUseMobile:(NSString *)mobile password:(NSString *)password;
//--释放连接
-(void)cancle;

@end

@protocol LoginRequestDelegate <NSObject>

//--请求开始
-(void)loginRequestStart:(LoginRequest *)request;

//--请求结束时的操作代理
-(void)loginRequestFinished:(LoginRequest *)request loginUserInfo:(LoginUserInfo *)loginUserInfo;

//--请求失败时，输出错误提示代码
-(void)loginRequestFailed:(LoginRequest *)request error:(NSError *)error;

@end

