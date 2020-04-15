//
//  FastTradingItemCell.m
//  Lcwl
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "ScanPayPhotoCell.h"
#import "SPButton.h"
#import "QNManager.h"
static NSInteger width = 140;
static NSInteger height = 90;
@interface ScanPayPhotoCell ()

@property (nonatomic, strong) SPButton* upload;

@property (nonatomic, strong) UIImageView *back;

@property (nonatomic, strong) UILabel *bottom;

@end

@implementation ScanPayPhotoCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - UI
- (void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.back];
    [self.back addSubview:self.upload];
    [self addSubview:self.bottom];
    [self layout];
}

-(void)layout{
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
        make.top.equalTo(self);
        make.centerX.equalTo(self);
    }];
    [self.upload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(60));
        make.centerX.equalTo(self.back);
        make.centerY.equalTo(self.back);
    }];
    [self.bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.back.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
}

- (SPButton *)upload{
    if (!_upload) {
        _upload = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _upload.frame = CGRectMake(0, 0, 50, 50);
        _upload.imagePosition = SPButtonImagePositionTop;
        [_upload setTitle:@"点击上传" forState:UIControlStateNormal];
        [_upload setTitleColor:[UIColor moPlaceHolder] forState:UIControlStateNormal];
        _upload.titleLabel.font = [UIFont font12];
        [_upload setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
        _upload.layer.masksToBounds = YES;
        [_upload addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upload;
}

-(void)upload:(id)sender{
    if (self.block) {
        self.block(nil);
    }
}

- (UIImageView *)back{
    if (!_back) {
        _back = [UIImageView new];
        _back.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _back.userInteractionEnabled = YES;
    }
    return _back;
}

-(UILabel*)bottom{
    if (!_bottom) {
        _bottom = [UILabel new];
        _bottom.font = [UIFont font15];
        _bottom.text = @"营业执照";
        _bottom.textColor = [UIColor moBlack];
    }
    return _bottom;
}


-(void)reload:(NSString*)image title:(NSString*)title{
    self.bottom.text = title;
    if ([StringUtil isEmpty:image]) {
        self.upload.hidden =NO;
        [self.back sd_setImageWithURL:[NSURL URLWithString:@""]];
    }else{
        self.upload.hidden =YES;
        NSString* url = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,image];
        [self.back sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    }
}
@end
