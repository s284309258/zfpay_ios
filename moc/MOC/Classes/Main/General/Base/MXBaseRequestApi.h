//
//  MXBaseRequestApi.h
//  MoPal_Developer
//
//  基类Api
//  Created by yuhx on 15-4-30.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//


#import "MXRequest.h"
@interface MXBaseRequestApi : MXRequest


// 参数
@property (nonatomic, strong) NSMutableDictionary *paramDictionary;

// add by yang.xiangbao 2015/8/17
/// 总的数据
@property (nonatomic, strong) NSNumber *totalCount;
/// 每页多少条,默认20条
@property (nonatomic, strong) NSNumber *pageSize;
/// 第几页,默认0
@property (nonatomic, strong) NSNumber *page;
// the end

/**
 *  初始化Api参数
 *
 *  @param dictionary
 *
 *  @return Api 实例
 */
- (instancetype)initWithParameter:(NSDictionary *)dictionary;

// 下一页数据
- (void)nextPage;
// 恢复初始页
- (void)startPage;

- (NSMutableArray *)success:(NSMutableArray *)originArray
                   newArray:(NSArray *)newArray;

- (NSMutableArray *)page1success:(NSMutableArray *)originArray
                        newArray:(NSArray *)newArray;

@end
