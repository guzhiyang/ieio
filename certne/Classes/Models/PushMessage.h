//
//  PushMessage.h
//  certne
//
//  Created by apple on 14-2-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushMessage : NSObject
{
    NSInteger   _uid;
    NSString    *_avatar;
    NSString    *_time;
    NSString    *_message;
    NSInteger   _totalNum;
}

@property (assign, nonatomic) NSInteger     uid;
@property (copy, nonatomic) NSString        *avatar;
@property (copy, nonatomic) NSString        *time;
@property (copy, nonatomic) NSString        *message;
@property (assign, nonatomic) NSInteger     totalNum;

@end
