//
//  BaseSTDCellModel.m
//  BOB
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseSTDCellModel.h"

@implementation BaseSTDCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textNumberOfLines = 1;
        self.detailTextNumberOfLines = 1;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return self;
}

+ (instancetype)model:(NSString *)text rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC jumpParam:(NSDictionary *)jumpParam {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.text = text;
    model.jumpVC = jumpVC;
    model.jumpParam = jumpParam;
    model.rightIcon = rightIcon;
    return model;
}

+ (instancetype)model:(NSString *)text jumpVC:(NSString *)jumpVC rightIcon:(NSString *)rightIcon {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.text = text;
    model.jumpVC = jumpVC;
    model.rightIcon = rightIcon;
    return model;
}

+ (instancetype)model:(NSString *)text detailText:(NSString *)detailText jumpVC:(NSString *)jumpVC rightIcon:(NSString *)rightIcon {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.text = text;
    model.detailText = detailText;
    model.rightIcon = rightIcon;
    return model;
}

+ (instancetype)model:(NSString *)icon text:(NSString *)text rightIcon:(NSString *)rightIcon tip:(NSString *)tip jumpVC:(NSString *)jumpVC {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.leftIcon = icon;
    model.text = text;
    model.rightIcon = rightIcon;
    model.tipText = tip;
    model.jumpVC = jumpVC;
    return model;
}

+ (instancetype)model:(NSString *)icon text:(NSString *)text rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.leftIcon = icon;
    model.text = text;
    model.rightIcon = rightIcon;
    model.jumpVC = jumpVC;
    return model;
}

+ (instancetype)model:(NSString *)icon text:(NSString *)text rightIcon:(NSString *)rightIcon tip:(NSString *)tip rightImgUrl:(NSString *)rightImgUrl jumpVC:(NSString *)jumpVC {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.leftIcon = icon;
    model.text = text;
    model.rightIcon = rightIcon;
    model.tipText = tip;
    model.rightImgUrl = rightImgUrl;
    model.jumpVC = jumpVC;
    return model;
}

+ (instancetype)model:(NSString *)text detailText:(NSString *)detailText rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.text = text;
    model.detailText = detailText;
    model.rightIcon = rightIcon;
    model.jumpVC = jumpVC;
    return model;
}

+ (instancetype)model:(NSString *)icon text:(NSString *)text detailText:(NSString *)detailText rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.leftIcon = icon;
    model.text = text;
    model.detailText = detailText;
    model.rightIcon = rightIcon;
    model.jumpVC = jumpVC;
    return model;
}

+ (instancetype)model:(NSString *)text rightImgUrl:(NSString *)rightImgUrl rightIcon:(NSString *)rightIcon jumpVC:(NSString *)jumpVC {
    BaseSTDCellModel *model = [[BaseSTDCellModel alloc] init];
    model.text = text;
    model.rightIcon = rightIcon;
    model.rightImgUrl = rightImgUrl;
    model.jumpVC = jumpVC;
    return model;
}
@end
