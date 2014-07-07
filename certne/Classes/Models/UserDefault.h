//
//  UserDefault.h
//  certne
//
//  Created by Test on 14-4-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefault : NSObject
{
    NSInteger       _uid;
    NSString        *_name;
    NSString        *_mobile;
    NSString        *_sessionID;
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
    NSString        *_password;
}

@property (assign, nonatomic) NSInteger   uid;
@property (copy, nonatomic) NSString      *name;
@property (copy, nonatomic) NSString      *mobile;
@property (copy, nonatomic) NSString      *sessionID;
@property (copy, nonatomic) NSString      *birthday;
@property (copy, nonatomic) NSString      *avatar;
@property (copy, nonatomic) NSString      *company;
@property (copy, nonatomic) NSString      *department;
@property (copy, nonatomic) NSString      *position;
@property (copy, nonatomic) NSString      *industry;
@property (copy, nonatomic) NSString      *qq;
@property (copy, nonatomic) NSString      *website;
@property (copy, nonatomic) NSString      *email;
@property (copy, nonatomic) NSString      *address;
@property (copy, nonatomic) NSString      *tel;
@property (copy, nonatomic) NSString      *fax;
@property (assign, nonatomic) NSInteger   zipCode;
@property (copy, nonatomic) NSString      *password;

+(UserDefault *)createUserDefault;
-(void)saveUserDefault;
-(void)readUserDefault;

@end
