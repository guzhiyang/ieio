//
//  RegisterRequest.h
//  certne
//
//  Created by apple on 13-11-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterResponse.h"

@protocol RegisterRequestDelegate;

@interface RegisterRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_urlConnection;
    
    __unsafe_unretained id<RegisterRequestDelegate>     _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<RegisterRequestDelegate>   delegate;

-(void)sendRegiseterMoileNumber:(NSString *)mobileNumber password:(NSString *)passWord;
-(void)cancle;

@end

@protocol RegisterRequestDelegate <NSObject>

-(void)connectionDidFinisnedWithRegister:(RegisterRequest *)registerRequest registerResponse:(RegisterResponse *)registerResponse;
-(void)connectionDidFailed:(RegisterRequest *)registerRequest error:(NSError *)error;

@end
