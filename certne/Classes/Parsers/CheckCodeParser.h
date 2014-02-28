//
//  CheckCodeParser.h
//  certne
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckCodeResponse.h"

@interface CheckCodeParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString     *_curentString;
    CheckCodeResponse   *_checkCodeResponse;
}

-(id)checkCodeResponseParserWithJSONData:(NSData *)jsonData;

@end
