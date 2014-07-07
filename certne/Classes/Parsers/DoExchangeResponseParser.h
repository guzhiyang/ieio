//
//  DoExchangeResponseParser.h
//  certne
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@interface DoExchangeResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    StatusResponse      *_doExchangeResponse;
}

- (id)doExchangeResponseParserWithJsonData:(NSData *)jsonData;

@end
