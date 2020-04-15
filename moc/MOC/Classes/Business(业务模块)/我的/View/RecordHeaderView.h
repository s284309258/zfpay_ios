//
//  RecordHeaderView.h
//  MOC
//
//  Created by mac on 2019/6/20.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecordHeaderView : UIView

@property (nonatomic ,strong) UIButton* tipBtn;

@property (nonatomic ,strong) CompletionBlock block;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
