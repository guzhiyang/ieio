//
//  CheckCodeRequest.h
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckCodeResponse.h"

@protocol CheckCodeRequestDelegate;

@interface CheckCodeRequest : NSObject
{
    NSMutableData                   *_receivedData;
    NSURLConnection                 *_URLConnection;
    id<CheckCodeRequestDelegate>    _delegate;
}

@property (retain, nonatomic) NSMutableData                 *receivedData;
@property (assign, nonatomic) id<CheckCodeRequestDelegate>  delegate;

-(void)sendCheckCodeRequestWithCode:(NSString *)code mobile:(NSString *)mobile;
-(void)cancle;

@end

@protocol CheckCodeRequestDelegate <NSObject>

-(void)checkCodeRequestDidFinished:(CheckCodeRequest *)checkCodeRequest  checkCodeResponse:(CheckCodeResponse *)checkCodeResponse;
-(void)checkCodeRequestDIDFaild:(CheckCodeRequest *)checkCodeRequest error:(NSError *)error;

@end
