//
//  ChangeCardListResponse.h
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardListData.h"

@interface ChangeCardListResponse : NSObject
{
    NSInteger       _status;
    NSString        *_msg;
    NSArray         *_dataArray;
    CardListData    *_data;
}

@property (assign, nonatomic) NSInteger     status;
@property (copy, nonatomic) NSString        *msg;
@property (retain, nonatomic) NSArray       *dataArray;
@property (retain, nonatomic) CardListData  *data;

@end
