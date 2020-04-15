//
//  BaseSTDCellModel.h
//  BOB
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

//NS_ASSUME_NONNULL_BEGIN

@interface BaseSTDCellModel : BaseObject
@property(nonatomic, copy) NSString *leftIcon;
@property(nonatomic, strong) UIColor *leftIconBGColor;
@property(nonatomic, assign) CGRect leftIconRect;
@property(nonatomic, assign) CGFloat cornerRadius;

@property(nonatomic, copy) NSString *rightIcon;
///text可以传NSString 或者NSMutableAttributedString
@property(nonatomic, strong) id text;
@property(nonatomic, assign) CGRect textRect;
@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, assign) NSInteger textNumberOfLines;

///detailText可以传NSString 或者NSMutableAttributedString
@property(nonatomic, strong) id detailText;
@property(nonatomic, strong) UIFont *detailTextFont;
@property(nonatomic, assign) NSInteger detailTextNumberOfLines;
@property(nonatomic, strong) UIColor *detailTextColor;
@property(nonatomic, strong) UIColor *detailTextBorderColor;
@property(nonatomic, assign) CGFloat detailTextBorderWidth;
@property(nonatomic, assign) CGFloat detailTextCornerRadius;
@property(nonatomic, assign) UIControlContentHorizontalAlignment contentHorizontalAlignment;


@property(nonatomic, copy) NSString *tipText;
@property(nonatomic, copy) NSString *rightImgUrl;
@property(nonatomic, copy) NSString *jumpVC;
@property(nonatomic, strong) NSDictionary *jumpParam;
@property(nonatomic, copy) NSString *last_id;
@property(nonatomic, assign) BOOL hideBottomLine;

@property(nonatomic, copy) NSString *alertTip;
@property(nonatomic, strong) id extra;

+ (instancetype)model:(NSString *)text rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC jumpParam:(NSDictionary *)jumpParam;

+ (instancetype)model:(NSString *)text jumpVC:(NSString *)jumpVC rightIcon:(NSString *)rightIcon;

+ (instancetype)model:(NSString *)text detailText:(NSString *)detailText jumpVC:(NSString *)jumpVC;

+ (instancetype)model:(NSString *)text detailText:(NSString *)detailText jumpVC:(NSString *)jumpVC rightIcon:(NSString *)rightIcon;

+ (instancetype)model:(NSString *)icon text:(NSString *)text rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC;

+ (instancetype)model:(NSString *)icon text:(NSString *)text rightIcon:(NSString *)rightIcon tip:(NSString *)tip rightImgUrl:(NSString *)rightImgUrl jumpVC:(NSString *)jumpVC;

+ (instancetype)model:(NSString *)icon text:(NSString *)text rightIcon:(NSString *)rightIcon tip:(NSString *)tip jumpVC:(NSString *)jumpVC;

+ (instancetype)model:(NSString *)text detailText:(NSString *)detailText rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC;

+ (instancetype)model:(NSString *)text rightImgUrl:(NSString *)rightImgUrl rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC;

+ (instancetype)model:(NSString *)icon text:(NSString *)text detailText:(NSString *)detailText rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC;
@end

//NS_ASSUME_NONNULL_END
