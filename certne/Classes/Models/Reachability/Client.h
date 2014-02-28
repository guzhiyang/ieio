//
//  Client.h
//  certne
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject
{
}

@property(assign,nonatomic)NSInteger userId;
@property(copy,nonatomic) NSString *headImage;
@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *position;
@property(copy,nonatomic) NSString *supply;
@property(copy,nonatomic) NSString *company;
@property(copy,nonatomic) NSString *password;

@end
