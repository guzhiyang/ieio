//
//  FindPswResponse.h
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindPswResponse : NSObject
{
    NSInteger       _status;
    NSString        *_msg;
    NSInteger       _code;
}

@property (assign, nonatomic) NSInteger     status;
@property (copy, nonatomic) NSString        *msg;
@property (assign, nonatomic) NSInteger     code;

@end
