//
//  CCUserDataBase.h
//  certne
//
//  Created by apple on 13-9-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "CCUser.h"

@interface CCUserDataBase : NSObject{
    FMDatabase *_userDataBase;
}

-(BOOL)createUserDataTable;
-(BOOL)addUser:(CCUser *)aUser;
-(NSMutableArray *)getAlluserData;
-(NSMutableArray *)getFavouriteUserData;
-(BOOL)setFavourite:(BOOL)favourite CCUserId:(NSInteger)userId;
-(BOOL)deleteCCUserWithUserId:(NSInteger)userId;

@end
