//
//  CCUtility.h
//  certne
//
//  Created by apple on 13-9-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCUtility : NSObject{
    
}

+(NSString *)getPathWithDocumentDir:(NSString *)aPath;//－－获取路径
+(BOOL)createDirectory:(NSString *)dirPath lastCompentIsDirectory:(BOOL)isDir;//--创建目录
+(BOOL)removeFile:(NSString *)filePath;
+(NSData *)archverObject:(NSObject *)object forKey:(NSString *)key;
+(NSObject *)unarchverObject:(NSData *)archverdData withKey:(NSString *)key;

@end

