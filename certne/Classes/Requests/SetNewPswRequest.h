//
//  SetNewPswRequest.h
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetNewPswResponseParser.h"

@protocol SetNewPswRequestDelegate;

@interface SetNewPswRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<SetNewPswRequestDelegate>    _delegate;
}

@property (retain, nonatomic) NSMutableData                 *receivedData;
@property (assign, nonatomic) id<SetNewPswRequestDelegate>  delegate;

-(void)sendSetNewPswRequestWithMobile:(NSString *)mobile code:(NSInteger)code newPsw:(NSString *)newPsw;

-(void)cancle;

@end

@protocol SetNewPswRequestDelegate <NSObject>

-(void)SetNewPswRequestDidFinished:(SetNewPswRequest *)setNewPswRequest setNewPswResponse:(SetNewPswResponse *)setNewPswResponse;
-(void)SetNewPswRequestDidFailed:(SetNewPswRequest *)setNewPswRequest error:(NSError *)error;

@end