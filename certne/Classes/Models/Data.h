//
//  Data.h
//  certne
//
//  Created by apple on 14-1-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
{
}

-(NSString *)udid;
-(NSString *)deviceToken;
-(void)setDeviceToken:(NSString *)token;

@end
