//
//  SetNewPswResponse.h
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetNewPswResponse : NSObject
{
    NSInteger       _status;
    NSString        *_msg;
    NSString        *_sessionid;
}

@property (assign, nonatomic) NSInteger     status;
@property (copy, nonatomic) NSString        *msg;
@property (copy, nonatomic) NSString        *sessionid;

@end
