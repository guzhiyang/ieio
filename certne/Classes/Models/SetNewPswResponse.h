//
//  SetNewPswResponse.h
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@interface SetNewPswResponse : StatusResponse
{
    NSString        *_sessionid;
}

@property (copy, nonatomic) NSString        *sessionid;

@end
