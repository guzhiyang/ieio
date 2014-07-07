//
//  SetNewPswResponseParser.h
//  certne
//
//  Created by apple on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetNewPswResponse.h"

@interface SetNewPswResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    SetNewPswResponse   *_setNewPswResponse;
}

-(id)setNewPswResponseParserWithJsonData:(NSData *)jsonData;

@end
