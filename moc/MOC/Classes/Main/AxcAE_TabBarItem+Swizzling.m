//
//  AxcAE_TabBarItem+Swizzling.m
//  MOC
//
//  Created by mac on 2019/7/26.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AxcAE_TabBarItem+Swizzling.h"
#import <objc/runtime.h>
@implementation AxcAE_TabBarItem (Swizzling)
//+ (void)load {
//    Method originalMethod = class_getInstanceMethod([AxcAE_TabBarItem class], NSSelectorFromString(@"setIsSelect:"));
//    Method swapMethod = class_getInstanceMethod([AxcAE_TabBarItem class], NSSelectorFromString(@"customSetIsSelect:"));
//    method_exchangeImplementations(originalMethod, swapMethod);
//}

- (void)customSetIsSelect:(BOOL)isSelect{
    [self customSetIsSelect:isSelect];
    if (isSelect) {
        UIColor *tmpColor = [UIColor colorWithRed:158.0/255.0 green:96.0/255.0 blue:18.0/255.0 alpha:1.0];
        NSDictionary *dict = @{
                               NSStrokeColorAttributeName:tmpColor,
                               NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-4],
                               NSForegroundColorAttributeName:self.titleLabel.textColor,
                               NSFontAttributeName:self.titleLabel.font
                               };
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:self.title attributes:dict];
        
        self.titleLabel.attributedText = attribtStr;
    }else{
         self.titleLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:self.title];
    }
}
@end
