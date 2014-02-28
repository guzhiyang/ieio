//
//  PublicInfo.h
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicInfo : NSObject
{
    NSInteger       _infoID;
    NSString        *_avatar;
    NSString        *_name;
    NSString        *_company;
    NSString        *_mobile;
    NSString        *_img;
    NSString        *_desc;
    NSInteger       _infoType;
    NSString        *_publishAddress;
    NSString        *_addTime;
}

@property (assign, nonatomic) NSInteger     infoID;
@property (copy, nonatomic) NSString        *avatar;
@property (copy, nonatomic) NSString        *name;
@property (copy, nonatomic) NSString        *company;
@property (copy, nonatomic) NSString        *mobile;
@property (copy, nonatomic) NSString        *img;
@property (copy, nonatomic) NSString        *desc;
@property (assign, nonatomic) NSInteger     infoType;
@property (copy, nonatomic) NSString        *publishAddress;
@property (copy, nonatomic) NSString        *addTime;

@end
