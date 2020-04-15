//
//  YQInputPayKeyWordView.h
//  Youqun
//
//  Created by 王崇磊 on 16/6/1.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCLPassWordView.h"

@interface YQInputPayKeyWordView : UIView

@property (strong, nonatomic)  UILabel *moneyLbl;

@property (strong, nonatomic)  UILabel *tipLbl;

@property (strong, nonatomic)  UILabel *leftLbl;

@property (strong, nonatomic)  UILabel *rightLbl;

@property (strong, nonatomic)  MXSeparatorLine* line;

@property (strong, nonatomic)  WCLPassWordView *passWord;

+ (instancetype)initFromNibSelectBlock:(void(^)(void))block ;

-(void)layoutNormal;

-(void)layoutQuota:(NSDictionary*)dict;

@end
