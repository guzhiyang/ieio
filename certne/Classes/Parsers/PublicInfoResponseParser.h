//
//  PublicInfoResponseParser.h
//  certne
//
//  Created by apple on 13-12-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicInfoResponse.h"

@interface PublicInfoResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString         *_currentString;
    PublicInfoResponse      *_publicInfoResponse;
    NSMutableArray          *_dataArray;
    PublicInfo              *_publicInfo;
}

-(id)PublicInfoResponseParserWithJsonData:(NSData *)jsonData;

@end
