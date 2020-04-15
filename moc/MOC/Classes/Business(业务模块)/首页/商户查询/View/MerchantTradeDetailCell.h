//
//  MerchantTradeDetailCell.h
//  XZF
//
//  Created by mac on 2020/3/14.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosTradeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MerchantTradeDetailCell : UITableViewCell

@property (nonatomic,strong) UILabel* timeLbl;

@property (nonatomic,strong) UILabel* moneyLbl;

@property (nonatomic,strong) UILabel* profitLbl;

-(void)reload:(PosTradeModel*)model;

@end

NS_ASSUME_NONNULL_END
