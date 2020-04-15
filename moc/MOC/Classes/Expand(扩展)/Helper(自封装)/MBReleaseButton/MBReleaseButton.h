//
//  MBReleaseButton.h
//  MoPromo_Develop
//
//  Created by yang.xiangbao on 15/5/19.
//  Copyright (c) 2015年 MoPromo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReleaseButtonBlock)(UIButton *sender);

@interface MBReleaseButton : UIView

@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) ReleaseButtonBlock releaseAction;

- (instancetype)initWithFrame:(CGRect)frame logoOffset:(CGFloat)logoYOffset;

- (instancetype)initWithFrame:(CGRect)frame
                   logoOffset:(CGFloat)logoYOffset
                 titleYOffset:(CGFloat)titleOffset;

- (void)setEnable:(BOOL)enable;

/**
 *  配置按钮的标题，图标
 *
 *  @param title    标题
 *  @param iconName 图标名字
 */
- (void)configureTitle:(NSString*)title icon:(NSString*)iconName;

@end
