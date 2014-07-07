//
//  SessionIDDatabase.h
//  certne
//
//  Created by apple on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "SessionID.h"

@interface SessionIDDatabase : NSObject
{
    FMDatabase      *_sessionIDDatabase;
}

/**
 *	@brief	创建sessionID表
 *
 *	@return	返回创建表成功状态
 */
-(BOOL) createSessionIDDataTable;

/**
 *	@brief	向表里添加一条数据
 *
 *	@param 	sessionID 	传入数据
 *
 *	@return	返回插入数据状态
 */
-(BOOL) addSessionID:(SessionID *)sessionID;

/**
 *	@brief	获取表中的所有数据
 *
 *	@return	返回查询状态
 */
-(NSMutableArray *) getAllData;

/**
 *	@brief	根据用户ID删除数据
 *
 *	@param 	uid  用户ID
 *
 *	@return	返回删除状态
 */
-(BOOL) deleteSessionIDWithUid:(NSInteger)uid;

/**
 *	@brief	更新用户的信息
 *
 *	@param 	sessionID 	用户登陆及个人信息
 *
 *	@return	返回更新结果，成功yes 失败no
 */
-(BOOL) updateSessionID:(SessionID *)sessionID;


@end
