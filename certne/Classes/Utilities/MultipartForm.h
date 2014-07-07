//
//  MultipartForm.h
//  certne
//
//  Created by apple on 13-8-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

//
#import <Foundation/Foundation.h>

//@interface MultipartForm : NSObject{
//    NSMutableArray  *_fields;
//    NSString        *_boundaryString;
//}
//
//-(void)addValue:(id)value forField:(NSString *)field;
//-(NSData *)httpBody;
//-(NSString *)boundary;
//-(NSString *)contentType;
//
//-(NSString *)getRandomBoundary;
//
//@end

/*
 一般情况下，协议文档（API）规定的以POST方式请求服务器的时候，向服务器发送的数据一般以表单的形式作为HTTP的Body提交。本类封装了如何将要发送的数据转换为表单。//--此时协议文档已经得到了数据
 */

@interface MultipartForm: NSObject {
	NSMutableArray	*_fields;
	NSString		*_boundaryString;
}

- (void)addValue:(id)value forField:(NSString *)field;
- (NSData *)httpBody;
- (NSString *)boundary;
- (NSString *)contentType;

- (NSString *)getRandomBoundary;

@end

