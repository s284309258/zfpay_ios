//
//  ReferAgencyNumModel.h
//  XZF
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReferAgencyNumModel : BaseObject
//添加代理总MPOS机具数量
@property (nonatomic,strong) NSString* m_pos_num;
//已激活数量
@property (nonatomic,strong) NSString* m_act_num;
//未激活数量
@property (nonatomic,strong) NSString* m_inact_num;
//添加代理总传统POS机具数量
@property (nonatomic,strong) NSString* tra_pos_num;
//已激活数量
@property (nonatomic,strong) NSString* tra_act_num;
//未激活数量
@property (nonatomic,strong) NSString* tra_inact_num;

@property (nonatomic,strong) NSString* referer_num;
//代理商姓名
@property (nonatomic,strong) NSString* real_name;

//全部代理商
@property (nonatomic,strong) NSString* pos_num;
//已交易代理商
@property (nonatomic,strong) NSString* trade_num;

@property (nonatomic,strong) NSString* performance;

@property (nonatomic,strong) NSString* e_pos_num;

@property (nonatomic,strong) NSString* e_act_num;

@property (nonatomic,strong) NSString* e_inact_num;;

@end

NS_ASSUME_NONNULL_END
