//
//  RewardOverlayView.m
//  XZF
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "RewardOverlayView.h"
#import "UIButton+ActionBlock.h"
@interface RewardOverlayView()

@property (nonatomic,strong) UIImageView* image;

@property (nonatomic,strong) UILabel* text;

@property (nonatomic,strong) UILabel* desc;

@property (nonatomic,strong) UIButton* left;

@property (nonatomic,strong) UIButton* right;

@end
@implementation RewardOverlayView

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 15;
    [self addSubview:self.image];
    [self addSubview:self.text];
    [self addSubview:self.desc];
    [self addSubview:self.left];
    [self addSubview:self.right];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(140));
        make.height.equalTo(@(110));
        make.top.equalTo(self).offset(-35);
        make.centerX.equalTo(self);
    }];
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.mas_bottom).offset(30);
        make.centerX.equalTo(self);
    }];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.text.mas_bottom).offset(15);
        make.centerX.equalTo(self);
    }];
    [self.left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20));
        make.width.equalTo(@(100));
        make.bottom.equalTo(@(-20));
        make.height.equalTo(@(32));
    }];
    [self.right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.width.equalTo(@(100));
        make.bottom.equalTo(@(-20));
        make.height.equalTo(@(32));
    }];
}

-(UIImageView*)image{
    if (!_image) {
        _image = [UIImageView new];
        _image.image = [UIImage imageNamed:@"reward_icon"];
    }
    return _image;
}

-(UILabel*)text{
    if (!_text) {
        _text = [UILabel new];
        _text.font = [UIFont boldSystemFontOfSize:18];
        _text.textColor = [UIColor moBlack];
    }
    return _text;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.numberOfLines = 0;
        _desc.font = [UIFont font12];
        _desc.textColor = [UIColor moRed];
        _desc.textAlignment = NSTextAlignmentCenter;
        NSString* str = @"交易量达标奖励只可领取一次，\n是否确认领取？";
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
        [attr setLineSpacing:10 substring:str alignment:NSTextAlignmentCenter];
        [attr addFont:[UIFont font12] substring:str];
        [attr addColor:[UIColor moRed] substring:str];
        _desc.attributedText = attr;
    }
    return _desc;
}

-(UIButton*)left{
    if (!_left) {
        _left = [UIButton buttonWithType:UIButtonTypeCustom];
        _left.layer.cornerRadius = 16;
        _left.layer.borderColor = [UIColor grayColor].CGColor;
        _left.layer.borderWidth = .5;
        [_left setBackgroundColor:[UIColor whiteColor]];
        [_left setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_left setTitle:@"取消" forState:UIControlStateNormal];
        _left.titleLabel.font = [UIFont font15];
    }
    return _left;
}

-(UIButton*)right{
    if (!_right) {
        _right = [UIButton buttonWithType:UIButtonTypeCustom];
        _right.titleLabel.font = [UIFont font15];
        [_right setBackgroundColor:[UIColor colorWithHexString:@"#20CC9AFF"]];
        _right.layer.cornerRadius = 16;
        [_right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_right setTitle:@"确认" forState:UIControlStateNormal];
        _right.layer.shadowOpacity = 1;
        _right.layer.shadowRadius = 5;
        _right.layer.shadowColor = [UIColor colorWithHexString:@"#89D3BEFF"].CGColor;
        _right.layer.shadowOffset = CGSizeMake(0, 2);
    }
    return _right;
}



+(void)showInView:(UIView*)inView text:(NSString*)text confirm:(dispatch_block_t)confirm cancel:(dispatch_block_t)cancel{
    UIView* blank = [inView viewWithTag:100001];
    if (!blank) {
        RewardOverlayView* blank = [RewardOverlayView new];
        blank.text.text = text;
        __block dispatch_block_t confirmBlock = confirm;
        __block dispatch_block_t cancelBlock = cancel;
        [blank.left addAction:^(UIButton *btn) {
            !cancelBlock?:cancelBlock();
        }];
        [blank.right addAction:^(UIButton *btn) {
            !confirmBlock?:confirmBlock();
        }];
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor colorWithHexString:@"#666666" alpha:.8];
        [inView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(inView);
        }];
       backView.tag = 100001;
       [backView addSubview:blank];
       [blank mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.height.equalTo(@(260));
           make.centerX.equalTo(backView);
           make.centerY.equalTo(backView);
       }];
    }
}

+(void)hiddenInView:(UIView*)inView {
    UIView* blank = [inView viewWithTag:100001];
    if (blank) {
        [blank removeFromSuperview];
    }
}
@end
