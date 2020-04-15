//
//  ProfitFormView.h
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitFormView : UIView

@property (nonatomic , strong) UILabel* typeLbl;

@property (nonatomic , strong) UILabel* moneyLbl;

@property (nonatomic , strong) UIButton* detailBtn;

@property (nonatomic , strong) MXSeparatorLine* line;

-(void)reloadData:(NSString *) type money:(NSString *)money btnTitle: (NSString *)title;

-(void)reloadData:(NSString *) type money:(NSString *)money;

@end

NS_ASSUME_NONNULL_END
