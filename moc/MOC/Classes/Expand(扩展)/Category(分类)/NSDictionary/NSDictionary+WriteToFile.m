//
//  NSDictionary+WriteToFile.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/7/16.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "NSDictionary+WriteToFile.h"
#import <objc/runtime.h>

@implementation NSDictionary (WriteToFile)

- (BOOL)writeToPlistFile:(NSString *)filename
{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths safeObjectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:filename];
    BOOL didWriteSuccessfull = [data writeToFile:path atomically:YES];
    return didWriteSuccessfull;
}

+ (NSDictionary *)readFromPlistFile:(NSString *)filename
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths safeObjectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData * data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        return nil;
    }
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (BOOL)removeFromPlistFile:(NSString *)filename
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths safeObjectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:filename];
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    return [fileManager removeItemAtPath:path error:nil];
}

+ (instancetype)dictionaryWithObjects:(const id[])objects forKeys:(const id[])keys count:(NSUInteger)cnt {
    NSMutableArray *validKeys = [NSMutableArray new];
    NSMutableArray *validObjs = [NSMutableArray new];

    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] && keys[i]) {
            [validKeys addObject:keys[i]];
            [validObjs addObject:objects[i]];
        }
    }

    return [self dictionaryWithObjects:validObjs forKeys:validKeys];
}

@end
