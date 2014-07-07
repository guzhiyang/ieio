//
//  LoginOutRequest.h
//  certne
//
//  Created by apple on 14-1-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginOutRequestDelegate;

@interface LoginOutRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnetion;
    
    __unsafe_unretained id<LoginOutRequestDelegate>     _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<LoginOutRequestDelegate>   delegate;

-(void)sendLoginOutRequestWithSessionID:(NSString *)sessionID;

-(void)cancle;

@end

@protocol LoginOutRequestDelegate <NSObject>

-(void)loginOutRequestDidFinished:(LoginOutRequest *)loginOutRequest;

-(void)loginOutRequestDidFinished:(LoginOutRequest *)loginOutRequest error:(NSError *)error;

@end