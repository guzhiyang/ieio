//
//  FindPswRequest.h
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindPswResponseParser.h"

@protocol FindPswRequestDelegate;

@interface FindPswRequest : NSObject
{
    NSMutableData       *_receivedData;
    NSURLConnection     *_URLConnection;
    
    id<FindPswRequestDelegate>      _delegate;
}

@property (retain, nonatomic) NSMutableData                 *receivedData;
@property (assign, nonatomic) id<FindPswRequestDelegate >   delegate;

-(void)sendFindPswRequestWithMobile:(NSString *)mobile;

-(void)cancle;

@end

@protocol FindPswRequestDelegate <NSObject>

-(void)FindPswRequestDidFinished:(FindPswRequest *)findPswRequest findPswResponse:(FindPswResponse *)findPswResponse;

-(void)FindPswRequestDIdFailed:(FindPswRequest *)findPswRequest error:(NSError *)error;

@end

