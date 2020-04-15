//
//  RFHeader.h
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface RFHeader : UIView

@property (nonatomic ,strong) CompletionBlock block;

@property (nonatomic ,strong) SPButton* rightLbl;

- (void)reloadColor:(NSString *)color left:(NSString* )left right:(NSString* )right;

- (void)reloadColor:(NSString *)color left:(NSString* )left rightImg:(NSString*)image rightText:(NSString*)text;

+(int)getHeight;

@end

NS_ASSUME_NONNULL_END
