//
//  PhoneNumView2.h
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LoginRegModel;
//文本
@interface PhoneNumView2 : UIView

@property (nonatomic , strong) CompletionBlock getText;

@property (nonatomic,strong) UILabel *descLbl;

@property (nonatomic,strong) MXSeparatorLine    *line;

@property (nonatomic,strong) UILabel *titleLbl;

-(void)reloadTitle:(NSString *) title desc:(NSString *)desc;

@end


NS_ASSUME_NONNULL_END
