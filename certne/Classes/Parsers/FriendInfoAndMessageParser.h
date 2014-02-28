//
//  FriendInfoAndMessageParser.h
//  certne
//
//  Created by apple on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendInfoAndMessage.h"

@interface FriendInfoAndMessageParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString         *_currentString;
    FriendInfoAndMessage    *_friendInfoMsg;
    FriendDetailData        *_data;
    InfoData                *_infodata;
    NSArray                 *_infoArray;
}

-(id)friendInfoAndMessageParserWithJsonData:(NSData *)jsonData;

@end
