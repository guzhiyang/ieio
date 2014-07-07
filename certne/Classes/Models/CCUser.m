//
//  CCUser.m
//  certne
//
//  Created by apple on 13-9-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CCUser.h"

@implementation CCUser
@synthesize name          = _name;
@synthesize position      = _position;
@synthesize company       = _company;
@synthesize supply        = _supply;
@synthesize headImagePath = _headImagePath;
@synthesize urlImagePath  = _urlImagePath;
@synthesize userId        = _userId;
@synthesize favourite     = _favourite;

+(CCUser *)userName:(NSString *)aName userPosition:(NSString *)aPosition userCompany:(NSString *)aCompany userSupply:(NSString *)aSupply userHeadImagePath:(NSString *)aHeadImagePath userUrlImagePath:(NSString *)aUrlImagePath
{
    CCUser *user = [[CCUser alloc]init];
    user.name          = aName;
    user.position      = aPosition;
    user.company       = aCompany;
    user.supply        = aSupply;
    user.headImagePath = aHeadImagePath;
    user.urlImagePath  = aUrlImagePath;
    return user;
}

-(void)dealloc
{
    self.name          = nil;
    self.position      = nil;
    self.company       = nil;
    self.supply        = nil;
    self.headImagePath = nil;
    self.urlImagePath  = nil;
}

@end
