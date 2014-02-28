//
//  RecentContactUserList.h
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactUser.h"

@interface RecentContactUserList : NSObject
{
    NSInteger       _status;
    NSString        *_msg;
    NSArray         *_dataArray;
    ContactUser     *_contactuser;
}

@property (assign, nonatomic) NSInteger         status;
@property (copy, nonatomic)   NSString          *msg;
@property (retain, nonatomic) NSArray           *dataArray;
@property (retain, nonatomic) ContactUser       *contactuser;

@end
