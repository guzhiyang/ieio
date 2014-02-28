//
//  NearbyUserListParser.h
//  certne
//
//  Created by apple on 13-12-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyUserList.h"

@interface NearbyUserListParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    NearbyUserList      *_nearbyUserList;
    NSArray             *_dataArray;
    NearbyUser          *_nearbyUser;
}

-(id)NearbyUserListParserWithJsonData:(NSData *)jsonData;

@end
