//
//  ArticleListView.m
//  AdvertisingMaster
//
//  Created by mac on 2019/4/10.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ArticleListView.h"
#import "NewsListModel.h"
#import "QNManager.h"
static NSInteger padding = 15;
@interface ArticleListView ()

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *descLbl;

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) MXSeparatorLine *line;

@property (nonatomic, strong) UIImageView *signImg;

@property (nonatomic, strong) UILabel *signLbl;

@end
@implementation ArticleListView

- (id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    [self addSubview:self.titleLbl];
    [self addSubview:self.descLbl];
    [self addSubview:self.img];
    [self addSubview:self.signImg];
    [self addSubview:self.signLbl];
    
    self.line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    [self addSubview:self.line];
    @weakify(self)
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).offset(0);
        make.top.equalTo(self.mas_top).offset(padding);
        make.right.equalTo(self.img.mas_left).offset(-padding);
    }];
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.titleLbl.mas_left);
        make.right.equalTo(self.signImg.mas_left);
        make.height.equalTo(@(20));
        make.bottom.equalTo(self.mas_bottom).offset(-padding);
        
    }];
    [self.signImg mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.signLbl.mas_left).offset(-5);
        make.centerY.equalTo(self.descLbl.mas_centerY);
        make.width.equalTo(@(12));
        make.height.equalTo(@(12));
    }];
    
    [self.signLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.img.mas_left);
        make.centerY.equalTo(self.descLbl.mas_centerY);
        make.width.equalTo(@(40));
        make.height.equalTo(@(15));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.mas_right).offset(-0);
        make.top.equalTo(self.mas_top).offset(padding);
        make.bottom.equalTo(self.mas_bottom).offset(-padding);
        make.width.equalTo(self.img.mas_height).multipliedBy(1.5);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.titleLbl);
        make.right.equalTo(self.img);
        make.height.equalTo(@(1));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLbl.font = [UIFont font15];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.numberOfLines = 2;
        _titleLbl.text = @"上海地铁站破石机\n贫困山区";
    }
    
    return _titleLbl;
}

- (UILabel *)descLbl
{
    if (!_descLbl) {
        _descLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLbl.font = [UIFont font14];
        _descLbl.textColor = [UIColor lightGrayColor];
        _descLbl.text = @"2019.08.12 12:00";
    }
    
    return _descLbl;
}

- (UILabel *)signLbl
{
    if (!_signLbl) {
        _signLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        _signLbl.font = [UIFont systemFontOfSize:13];
        _signLbl.textColor = [UIColor lightGrayColor];
        _signLbl.text = @"1";
    }
    
    return _signLbl;
}

- (UIImageView *)img {
    if(!_img) {
        _img = [[UIImageView alloc] init];
        _img.contentMode = UIViewContentModeScaleToFill;
        _img.layer.masksToBounds = YES;
        _img.layer.cornerRadius = 5;
        _img.image = [UIImage imageNamed:@"AppIcon"];
    }
    return _img;
}

- (UIImageView *)signImg {
    if(!_signImg) {
        _signImg = [[UIImageView alloc] init];
        _signImg.contentMode = UIViewContentModeScaleToFill;
        _signImg.image = [UIImage imageNamed:@"浏览"];
    }
    return _signImg;
}
-(void)reloadData:(NewsListModel *)model{
    self.titleLbl.text = model.news_title;
    self.descLbl.text = model.cre_date;
    self.signLbl.text = model.browse_num;
   
    [self.img sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,model.news_cover]] placeholderImage:nil];
}

@end
