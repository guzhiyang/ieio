//
//  CardListData.h
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardListData : NSObject
{
    NSString *_avatar;
    NSString *_name;
    NSString *_position;
    NSString *_info;
    NSString *_company;
//    NSString *_uid;
    NSInteger _uid;
}

@property (copy, nonatomic) NSString    *avatar;
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSString    *position;
@property (copy, nonatomic) NSString    *info;
@property (copy, nonatomic) NSString    *company;
//@property (copy, nonatomic) NSString    *uid;
@property (assign, nonatomic) NSInteger uid;

@end
