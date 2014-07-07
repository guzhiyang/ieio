//
//  PublicInfoResponse.h
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicInfo.h"
#import "StatusResponse.h"

@interface PublicInfoResponse : StatusResponse
{
    NSArray     *_dataArray;
    PublicInfo  *_publicInfo;
}

@property (strong, nonatomic) NSArray       *dataArray;
@property (strong, nonatomic) PublicInfo    *publicInfo;

@end
