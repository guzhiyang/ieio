//
//  UserDefault.m
//  certne
//
//  Created by Test on 14-4-30.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "UserDefault.h"


@implementation UserDefault

@synthesize uid        = _uid;
@synthesize name       = _name;
@synthesize mobile     = _mobile;
@synthesize sessionID  = _sessionID;
@synthesize birthday   = _birthday;
@synthesize avatar     = _avatar;
@synthesize company    = _company;
@synthesize department = _department;
@synthesize position   = _position;
@synthesize industry   = _industry;
@synthesize qq         = _qq;
@synthesize website    = _website;
@synthesize email      = _email;
@synthesize address    = _address;
@synthesize tel        = _tel;
@synthesize fax        = _fax;
@synthesize zipCode    = _zipcode;
@synthesize password   = _password;

-(id)init
{
    self = [super init];
    if (self) {
        self.name       = @"";
        self.mobile     = @"";
        self.sessionID  = @"";
        self.birthday   = @"";
        self.avatar     = @"";
        self.company    = @"";
        self.department = @"";
        self.position   = @"";
        self.industry   = @"";
        self.qq         = @"";
        self.website    = @"";
        self.email      = @"";
        self.address    = @"";
        self.tel        = @"";
        self.fax        = @"";
        self.password   = @"";
    }
    return self;
}

static UserDefault *userDefualt = nil;
+(UserDefault *)createUserDefault
{
    @synchronized(self){
        if (userDefualt == nil) {
            userDefualt = [[UserDefault alloc] init];
        }
    }
    return userDefualt;
}

#pragma mark - Save&Read UserDefaultData methods

-(void)saveUserDefault
{
    [[NSUserDefaults standardUserDefaults] setInteger:self.uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] setValue:self.name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setValue:self.mobile forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults] setValue:self.sessionID forKey:@"sessionID"];
    [[NSUserDefaults standardUserDefaults] setValue:self.birthday forKey:@"birthday"];
    [[NSUserDefaults standardUserDefaults] setValue:self.avatar forKey:@"avatar"];
    [[NSUserDefaults standardUserDefaults] setValue:self.company forKey:@"company"];
    [[NSUserDefaults standardUserDefaults] setValue:self.department forKey:@"department"];
    [[NSUserDefaults standardUserDefaults] setValue:self.position forKey:@"position"];
    [[NSUserDefaults standardUserDefaults] setValue:self.industry forKey:@"industry"];
    [[NSUserDefaults standardUserDefaults] setValue:self.qq forKey:@"qq"];
    [[NSUserDefaults standardUserDefaults] setValue:self.website forKey:@"website"];
    [[NSUserDefaults standardUserDefaults] setValue:self.email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:self.address forKey:@"address"];
    [[NSUserDefaults standardUserDefaults] setValue:self.tel forKey:@"tel"];
    [[NSUserDefaults standardUserDefaults] setValue:self.fax forKey:@"fax"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.zipCode forKey:@"zipcode"];
    [[NSUserDefaults standardUserDefaults] setValue:self.password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];//--防止意外退出没有保存数据到plist文件，数据一旦传递过来，立即保存
}

-(void)readUserDefault
{
    self.uid        = [[NSUserDefaults standardUserDefaults] integerForKey:@"uid"];
    self.name       = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
    self.mobile     = [[NSUserDefaults standardUserDefaults] valueForKey:@"mobile"];
    self.sessionID  = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionID"];
    self.birthday   = [[NSUserDefaults standardUserDefaults] valueForKey:@"birthday"];
    self.avatar     = [[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"];
    self.company    = [[NSUserDefaults standardUserDefaults] valueForKey:@"company"];
    self.department = [[NSUserDefaults standardUserDefaults] valueForKey:@"department"];
    self.position   = [[NSUserDefaults standardUserDefaults] valueForKey:@"position"];
    self.industry   = [[NSUserDefaults standardUserDefaults] valueForKey:@"industry"];
    self.qq         = [[NSUserDefaults standardUserDefaults] valueForKey:@"qq"];
    self.website    = [[NSUserDefaults standardUserDefaults] valueForKey:@"website"];
    self.email      = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    self.address    = [[NSUserDefaults standardUserDefaults] valueForKey:@"address"];
    self.tel        = [[NSUserDefaults standardUserDefaults] valueForKey:@"tel"];
    self.fax        = [[NSUserDefaults standardUserDefaults] valueForKey:@"fax"];
    self.zipCode    = [[NSUserDefaults standardUserDefaults] integerForKey:@"zipcode"];
    self.password   = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
}

@end
