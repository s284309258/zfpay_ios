//
//  MXBaseRequestApi.m
//  MoPal_Developer
//
//  Created by yuhx on 15-4-30.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXBaseRequestApi.h"
#import "UserModel.h"

@interface MXBaseRequestApi()

@end

@implementation MXBaseRequestApi

- (id)initWithParameter:(NSDictionary*)dictionary {
    if (self = [super init]) {
        if (dictionary) {
            _paramDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
        }

        _totalCount      = @(0);
        _pageSize        = @(20);
        _page            = @(0);
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _totalCount      = @(0);
        _pageSize        = @(20);
        _page            = @(0);
    }
    return self;
}

- (NSString *)requestUrl {
    return @"";
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
//    if ([[[self requestArgument] allKeys] containsObject:@"token"]) {
//        return @{@"token":[[self requestArgument] valueForKey:@"token"] ?: @"",@"appType":appType};
//    } else if (AppUserModel) {
//        NSString *token = [NSString stringWithFormat:@"%@",AppUserModel.token];
//        if ([StringUtil isEmpty:token]) {
//            return nil;
//        }
//        MLog(@"token = %@\n\n>>>>",token);
//        return @{@"token":token,@"appType":appType};
//    }
    
    return nil;
}

- (id)requestArgument {
    return _paramDictionary;
}

- (MXRequestSerializerType)requestSerializerType {
    return MXRequestSerializerTypeJSON;
}

- (void)nextPage
{
    self.page = @(self.page.integerValue + 1);
}

- (void)startPage
{
    self.page = @(0);
}

-(NSMutableArray *)success:(NSMutableArray *)originArray
                  newArray:(NSArray *)newArray
{
    if (self.page.integerValue == 0) {
        [originArray removeAllObjects];
        originArray = [NSMutableArray array];
    }
    
    if([newArray count] > 0) {
        [originArray addObjectsFromArray:newArray];
    } else if (self.page.integerValue == 0 && [newArray count] == 0) {
        return nil;
    }
    
    return originArray;
}

-(NSMutableArray *)page1success:(NSMutableArray *)originArray
                  newArray:(NSArray *)newArray
{
    if (self.page.integerValue == 1) {
        [originArray removeAllObjects];
        originArray = [NSMutableArray array];
    }
    
    if([newArray count] > 0) {
        [originArray addObjectsFromArray:newArray];
    } else if (self.page.integerValue == 0 && [newArray count] == 0) {
        return nil;
    }
    
    return originArray;
}

@end
