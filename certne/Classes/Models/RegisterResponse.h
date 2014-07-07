//
//  RegisterResponse.h
//  certne
//
//  Created by apple on 13-11-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@interface RegisterResponse : StatusResponse
{
    NSInteger       _code;
}

@property (assign, nonatomic) NSInteger     code;

@end
