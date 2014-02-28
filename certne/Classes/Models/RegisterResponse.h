//
//  RegisterResponse.h
//  certne
//
//  Created by apple on 13-11-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterResponse : NSObject
{
    NSInteger       _status;
    NSString        *_msg;
    NSInteger       _code;
}

@property (assign, nonatomic) NSInteger     status;
@property (copy, nonatomic) NSString        *msg;
@property (assign, nonatomic) NSInteger     code;

@end
