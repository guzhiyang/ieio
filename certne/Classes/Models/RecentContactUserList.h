//
//  RecentContactUserList.h
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactUser.h"
#import "StatusResponse.h"

@interface RecentContactUserList : StatusResponse
{
    NSArray         *_dataArray;
    ContactUser     *_contactuser;
}

@property (strong, nonatomic) NSArray           *dataArray;
@property (strong, nonatomic) ContactUser       *contactuser;

@end
