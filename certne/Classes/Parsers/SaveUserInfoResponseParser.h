//
//  SaveUserInfoResponseParser.h
//  certne
//
//  Created by apple on 13-12-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusResponse.h"

@interface SaveUserInfoResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_currentString;
    StatusResponse      *_saveUserInfoResponse;
}

-(id)SaveUserInfoResponseParserWithJSONData:(NSData *)jsonData;

@end
