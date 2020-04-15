//
//  RecallBottomView.h
//  XZF
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecallBottomView : UIView


@property(nonatomic, strong) SPButton *btn;

@property (nonatomic,strong) CompletionBlock allBlock;

@property (nonatomic,strong) CompletionBlock agreeBlock;

@property (nonatomic,strong) CompletionBlock disagreeBlock;

-(void)updateAllNum:(int)count;

@end

NS_ASSUME_NONNULL_END
