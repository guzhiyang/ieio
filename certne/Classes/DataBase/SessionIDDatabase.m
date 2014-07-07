//
//  SessionIDDatabase.m
//  certne
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SessionIDDatabase.h"
#import "Foundation.h"
#import "CCUtility.h"

@implementation SessionIDDatabase

-(id)init
{
    self = [super init];
    if (self) {
        NSString *path = [CCUtility getPathWithDocumentDir:SESSIONDBNAME];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existFile = [fileManager fileExistsAtPath:path];
        
        if (existFile == NO) {
            NSString *sessionDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:SESSIONDBNAME];
            [fileManager copyItemAtPath:sessionDBPath toPath:path error:nil];
        }
        
        _sessionIDDatabase = [[FMDatabase alloc] initWithPath:path];
        if ([_sessionIDDatabase open] == NO) {
            return nil;
        }
    }
    return self;
}

-(BOOL)createSessionIDDataTable
{
    [_sessionIDDatabase beginTransaction];
    BOOL success = [_sessionIDDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS SESSIONTABLE("
                    @"UID INTEGER PRIMARY KEY NOT NULL,"
                    @"SESSIONID TEXT NOT NULL,"
                    @"NAME TEXT,"
                    @"MOBILE TEXT,"
                    @"AVATAR TEXT,"
                    @"COMPANY TEXT,"
                    @"DEPARTMENT TEXT,"
                    @"POSITION TEXT,"
                    @"INDUSTRY TEXT,"
                    @"QQ TEXT,"
                    @"WEBSITE TEXT,"
                    @"EMAIL TEXT,"
                    @"ADDRESS TEXT,"
                    @"TEL TEXT,"
                    @"FAX TEXT,"
                    @"ZIPCODE INTEGER"")"];
    [_sessionIDDatabase commit];
    
    if (!success || [_sessionIDDatabase hadError]) {
        [_sessionIDDatabase rollback];
        return NO;
    }
    return YES;
}

-(BOOL)addSessionID:(SessionID *)sessionID
{
    FMResultSet *result = [_sessionIDDatabase executeQuery:@"SELECT UID FROM SESSIONTABLE WHERE UID = ?",[NSNumber numberWithInt:sessionID.uid]];
    if (result && [result next]) {
        [result close];
        return  YES;
    }
    [result close];
    
    [_sessionIDDatabase beginTransaction];
    NSString *bookMark = nil;
    BOOL success = [_sessionIDDatabase executeUpdate:@"INSERT INTO SESSIONTABLE (UID,SESSIONID,NAME,MOBILE,AVATAR,COMPANY,DEPARTMENT,POSITION,INDUSTRY,QQ,WEBSITE,EMAIL,ADDRESS,TEL,FAX,ZIPCODE) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[NSNumber numberWithInt:sessionID.uid],sessionID.sessionID,sessionID.name,sessionID.mobile,sessionID.avatar,sessionID.company,sessionID.department,sessionID.position,sessionID.industry,sessionID.qq,sessionID.website,sessionID.email,sessionID.address,sessionID.tel,sessionID.fax,[NSNumber numberWithInt:sessionID.zipcode],bookMark];
    [_sessionIDDatabase commit];
    
    if (!success || [_sessionIDDatabase hadError]) {
        return NO;
    }
    return YES;
}

-(NSMutableArray *)getAllData
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    FMResultSet *result = [_sessionIDDatabase executeQuery:@"SELECT * FROM SESSIONTABLE"];
    while ([result next]) {
        SessionID *sessionID = [[SessionID alloc] init];
        sessionID.uid        = [result intForColumn:@"UID"];
        sessionID.sessionID  = [result stringForColumn:@"SESSIONID"];
        sessionID.name       = [result stringForColumn:@"NAME"];
        sessionID.mobile     = [result stringForColumn:@"MOBILE"];
        sessionID.avatar     = [result stringForColumn:@"AVATAR"];
        sessionID.company    = [result stringForColumn:@"COMPANY"];
        sessionID.department = [result stringForColumn:@"DEPARTMENT"];
        sessionID.position   = [result stringForColumn:@"POSITION"];
        sessionID.industry   = [result stringForColumn:@"INDUSTRY"];
        sessionID.qq         = [result stringForColumn:@"QQ"];
        sessionID.website    = [result stringForColumn:@"WEBSITE"];
        sessionID.email      = [result stringForColumn:@"EMAIL"];
        sessionID.address    = [result stringForColumn:@"ADDRESS"];
        sessionID.tel        = [result stringForColumn:@"TEL"];
        sessionID.fax        = [result stringForColumn:@"FAX"];
        sessionID.zipcode    = [result intForColumn:@"ZIPCODE"];
        [resultArray addObject:sessionID];
    }
    [result close];
    return resultArray;
}

-(BOOL)deleteSessionIDWithUid:(NSInteger)uid
{
    [_sessionIDDatabase beginTransaction];
    BOOL success = [_sessionIDDatabase executeUpdate:@"DELETE FROM SESSIONTABLE WHERE UID = ?",[NSNumber numberWithInt:uid]];
    
    if (!success || [_sessionIDDatabase hadError]) {
        [_sessionIDDatabase rollback];
        return NO;
    }
    return YES;
}

-(BOOL)updateSessionID:(SessionID *)sessionID
{
    [_sessionIDDatabase beginTransaction];
    BOOL success = [_sessionIDDatabase executeUpdate:@"UPDATE SESSIONTABLE SET NAME = ?,MOBILE = ?,AVATAR = ?,COMPANY = ?,DEPARTMENT = ?,POSITION = ?,INDUSTRY = ?,QQ = ?,WEBSITE = ?,EMAIL = ?,ADDRESS = ?,TEL = ?,FAX = ?,ZIPCODE = ? WHERE UID = ?",sessionID.name,sessionID.mobile,sessionID.avatar,sessionID.company,sessionID.department,sessionID.position,sessionID.industry,sessionID.qq,sessionID.website,sessionID.email,sessionID.address,sessionID.tel,sessionID.fax,[NSNumber numberWithInt:sessionID.zipcode],[NSNumber numberWithInt:sessionID.uid]];
    [_sessionIDDatabase commit];
    
    if (!success || [_sessionIDDatabase hadError]) {
        [_sessionIDDatabase rollback];
        return NO;
    }
    return YES;
}

-(void)dealloc
{
    [_sessionIDDatabase close];
    _sessionIDDatabase = nil;
}

@end
