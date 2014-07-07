//
//  ClientRequestParsers.h
//  certne
//
//  Created by apple on 13-8-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Client.h"

@interface ClientRequestParsers : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentValue;
    Client              *_client;
}

-(id)clientParserWithJSONData:(NSData *)jsonData;

@end
