//
//  SayHelloResponseParser.h
//  certne
//
//  Created by apple on 13-12-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@interface SayHelloResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    StatusResponse      *_sayHelloResponse;
}

-(id)SayHelloResponseParserWithJsonData:(NSData *)jsonData;

@end
