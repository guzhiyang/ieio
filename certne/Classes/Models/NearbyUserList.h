//
//  NearbyUserList.h
//  certne
//
//  Created by apple on 13-12-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyUser.h"

@interface NearbyUserList : NSObject
{
    NSInteger       _status;
    NSString        *_msg;
    NSArray         *_nearbyUserArray;
    NearbyUser      *_nearbyUser;
}

@property (assign, nonatomic) NSInteger         status;
@property (copy, nonatomic)   NSString          *msg;
@property (retain, nonatomic) NearbyUser        *nearbyUser;
@property (retain, nonatomic) NSArray           *nearbyUserArray;

@end
