//
//  Global.m
//  certne
//
//  Created by apple on 13-8-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "Global.h"

static Global *kGlobal = nil;

@implementation Global
@synthesize currentClient = _currentClient;
@synthesize session_id    = _session_id;
@synthesize mobile        = _mobile;
@synthesize currentUser   = _currentUser;
@synthesize longitude     = _longitude;
@synthesize latitude      = _latitude;
@synthesize deviceToken   = _deviceToken;
@synthesize headImageKey  = _headImageKey;
@synthesize headImageData = _headImageData;

-(id)init
{
    self = [super init];
    if (self) {
        self.sideBarShowing = NO;
    }
    
    return self;
}

+(Global *)shareGlobal
{
    @synchronized(self){
        if (kGlobal == nil) {
            kGlobal = [[Global alloc]init];
        }
    }
    return kGlobal;
}

+(void)releaseGlobal
{
}

-(void)dealloc
{
    self.session_id    = nil;
    self.currentClient = nil;
    self.mobile        = nil;
    self.currentUser   = nil;
    self.deviceToken   = nil;
    self.headImageKey  = nil;
    self.headImageData = nil;
}
@end
