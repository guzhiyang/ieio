//
//  MyFriendsInfoListParser.h
//  certne
//
//  Created by apple on 13-12-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyFriendsInfoList.h"

@interface MyFriendsInfoListParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    NSArray             *_friendsListArray;
    MyFriendsInfoList   *_myFriendsInfoList;
    FriendsInfoListData *_listData;
}

-(id) sendMyFriendsInfoListParserWithJsonData:(NSData *)jsonData;

@end
