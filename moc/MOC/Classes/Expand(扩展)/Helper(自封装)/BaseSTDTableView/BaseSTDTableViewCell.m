//
//  BaseSTDTableViewCell.m
//  BOB
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseSTDTableViewCell.h"

@interface BaseSTDTableViewCell ()
@property(nonatomic, strong) UIButton *tipBnt;
@property(nonatomic, strong) UIImageView *leftImgView;
@property(nonatomic, strong) UIImageView *rightImgView;
@property(nonatomic, strong) UIImageView *arrowImgView;
@property(nonatomic, strong) UILabel *textLbl;
@property(nonatomic, strong) UIButton *detailTextBnt;
@property(nonatomic, strong) UIView *line;
@end

@implementation BaseSTDTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
}

- (void)setupCell
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.contentView addSubview:self.leftImgView];
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(0));
        make.height.equalTo(@(0));
    }];
    
    [self.contentView addSubview:self.textLbl];
    [self.textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.detailTextBnt];
    [self.detailTextBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLbl.mas_right).offset(15);
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.arrowImgView];
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.contentView);
    }];

    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(1));
    }];
}

- (void)loadContent
{
    if([self.data isKindOfClass:[BaseSTDCellModel class]]) {
        BaseSTDCellModel *model = (BaseSTDCellModel *)self.data;
        
        self.arrowImgView.image = [UIImage imageNamed:model.rightIcon];
        
        [self configLeftImgView:model];
        [self configTextLbl:model];
        [self configDetailTextLbl:model];
        
        
        [self installTipBnt:model.tipText];
        [self installRightImgView:model.rightImgUrl];

        self.line.hidden = model.hideBottomLine;
    } else if([self.data isKindOfClass:[NSString class]]) {
        self.textLbl.text = self.data;
    }
}

- (void)configLeftImgView:(BaseSTDCellModel *)model {
    if(model.leftIcon == nil || model.leftIcon.length <= 0) {
        return;
    }
    
    UIImage *icon = [UIImage imageNamed:model.leftIcon];
    self.leftImgView.image = icon;
    if(model.leftIconBGColor) {
        self.leftImgView.backgroundColor = model.leftIconBGColor;
    }
    
    if(CGRectIsEmpty(model.leftIconRect)) {
        [self.leftImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(icon.size.width));
            make.height.equalTo(@(icon.size.height));
        }];
    } else {
        [self.leftImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(model.leftIconRect.origin.x > 0 ? model.leftIconRect.origin.x : 15));
            if(model.leftIconRect.origin.y > 0) {
                make.top.equalTo(@(model.leftIconRect.origin.y));
            } else {
                make.centerY.equalTo(self.contentView);
            }
            
            if(model.leftIconRect.size.width > 0) {
                make.width.equalTo(@(model.leftIconRect.size.width));
            } else {
                make.width.equalTo(@(icon.size.width));
            }
            
            if(model.leftIconRect.size.height > 0) {
                make.height.equalTo(@(model.leftIconRect.size.height));
            } else {
                make.height.equalTo(@(icon.size.height));
            }
        }];
    }
    
    if(icon == nil) { ///加载网络图片
        NSURL *imgUrl = [NSURL URLWithString:model.leftIcon];
        [self.leftImgView sd_setImageWithURL:imgUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    
    if(CGRectIsEmpty(model.textRect)) {
        [self.textLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImgView.mas_right).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
    } else {
        [self.textLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            if(model.textRect.origin.y > 0) {
                make.top.equalTo(@(model.textRect.origin.y));
            } else {
                make.centerY.equalTo(self.contentView);
            }
            
            if(model.textRect.origin.x > 0) {
                make.left.equalTo(@(model.textRect.origin.x));
            } else {
                make.left.equalTo(self.leftImgView.mas_right).offset(15);
            }
        }];
    }
    
    if(model.cornerRadius > 0) {
        self.leftImgView.layer.cornerRadius = model.cornerRadius;
        self.leftImgView.clipsToBounds = YES;
    }
    
}

- (void)configTextLbl:(BaseSTDCellModel *)model {
    self.textLbl.numberOfLines = model.textNumberOfLines;
    self.textLbl.font = model.textFont ?: self.textLbl.font;
    
    if([model.text isKindOfClass:[NSString class]]) {
        self.textLbl.text = model.text;
        self.textLbl.textColor = model.textColor ?: [UIColor blackColor];
    } else if([model.text isKindOfClass:[NSMutableAttributedString class]]) {
        self.textLbl.attributedText = model.text;
    }
}

- (void)configDetailTextLbl:(BaseSTDCellModel *)model {
    self.detailTextBnt.titleLabel.numberOfLines = model.detailTextNumberOfLines;
    self.detailTextBnt.titleLabel.font = model.detailTextFont ?: self.detailTextBnt.titleLabel.font;
    [self.detailTextBnt setContentHorizontalAlignment:model.contentHorizontalAlignment];
    
    if([model.detailText isKindOfClass:[NSString class]]) {
        [self.detailTextBnt setTitle:model.detailText forState:UIControlStateNormal];
        [self.detailTextBnt setTitleColor:model.detailTextColor ?: [self.detailTextBnt titleColorForState:UIControlStateNormal] forState:UIControlStateNormal];
    } else if([model.detailText isKindOfClass:[NSMutableAttributedString class]]) {
        [self.detailTextBnt setAttributedTitle:model.detailText forState:UIControlStateNormal];
    }
    
    self.detailTextBnt.clipsToBounds = model.detailTextCornerRadius > 0;
    self.detailTextBnt.layer.cornerRadius = model.detailTextCornerRadius;
    self.detailTextBnt.layer.borderColor = model.detailTextBorderColor.CGColor;
    self.detailTextBnt.layer.borderWidth = model.detailTextBorderWidth;
    
    if(model.rightIcon != nil && model.rightIcon.length > 0) {
        [self.detailTextBnt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-self.arrowImgView.image.size.width-15-11));
        }];
    }
}

- (void)installTipBnt:(NSString *)text {
    if(text == nil) {
        self.tipBnt.hidden = YES;
        return;
    }
    
    self.tipBnt.hidden = NO;
    
    if([self.tipBnt superview] == nil) {
        [self.contentView addSubview:self.tipBnt];
    }
    
    [self.tipBnt setTitle:text forState:UIControlStateNormal];
    [self.tipBnt mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.arrowImgView.mas_left).offset(-8);
        make.height.equalTo(@(15));
    }];
}

- (void)installRightImgView:(NSString *)imgUrl {
    if(imgUrl == nil) {
        self.rightImgView.hidden = YES;
        return;
    }
    self.rightImgView.hidden = NO;
    
    if([self.rightImgView superview] == nil) {
        [self.contentView addSubview:self.rightImgView];
        [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(13));
            make.bottom.equalTo(@(-13));
            if(self.arrowImgView.image != nil) {
                make.right.equalTo(self.arrowImgView.mas_left).offset(-12);
            } else {
                make.right.equalTo(@(-33));
            }
            
            make.width.equalTo(self.rightImgView.mas_height);
        }];
    }
    
    [self.rightImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:12 options:UIViewAnimationOptionCurveLinear animations:^{
        if (highlighted) {
            self.textLbl.transform = CGAffineTransformMakeScale(0.98, 0.98);
        } else {
            self.textLbl.transform = CGAffineTransformIdentity;
        }
    } completion:nil];
}

- (UIButton *)tipBnt {
    if(!_tipBnt) {
        _tipBnt = [[UIButton alloc] init];
        _tipBnt.backgroundColor = [UIColor colorWithHexString:@"#E93D3D"];
        _tipBnt.clipsToBounds = YES;
        _tipBnt.layer.cornerRadius = 7.5;
        _tipBnt.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _tipBnt;
}

- (UIImageView *)leftImgView {
    if(!_leftImgView) {
        _leftImgView = [[UIImageView alloc] init];
    }
    return _leftImgView;
}

- (UIImageView *)rightImgView {
    if(!_rightImgView) {
        _rightImgView = [[UIImageView alloc] init];
        _rightImgView.clipsToBounds = YES;
        _rightImgView.layer.cornerRadius = 17;
    }
    return _rightImgView;
}

- (UIImageView *)arrowImgView {
    if(!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] init];
    }
    return _arrowImgView;
}

- (UILabel *)textLbl {
    if(!_textLbl) {
        _textLbl = [[UILabel alloc] init];
        _textLbl.font = [UIFont systemFontOfSize:14];
        _textLbl.textColor = [UIColor colorWithHexString:@"#323333"];
    }
    return _textLbl;
}

- (UIButton *)detailTextBnt {
    if(!_detailTextBnt) {
        _detailTextBnt = [[UIButton alloc] init];
        _detailTextBnt.titleLabel.font = [UIFont systemFontOfSize:14];
        [_detailTextBnt setTitleColor:[UIColor colorWithHexString:@"#AFB2B3"] forState:UIControlStateNormal];
        _detailTextBnt.userInteractionEnabled = NO;
        [_detailTextBnt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _detailTextBnt;
}
@end
