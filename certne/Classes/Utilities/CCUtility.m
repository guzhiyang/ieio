//
//  CCUtility.m
//  certne
//
//  Created by apple on 13-9-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CCUtility.h"

@implementation CCUtility

+(NSString *)getPathWithDocumentDir:(NSString *)aPath
{
    [aPath retain];
    
    NSString *fullPath=nil;
    NSArray *pathArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//NSDocumentDirectory 就是取道目录文件夹
    if ([pathArray count]>0) {
        fullPath=(NSString *)[pathArray objectAtIndex:0];
        if ([aPath length]>0) {
            fullPath=[fullPath stringByAppendingPathComponent:aPath];//--将自己的文件夹名附加到目录下面，就是新建一个文件夹
        }
    }
    
    [aPath release];
    return fullPath;
}

+(BOOL)createDirectory:(NSString *)dirPath lastCompentIsDirectory:(BOOL)isDir
{
    NSString *path=nil;
    if (isDir) {
        path=dirPath;
    }else{
        path=[dirPath stringByDeletingLastPathComponent];//--删除掉文件名 取得目录文件夹
    }
    
    if ([dirPath length]>0 && [[NSFileManager defaultManager] fileExistsAtPath:path]==NO) {
        NSError *error=nil;
        BOOL ret = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                             withIntermediateDirectories:YES
                                                              attributes:nil
                                                                   error:&error];
		if(!ret && error) {
			NSLog(@"create directory failed at path '%@',error:%@,%@",dirPath,[error localizedDescription],[error localizedFailureReason]);
			return NO;
		}
    }
    return YES;
}

+(BOOL)removeFile:(NSString *)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"remove file %@, faild error:[%@]",filePath,error);
            return NO;
        }
    }
    return YES;
}

+(NSData *)archverObject:(NSObject *)object forKey:(NSString *)key
{
    if (object==nil) {
        return nil;
    }
    
    NSMutableData *data=[[NSMutableData alloc] init];
    NSKeyedArchiver *keyArchiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [keyArchiver encodeObject:object forKey:key];
    [keyArchiver finishEncoding];
    [keyArchiver release];
    
    return [data autorelease];
}

+(NSObject *)unarchverObject:(NSData *)archverdData withKey:(NSString *)key
{
    if (archverdData==nil) {
        return nil;
    }
    
    NSKeyedUnarchiver *unarchver=[[NSKeyedUnarchiver alloc] initForReadingWithData:archverdData];
    NSObject *object=[unarchver decodeObjectForKey:key];
    [unarchver finishDecoding];
    [unarchver release];
    
    return object;
}

-(void)dealloc
{
    [super dealloc];
}

@end
