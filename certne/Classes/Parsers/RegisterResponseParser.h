//
//  RegisterResponseParser.h
//  certne
//
//  Created by apple on 13-11-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterResponse.h"

@interface RegisterResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    RegisterResponse    *_registerResponse;
}

-(id)requestResponseParserWithJsonData:(NSData *)jsonData;

@end
