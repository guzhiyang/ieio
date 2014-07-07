//
//  InfoData.h
//  certne
//
//  Created by apple on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoData : NSObject
{
    NSInteger   _infoID;
    NSString    *_img;
    NSString    *_desc;
    NSString    *_publishAddress;
    NSInteger   _infoType;
    NSString    *_addTime;
}

@property (assign, nonatomic) NSInteger     infoID;
@property (copy, nonatomic) NSString        *img;
@property (copy, nonatomic) NSString        *desc;
@property (copy, nonatomic) NSString        *publishAddress;
@property (assign, nonatomic) NSInteger     infoType;
@property (copy, nonatomic) NSString        *addTime;

@end
