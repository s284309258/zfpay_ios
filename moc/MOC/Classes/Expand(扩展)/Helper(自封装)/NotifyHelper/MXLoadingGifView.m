//
//  MXLoadingGifView.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 16/7/29.
//  Copyright © 2016年 MoXian. All rights reserved.
//

#import "MXLoadingGifView.h"
#import "MXUI.h"
@interface MXLoadingGifView ()

@property (nonatomic, strong) UIImageView *gifView;
@property (nonatomic, strong) UILabel     *titleLbl;

@end

@implementation MXLoadingGifView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)show {
    self.hidden = NO;
    [self.gifView startAnimating];
}

- (void)hide {
    self.hidden = YES;
    [self.gifView stopAnimating];
}

- (void)layoutView {
    [self.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.gifView.mas_bottom).offset(4);
    }];
}

- (void)initUI {
    [self addSubview:self.gifView];
    [self addSubview:self.titleLbl];
    [self layoutView];
}

- (UIImageView *)gifView {
	if (!_gifView) {
        _gifView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _gifView.animationDuration = 0.5;
        @autoreleasepool {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:2];
            for (NSInteger i = 1; i < 7; i++) {
                NSString *name = [NSString stringWithFormat:@"moya%@_nor", @(i)];
                UIImage *image = [UIImage imageNamed:name];
                if (image) {
                    [data addObject:image];
                }
            }
            
            _gifView.animationImages = [data copy];
        }
	}
    
	return _gifView;
}

- (UILabel *)titleLbl {
	if (!_titleLbl) {
        _titleLbl = [MXUI labelFont:[UIFont font14] textColor:[UIColor moDarkGray]];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.text = @"正在努力加载中...";
	}
    
	return _titleLbl;
}

@end
