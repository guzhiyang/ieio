//
//  StatusResponseParser.h
//  certne
//
//  Created by apple on 13-12-17.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@interface StatusResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    StatusResponse      *_statusResponser;
}

-(id)StatusResponseParserWithJsonData:(NSData *)jsonData;

@end
