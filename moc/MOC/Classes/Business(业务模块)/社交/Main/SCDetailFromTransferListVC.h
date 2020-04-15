//
//  SCDetailFromTransferListVC.h
//  Lcwl
//
//  Created by mac on 2019/1/3.
//  Copyright © 2019 lichangwanglai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//专门用于详情列表点击进入详情，由于详情页在初始化之前需要准备好数据
@interface SCDetailFromTransferListVC : UIViewController
@property (nonatomic, strong) NSString *circle_id;
@end

NS_ASSUME_NONNULL_END
