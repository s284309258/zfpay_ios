//
//  SettingHeader.m
//  XZF
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "SettingHeader.h"
#import "QNManager.h"
static NSInteger padding = 15;
@interface SettingHeader()

@property (nonatomic ,strong) UIImageView* avatar;

@property (nonatomic ,strong) UIImageView* arrow;

@property (nonatomic ,strong) UILabel* title;


@end
@implementation SettingHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.avatar];
    [self addSubview:self.arrow];
    [self addSubview:self.title];
}

-(void)layout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(padding));
        make.centerY.equalTo(self);
    }];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@(13));
    }];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(50));
        make.centerY.equalTo(self);
        make.right.equalTo(self.arrow.mas_left).offset(-5);
    }];
}
-(UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [UIImageView new];
        _avatar.backgroundColor = [UIColor lightGrayColor];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 25;
    }
    return _avatar;
}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"更多"];
    }
    return _arrow;
}

-(UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont font15];
        _title.text = @"头像";
    }
    return _title;
}

-(void)reload:(NSString* )title image:(NSString*)image{
    self.title.text = title;
    NSString* path = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,image];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:path]];
}


@end
