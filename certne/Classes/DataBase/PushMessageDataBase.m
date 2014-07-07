//
//  PushMessageDataBase.m
//  certne
//
//  Created by apple on 14-2-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PushMessageDataBase.h"
#import "Foundation.h"
#import "CCUtility.h"

@implementation PushMessageDataBase

-(id)init
{
    self = [super init];
    if (self) {
        NSString *path = [CCUtility getPathWithDocumentDir:PUSHMESSAGEDBNAME];
        NSFileManager *fileMenager = [NSFileManager defaultManager];
        BOOL existFile = [fileMenager fileExistsAtPath:path];
        
        if (existFile == NO) {
            NSString *pushMessageDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:PUSHMESSAGEDBNAME];
            [fileMenager copyItemAtPath:pushMessageDBPath toPath:path error:nil];
        }
        
        _pushMessageDataBase = [[FMDatabase alloc] initWithPath:path];
        if ([_pushMessageDataBase open] == NO) {
            return nil;
        }
    }
    return self;
}

-(BOOL)createPushMessageDataTable
{
    [_pushMessageDataBase beginTransaction];
    BOOL success = [_pushMessageDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS PUSHMESSAGETABLE("@"TOTALNUM INTEGER PRIMARY KEY NOT NULL,"@"MESSAGE TEXT NOT NULL,"@"UID INTEGER,"@"AVATAR TEXT,"@"TIME TEXT"")"];
    [_pushMessageDataBase commit];
    
    if (!success || [_pushMessageDataBase hadError]) {
        [_pushMessageDataBase rollback];
        return NO;
    }
    return YES;
}

-(BOOL)addPushMessage:(PushMessage *)pushMesage
{
    FMResultSet *result = [_pushMessageDataBase executeQuery:@"SELECT TOTALNUM FROM PUSHMESSAGETABLE WHERE TOTALNUM = ?",[NSNumber numberWithInt:pushMesage.totalNum]];
    if (result && [result next]) {
        [result close];
        return  YES;
    }
    [result close];
    
    [_pushMessageDataBase beginTransaction];
    NSString *bookMark = nil;
    BOOL success = [_pushMessageDataBase executeUpdate:@"INSERT INTO PUSHMESSAGETABLE (TOTALNUM,MESSAGE,UID,AVATAR,TIME) VALUES (?,?,?,?,?);",[NSNumber numberWithInt:pushMesage.totalNum],pushMesage.message,[NSNumber numberWithInt:pushMesage.uid],pushMesage.avatar,pushMesage.time,bookMark];
    [_pushMessageDataBase commit];
    
    if (!success || [_pushMessageDataBase hadError]) {
        return NO;
    }
    return YES;
}

-(NSMutableArray *)getAllData
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    FMResultSet *result = [_pushMessageDataBase executeQuery:@"SELECT * FROM PUSHMESSAGETABLE"];
    while ([result next]) {
        PushMessage *pushMessage = [[PushMessage alloc] init];
        pushMessage.totalNum = [result intForColumn:@"TOTALNUM"];
        pushMessage.message = [result stringForColumn:@"MESSAGE"];
        pushMessage.uid = [result intForColumn:@"UID"];
        pushMessage.avatar = [result stringForColumn:@"AVATAR"];
        pushMessage.time = [result stringForColumn:@"TIME"];
        [resultArray addObject:pushMessage];
    }
    [result close];
    return resultArray;
}

-(BOOL)deletePushMessageWithUid:(NSInteger)totalNum
{
    [_pushMessageDataBase beginTransaction];
    BOOL success = [_pushMessageDataBase executeUpdate:@"DELETE FROM PUSHMESSAGETABLE WHERE TOTALNUM = ?",totalNum];
    
    if (!success || [_pushMessageDataBase hadError]) {
        [_pushMessageDataBase rollback];
        return NO;
    }
    return YES;
}

-(void)dealloc
{
    [_pushMessageDataBase close];
    _pushMessageDataBase = nil;
}

@end
