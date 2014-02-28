//
//  PushMessageDataBase.h
//  certne
//
//  Created by apple on 14-2-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushMessage.h"
#import "FMDatabase.h"

@interface PushMessageDataBase : NSObject
{
    FMDatabase  *_pushMessageDataBase;
}

-(BOOL)createPushMessageDataTable;

-(BOOL)addPushMessage:(PushMessage *)pushMesage;

-(NSMutableArray *)getAllData;

-(BOOL)deletePushMessageWithUid:(NSInteger)totalNum;

@end
