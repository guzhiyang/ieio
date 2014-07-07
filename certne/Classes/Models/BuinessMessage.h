//
//  BuinessMessage.h
//  certne
//
//  Created by apple on 13-11-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuinessMessage : NSObject
{
    NSString        *_proImageURLString;
    NSString        *_proMessage;
    NSString        *_dateString;
    NSString        *_location;
}

@property (copy, nonatomic) NSString        *proImageURLString;
@property (copy, nonatomic) NSString        *proMessage;
@property (copy, nonatomic) NSString        *dateString;
@property (copy, nonatomic) NSString        *location;

@end
