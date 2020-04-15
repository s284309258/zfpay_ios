//
//  TextSwitchView.h
//  MOC
//
//  Created by mac on 2019/7/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextSwitchView : UIView

@property (nonatomic, strong) CompletionBlock block;

@property (nonatomic, strong) UISwitch         *btn;

-(void)reload:(NSString* )title state:(NSString*)state;

-(void)setLeftPadding:(NSInteger)left;

@end

NS_ASSUME_NONNULL_END
