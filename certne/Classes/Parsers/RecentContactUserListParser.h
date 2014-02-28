//
//  RecentContactUserListParser.h
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecentContactUserList.h"

@interface RecentContactUserListParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString             *_currentString;
    RecentContactUserList       *_recentContactUserList;
    NSArray                     *_dataArray;
    ContactUser                 *_contactuser;
}

-(id)RecentContactUserListParserWithJsonData:(NSData *)jsonData;

@end
