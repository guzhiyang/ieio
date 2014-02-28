//
//  FriendDetailData.h
//  certne
//
//  Created by apple on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendDetailData : NSObject
{
    NSString    *_avatar;
    NSString    *_name;
    NSString    *_position;
    NSString    *_company;
    NSString    *_uid;
    NSString    *_mobile;
    NSString    *_tel;
    NSString    *_email;
    NSString    *_fax;
    NSString    *_qq;
    NSString    *_department;
    NSString    *_industry;
    NSString    *_website;
    NSString    *_address;
    NSString    *_zipcode;
}

@property (copy, nonatomic) NSString    *avatar;
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSString    *position;
@property (copy, nonatomic) NSString    *company;
@property (copy, nonatomic) NSString    *uid;
@property (copy, nonatomic) NSString    *mobile;
@property (copy, nonatomic) NSString    *tel;
@property (copy, nonatomic) NSString    *email;
@property (copy, nonatomic) NSString    *fax;
@property (copy, nonatomic) NSString    *qq;
@property (copy, nonatomic) NSString    *department;
@property (copy, nonatomic) NSString    *industry;
@property (copy, nonatomic) NSString    *website;
@property (copy, nonatomic) NSString    *address;
@property (copy, nonatomic) NSString    *zipcode;

@end
