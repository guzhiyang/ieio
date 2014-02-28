//
//  AddToContactListRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponseParser.h"

@protocol AddToContactListRequestDelegate;

@interface AddToContactListRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnetion;
    
    id<AddToContactListRequestDelegate>     _delegate;
}

@property (retain, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<AddToContactListRequestDelegate>   delegate;

-(void)sendAddToContactListRequestWithSessionID:(NSString *)sessionID cuid:(NSInteger)cuid;

-(void)cancle;

@end

@protocol AddToContactListRequestDelegate <NSObject>

-(void)addToContactListRequestDidFinished:(AddToContactListRequest *)addToContactListRequest response:(StatusResponse *)response;

-(void)addToContactListRequestDidFailed:(AddToContactListRequest *)addToContactListRequest error:(NSError *)error;

@end