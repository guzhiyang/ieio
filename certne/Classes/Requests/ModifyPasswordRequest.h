//
//  ModifyPasswordRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponseParser.h"

@protocol ModifyPasswordRequestDelegate;

@interface ModifyPasswordRequest : NSObject
{
    NSMutableData       *_recevedData;
    NSURLConnection     *_URLConnetion;
    
    __unsafe_unretained id<ModifyPasswordRequestDelegate>    _delegate;
}

@property (strong, nonatomic) NSMutableData     *recevedData;
@property (assign, nonatomic) id<ModifyPasswordRequestDelegate>     delegate;

-(void)sendModifyPasswordRequestWithSessionid:(NSString *)sessionid newPassword:(NSString *)newPassword;

-(void)cancle;

@end

@protocol ModifyPasswordRequestDelegate <NSObject>

-(void)modifyPasswordRequestDidFinished:(ModifyPasswordRequest *)modifyPasswordResquest statusResponse:(StatusResponse *)statusResponse;
-(void)modifyPasswordRequestDidFailed:(ModifyPasswordRequest *)modifyPasswordResquest error:(NSError *)error;

@end
