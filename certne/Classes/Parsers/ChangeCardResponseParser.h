//
//  ChangeCardResponseParser.h
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@interface ChangeCardResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString         *_currentString;
    StatusResponse          *_changeCardResponse;
}

-(id)ChangeCardResponseParserWithJsonData:(NSData *)jsonData;

@end
