//
//  NewPswCheckRequest.h
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SayHelloResponseParser.h"

@protocol NewPswCheckRequestDelegate;

@interface NewPswCheckRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<NewPswCheckRequestDelegate>      _delegate;
}

@property (retain, nonatomic) NSMutableData                     *receivedData;
@property (assign, nonatomic) id<NewPswCheckRequestDelegate >   delegate;

-(void)sendNewPswCheckRequestWith:(NSString *)mobile code:(NSInteger)code;
-(void)cancle;

@end

@protocol NewPswCheckRequestDelegate <NSObject>

-(void)newPswCheckRequestDidFinished:(NewPswCheckRequest *)newPswCheckRequest sayHelloResponse:(StatusResponse *)sayHelloResponse;
-(void)newPswCheckRequestDidFialed:(NewPswCheckRequest *)newPswCheckRequest error:(NSError *)error;

@end
