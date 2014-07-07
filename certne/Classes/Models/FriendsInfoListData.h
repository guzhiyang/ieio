//
//  FriendsInfoListData.h
//  certne
//
//  Created by apple on 13-12-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsInfoListData : NSObject
{
    NSInteger   _uid;
    NSString    *_avatar;
    NSString    *_name;
    NSString    *_position;
    NSString    *_info;
    NSString    *_company;
    NSInteger   _sort;
//    NSDate      *_time;
}

@property (assign, nonatomic) NSInteger     uid;
@property (copy, nonatomic) NSString        *avatar;
@property (copy, nonatomic) NSString        *name;
@property (copy, nonatomic) NSString        *position;
@property (copy, nonatomic) NSString        *info;
@property (copy, nonatomic) NSString        *company;
@property (assign, nonatomic) NSInteger     sort;

@end
