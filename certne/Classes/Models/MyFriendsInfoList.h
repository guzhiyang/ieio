//
//  MyFriendsInfoList.h
//  certne
//
//  Created by apple on 13-12-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendsInfoListData.h"

@interface MyFriendsInfoList : NSObject
{
    NSInteger               _status;
    NSString                *_msg;
    NSArray                 *_friendListArray;
    FriendsInfoListData     *_data;
}

@property (assign, nonatomic) NSInteger             status;
@property (copy, nonatomic) NSString                *msg;
@property (retain, nonatomic) NSArray               *friendListArray;
@property (retain, nonatomic) FriendsInfoListData   *data;

@end
