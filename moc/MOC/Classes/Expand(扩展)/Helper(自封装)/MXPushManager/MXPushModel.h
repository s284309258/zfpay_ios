//
//  MXPushModel.h
//  MoPal_Developer
//
//  Created by 李星楼 on 15/9/16.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXPushModel : NSObject

@property(nonatomic,copy)NSString *msg;
@property(nonatomic,assign)NSUInteger unRead;
//1"="评论";2"="喜欢";3"="回复";4"="转发";5"="参与";
@property(nonatomic,assign)NSUInteger msgType;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSUInteger t;
//1="动态";2="话题";3="活动";3="投票";
@property(nonatomic,assign)NSUInteger type;
@property(nonatomic,assign)NSUInteger id;

//组合后的显示信息
@property(nonatomic,readonly)NSString* tipMsg;
@end
