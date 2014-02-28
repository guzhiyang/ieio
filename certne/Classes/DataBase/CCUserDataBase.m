//
//  CCUserDataBase.m
//  certne
//
//  Created by apple on 13-9-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CCUserDataBase.h"
#import "CCUtility.h"

//--创建数据库文件 读取数据

#define USERDBNAME @"user.sqlite"

@implementation CCUserDataBase

- (id)init
{
    self = [super init];
    if (self) {
        NSString *path=[CCUtility getPathWithDocumentDir:USERDBNAME];//--获取document文件夹里的文件
        NSFileManager *fileManger=[NSFileManager defaultManager];
        BOOL existFile=[fileManger fileExistsAtPath:path];
        if (existFile == NO) {
            NSString *userDBPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:USERDBNAME];
            [fileManger copyItemAtPath:userDBPath toPath:path error:nil];
        }
        
        _userDataBase = [[FMDatabase alloc]initWithPath:path];
        if ([_userDataBase open] == NO) {
            return nil;
        }
    }
    return self;
}

-(BOOL)createUserDataTable
{
    [_userDataBase beginTransaction];
    BOOL success=[_userDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS USERTABLE ("
                  @"ID INTEGER PRIMARY KEY NOT NULL,"
                  @"USERNAME TEXT NOT NULL,"
                  @"HEADIMAGE TEXT NOT NULL,"
                  @"POSITION TEXT NOT NULL,"
                  @"SUPPLY TEXT NOT NULL,"
                  @"COMPANY TEXT NOT NULL,"
                  @"WHETHERFAVOURITE BOOL NOT NULL);"];
    [_userDataBase commit];
    
    if (!success || [_userDataBase hadError]) {
        [_userDataBase rollback];
        return NO;
    }
    return YES;
}

-(BOOL)addUser:(CCUser *)aUser
{
    FMResultSet *result=[_userDataBase executeQuery:@"SELECT ID FROM USERTABLE WHERE ID=?",[NSNumber numberWithInt:aUser.userId]];
    if (result && [result next]) {
        [result close];
        return YES;
    }
    [result close];
    
    [_userDataBase beginTransaction];
    NSString *bookMark=nil;
    BOOL success=[_userDataBase executeUpdate:@"INSERT OR IGNORE INTO USERTABLE (ID,USERNAME,HEADIMAGE,POSITION,SUPPLY,COMPANY,WHETHERFAVOURITE) VALUES (?,?,?,?,?,?,?);",
                  [NSNumber numberWithInt:aUser.userId],
                  aUser.name,
                  aUser.headImagePath,
                  aUser.position,
                  aUser.supply,
                  aUser.company,
                  [NSNumber numberWithBool:aUser.favourite],
                  bookMark];
    [_userDataBase commit];
    
    if (!success || [_userDataBase hadError]) {
        [_userDataBase rollback];
        return NO;
    }
    return YES;
}

-(NSMutableArray *)getAlluserData
{
    NSMutableArray *resultArray=[[NSMutableArray alloc] init];
    
    FMResultSet *result=[_userDataBase executeQuery:@"SELECT * FROM USERTABLE"];
    while ([result next]) {
        CCUser *user=[[CCUser alloc] init];
        user.userId=[result intForColumn:@"ID"];
        user.name=[result stringForColumn:@"USERNAME"];
        user.headImagePath=[result stringForColumn:@"HEADIMAGE"];
        user.position=[result stringForColumn:@"POSITION"];
        user.supply=[result stringForColumn:@"SUPPLY"];
        user.company=[result stringForColumn:@"COMPANY"];
        user.favourite=[result boolForColumn:@"WHETHERFAVOURITE"];
        [resultArray addObject:user];
        [user release];
    }
    [result close];
    return [resultArray autorelease];
}

-(NSMutableArray *)getFavouriteUserData
{
    NSMutableArray *resultArray=[[NSMutableArray alloc] init];
    
    FMResultSet *result=[_userDataBase executeQuery:@"SELECT * FROM USERTABLE WHERE WHETHERFAVOURITE=?",[NSNumber numberWithBool:YES]];
    while ([result next]) {
        CCUser *user=[[CCUser alloc] init];
        user.userId=[result intForColumn:@"ID"];
        user.name=[result stringForColumn:@"USERNAME"];
        user.headImagePath=[result stringForColumn:@"HEADIMAGE"];
        user.position=[result stringForColumn:@"POSITION"];
        user.supply=[result stringForColumn:@"SUPPLY"];
        user.favourite=[result boolForColumn:@"WHETHERFAVOURITE"];
        [resultArray addObject:user];
        [user release];
    }
    [result close];
    return [resultArray autorelease];
}

-(BOOL)setFavourite:(BOOL)favourite CCUserId:(NSInteger)userId
{
    if (_userDataBase==nil) {
        return NO;
    }
    [_userDataBase beginTransaction];
    BOOL result=[_userDataBase executeUpdate:@"UPDATE USERTABLE SET WHETHERFAVOURITE=? WHERE ID=?",[NSNumber numberWithBool:favourite],[NSNumber numberWithInt:userId]];

    [_userDataBase commit];
    return result;
}

-(BOOL)deleteCCUserWithUserId:(NSInteger)userId
{
    [_userDataBase beginTransaction];
    BOOL success=[_userDataBase executeUpdate:@"DELETE FROM USERTABLE WHERE ID=?",[NSNumber numberWithInt:userId]];
    [_userDataBase commit];
    
    if (!success || [_userDataBase hadError]) {
        [_userDataBase rollback];
        return NO;
    }
    return YES;
}

-(void)dealloc
{
    [_userDataBase close];
    [_userDataBase release];//
    _userDataBase=nil;
    [super dealloc];
}

@end
