//
//  ContactUser.h
//  certne
//
//  Created by apple on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactUser : NSObject
{
    NSString    *_avatar;
    NSString    *_name;
    NSString    *_position;
    NSString    *_info;
    NSString    *_company;
    NSInteger   _uid;
    NSString    *_mobile;
    NSInteger   _sort;
}

@property (copy, nonatomic) NSString    *avatar;
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSString    *position;
@property (copy, nonatomic) NSString    *info;
@property (copy, nonatomic) NSString    *company;
@property (assign, nonatomic) NSInteger uid;
@property (copy, nonatomic) NSString    *mobile;
@property (assign, nonatomic) NSInteger sort;

@end
