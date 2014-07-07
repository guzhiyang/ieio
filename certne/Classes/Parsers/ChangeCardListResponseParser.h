//
//  ChangeCardListResponseParser.h
//  certne
//
//  Created by apple on 13-12-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeCardListResponse.h"

@interface ChangeCardListResponseParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString         *_currentString;
    NSArray                 *_dataArray;
    CardListData            *_data;
    ChangeCardListResponse  *_changeCardListResponse;
}

-(id)sendChangeCardListResponseParserWithJsonData:(NSData *)jsonData;

@end
