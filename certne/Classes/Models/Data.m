//
//  Data.m
//  certne
//
//  Created by apple on 14-1-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Data.h"

static NSString *const DeviceTokenKey = @"DeviceToken";

@implementation Data

-(NSString *)udid
{
    //--设备的udid暂时还拿不到
//    UIDevice *device = [UIDevice currentDevice];
//    return [device.uniqueIdentifier string]
    return nil;
}

-(NSString *)deviceToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:DeviceTokenKey];
}

-(void)setDeviceToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:DeviceTokenKey];
}

+(void)initialize
{
    if (self == [Data class]) {
        [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:@"0",DeviceTokenKey, nil]];
    }
}

@end
