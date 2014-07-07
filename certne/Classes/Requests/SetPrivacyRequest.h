//
//  SetPrivacyRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemSet.h"

@protocol SetPrivacyRequestDelegate;

@interface SetPrivacyRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_urlConnection;
    
    __unsafe_unretained id<SetPrivacyRequestDelegate>   _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<SetPrivacyRequestDelegate>     delegate;

-(void) sendSetPrivacyRequestWithMobile:(NSString *)mobile session_id:(NSString *)session_id is_sharing_info:(NSInteger)is_sharing_info is_allow_add:(NSInteger)is_allow_add is_allow_search:(NSInteger)is_allow_search is_recommend_user:(NSInteger)is_recommend_user;

-(void) cancle;

@end

@protocol SetPrivacyRequestDelegate <NSObject>

-(void)SetPrivacyRequestDidFinished:(SetPrivacyRequest *)setPrivacyRequest systemSet:(SystemSet *)systemSet;

-(void)SetPrivacyRequestDidFailed:(SetPrivacyRequest *)setPrivacyRequest error:(NSError *)error;

@end
