//
//  CCUser.h
//  certne
//
//  Created by apple on 13-9-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCUser : NSObject
{
    NSString    *_headImagePath;
    NSString    *_urlImagePath;
    
    NSString    *_name;
    NSString    *_position;
    NSString    *_company;
    NSString    *_supply;
    NSInteger   _userId;
    BOOL        _favourite;
}

@property (copy,nonatomic) NSString     *headImagePath;
@property (copy,nonatomic) NSString     *urlImagePath;
@property (copy,nonatomic) NSString     *name;
@property (copy,nonatomic) NSString     *position;
@property (copy,nonatomic) NSString     *company;
@property (copy,nonatomic) NSString     *supply;
@property (assign,nonatomic) NSInteger userId;
@property (assign,nonatomic) BOOL       favourite;

+(CCUser *)userName:(NSString *)aName userPosition:(NSString *)aPosition userCompany:(NSString *)aCompany userSupply:(NSString *)aSupply userHeadImagePath:(NSString *)aHeadImagePath userUrlImagePath:(NSString *)aUrlImagePath;

@end
