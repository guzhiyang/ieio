//
//  User.h
//  certne
//
//  Created by apple on 13-11-19.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSInteger       _uid;
    NSString        *_name;
    NSString        *_mobile;
    NSString        *_birthday;
    NSString        *_avatar;
    NSString        *_company;
    NSString        *_department;
    NSString        *_position;
    NSString        *_industry;
    NSString        *_qq;
    NSString        *_website;
    NSString        *_email;
    NSString        *_address;
    NSString        *_tel;
    NSString        *_fax;
    NSInteger       _zipcode;
}

@property (assign, nonatomic) NSInteger     uid;
@property (copy, nonatomic) NSString        *name;
@property (copy, nonatomic) NSString        *mobile;
@property (copy, nonatomic) NSString        *birthday;
@property (copy, nonatomic) NSString        *avatar;
@property (copy, nonatomic) NSString        *company;
@property (copy, nonatomic) NSString        *department;
@property (copy, nonatomic) NSString        *position;
@property (copy, nonatomic) NSString        *industry;
@property (copy, nonatomic) NSString        *qq;
@property (copy, nonatomic) NSString        *website;
@property (copy, nonatomic) NSString        *email;
@property (copy, nonatomic) NSString        *address;
@property (copy, nonatomic) NSString        *tel;
@property (copy, nonatomic) NSString        *fax;
@property (assign, nonatomic) NSInteger     zipcode;

@end
