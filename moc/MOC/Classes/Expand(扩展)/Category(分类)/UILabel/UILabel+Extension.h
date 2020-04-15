//
//  UILabel+Extension.h
//  Lcwl
//
//  Created by mac on 2018/12/2.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)
-(void)count:(CGFloat)toValue completion:(CompletionBlock)block;
- (void)addGestureRecognizer:(nullable id)target action:(nullable SEL)action;
@end

NS_ASSUME_NONNULL_END
