//
//  TextTextTextView.h
//  XZF
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextTextTextView : UIView

@property (nonatomic, strong) UILabel         *tip;

-(void)reloadTop:(NSString *)top bottom:(NSString *)bottom right:(NSString* )right;
    
@end

NS_ASSUME_NONNULL_END
