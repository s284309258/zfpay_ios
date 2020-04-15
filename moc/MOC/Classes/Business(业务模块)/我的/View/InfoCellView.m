//
//  RingListView.m
//  Lcwl
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019年 lichangwanglai. All rights reserved.
//

#import "InfoCellView.h"
@interface InfoCellView ()



@end
static int padding = 0;
static int avatarHeight = 18;
@implementation InfoCellView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.titleLbl];
    [self addSubview:self.descLbl];
    [self addSubview:self.rightImg];
    [self addSubview:self.line];
}

-(void)layout{
    [self.titleLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.rightImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(7));
        make.height.equalTo(@(13));
    }];
    [self.descLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImg.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl.mas_left);
        make.right.equalTo(self.rightImg.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.height.equalTo(@(0.5));
        
    }];
    return;
}

-(MXSeparatorLine *)line{
    if (!_line) {
        _line =[MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    }
    return _line;
}

- (UIImageView *)rightImg
{
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _rightImg.image = [UIImage imageNamed:@"icon_arrow"];
    }
    return _rightImg;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.text = @"";
        _titleLbl.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLbl;
}

- (UILabel *)descLbl
{
    if (!_descLbl) {
        _descLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLbl.text = @"";
        _descLbl.font = [UIFont systemFontOfSize:13];
        _descLbl.textColor = [UIColor redColor];
    }
    
    return _descLbl;
}

-(void)reloadTitle:(NSString* )title desc:(NSString* )desc{
    self.titleLbl.text = title;
    if([desc isKindOfClass:[NSAttributedString class]]) {
        self.descLbl.attributedText = desc;
    } else if([desc isKindOfClass:[NSString class]]) {
        self.descLbl.text = desc;
    }
}


@end
