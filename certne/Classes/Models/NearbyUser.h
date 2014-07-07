//
//  NearbyUser.h
//  certne
//
//  Created by apple on 13-12-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyUser : NSObject
{
    NSString        *_avatar;
    NSString        *_name;
    NSString        *_position;
    NSString        *_info;
    NSString        *_company;
    NSInteger       _uid;
    NSInteger       _distance;
    NSString        *_mobile;
}

@property (copy, nonatomic) NSString    *avatar;
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSString    *position;
@property (copy, nonatomic) NSString    *info;
@property (copy, nonatomic) NSString    *company;
@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) NSInteger distance;
@property (copy, nonatomic) NSString    *mobile;

@end
