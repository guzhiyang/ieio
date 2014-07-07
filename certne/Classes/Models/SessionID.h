//
//  SessionID.h
//  certne
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface SessionID : User
{
    NSString        *_sessionID;
}
@property (copy, nonatomic) NSString        *sessionID;

@end
