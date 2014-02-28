//
//  StatusResponse.h
//  certne
//
//  Created by apple on 13-12-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusResponse : NSObject
{
    NSInteger       _status;
    NSString        *_msg;
}

@property (assign, nonatomic) NSInteger     status;
@property (copy, nonatomic) NSString        *msg;

@end
