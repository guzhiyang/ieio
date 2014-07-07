//
//  FriendInfoAndMessage.h
//  certne
//
//  Created by apple on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendDetailData.h"
#import "InfoData.h"

@interface FriendInfoAndMessage : NSObject
{
    NSInteger           _status;
    NSString            *_msg;
    FriendDetailData    *_data;
    NSArray             *_infoArray;
    InfoData            *_infoData;
}

@property (assign, nonatomic) NSInteger         status;
@property (copy, nonatomic) NSString            *msg;
@property (strong, nonatomic) FriendDetailData  *data;
@property (strong, nonatomic) NSArray           *infoArray;
@property (strong, nonatomic) InfoData          *infoData;

@end
