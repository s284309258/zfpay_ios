//
//  NSDictionary+WriteToFile.h
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/7/16.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WriteToFile)

- (BOOL)writeToPlistFile:(NSString *)filename;

+ (NSDictionary *)readFromPlistFile:(NSString*)filename;

+ (BOOL)removeFromPlistFile:(NSString *)filename;
@end
