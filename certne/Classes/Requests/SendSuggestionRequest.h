//
//  SendSuggestionRequest.h
//  certne
//
//  Created by apple on 13-11-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponseParser.h"

@protocol SendSuggestionRequestDelegate;

@interface SendSuggestionRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    __unsafe_unretained id<SendSuggestionRequestDelegate>   _delegate;
}

@property (strong, nonatomic) NSMutableData     *receivedData;
@property (assign, nonatomic) id<SendSuggestionRequestDelegate>     delegate;

-(void)sendSuggestionRequestWithMobile:(NSString *)mobile sessionid:(NSString *)sessionid suggestion:(NSString *)suggestion;

-(void)cancle;

@end

@protocol SendSuggestionRequestDelegate <NSObject>

-(void)sendSuggestionRequestDidFinished:(SendSuggestionRequest *)sendSuggestionRequest statusResponse:(StatusResponse *)statusResponse;
-(void)sendSuggestionRequestDidFailed:(SendSuggestionRequest *)sendSuggestionRequest error:(NSError *)error;

@end
