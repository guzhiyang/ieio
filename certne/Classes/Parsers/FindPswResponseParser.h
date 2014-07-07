//
//  FindPswResponseParser.h
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindPswResponse.h"

@interface FindPswResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    FindPswResponse     *_findPswResponse;
}

-(id)FindPswResponseParserWithJsonData:(NSData *)jsonData;

@end
