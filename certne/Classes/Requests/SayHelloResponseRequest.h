//
//  SayHelloResponseRequest.h
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SayHelloResponseParser.h"

@protocol SayHelloResponseRequestDelegate;

@interface SayHelloResponseRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    __unsafe_unretained id<SayHelloResponseRequestDelegate>     _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<SayHelloResponseRequestDelegate>       delegate;

-(void)sendSayHelloResponseRequestWithMobile:(NSString *)mobile session_id:(NSString *)session_id auid:(NSInteger)auid message:(NSString *)message;

-(void)cancle;

@end

@protocol SayHelloResponseRequestDelegate <NSObject>

-(void)SayHelloResponseRequestDidFinished:(SayHelloResponseRequest *)sayhelloResponseRequest sayhelloResponse:(StatusResponse *)sayHelloResponse;

-(void)SayHelloResponseRequestDidFailed:(SayHelloResponseRequest *)sayhelloResponseRequest error:(NSError *)error;

@end
