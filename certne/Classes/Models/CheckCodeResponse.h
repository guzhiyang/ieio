//
//  CheckCodeResponse.h
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckCodeResponse : NSObject
{
    NSInteger       _status;
    NSString        *_msg;
    NSString        *_session_id;
}

@property (assign, nonatomic) NSInteger     status;
@property (copy, nonatomic) NSString        *msg;
@property (copy, nonatomic) NSString        *session_id;

@end
