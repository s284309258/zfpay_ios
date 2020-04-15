//
//  PosInputInquiryView.m
//  XZF
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "PosInputInquiryView.h"
static NSInteger padding = 15;
@interface PosInputInquiryView()

@property (nonatomic,strong) UILabel* name;

@property (nonatomic,strong) UILabel* apply;

@property (nonatomic,strong) UILabel* shop;

@property (nonatomic,strong) UIButton* detail;

@property (nonatomic,strong) MXSeparatorLine* line;

@end
@implementation PosInputInquiryView
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
        [self layout];
    }
        
    return self;
}
- (id)init{
    self=[super init];
    
    if (self) {
        [self initUI];
        [self layout];
    }
    
    return self;
}

-(void)initUI{
    [self addSubview:self.name];
    [self addSubview:self.apply];
    [self addSubview:self.shop];
    [self addSubview:self.detail];
    [self addSubview:self.line];
}

-(void)layout{
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self.apply.mas_top).offset(-5);
    }];
    [self.apply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name);
        make.centerY.equalTo(self);
        make.right.equalTo(self.detail.mas_left);
    }];
    [self.shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name);
        make.top.equalTo(self.apply.mas_bottom).offset(5);
    }];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.shop);
        make.right.equalTo(self).offset(-padding);
        make.width.equalTo(@(50));
        make.height.equalTo(@(25));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.bottom.equalTo(self);
        make.left.equalTo(self.name);
        make.right.equalTo(self.detail);
    }];
}

-(MXSeparatorLine*)line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    }
    return _line;
}

-(UILabel*)name{
    if (!_name) {
        _name = [UILabel new];
        _name.font = [UIFont boldFont17];
    }
    return _name;
}

-(UILabel*)apply{
    if (!_apply) {
        _apply = [UILabel new];
        _apply.font = [UIFont font14];
        _apply.textColor = [UIColor moPlaceHolder];
    }
    return _apply;
}

-(UILabel*)shop{
    if (!_shop) {
        _shop = [UILabel new];
        _shop.font = [UIFont font14];
        _shop.textColor = [UIColor moPlaceHolder];
    }
    return _shop;
}

-(UIButton*)detail{
    if (!_detail) {
        _detail = [UIButton buttonWithType:UIButtonTypeCustom];
        _detail.layer.masksToBounds = YES;
        _detail.layer.borderColor = [UIColor moGreen].CGColor;
        _detail.layer.borderWidth = 1;
        [_detail setTitleColor:[UIColor moGreen] forState:UIControlStateNormal];
        [_detail setTitle:@"详情" forState:UIControlStateNormal];
        _detail.titleLabel.font = [UIFont font14];
        _detail.layer.masksToBounds = YES;
        _detail.layer.cornerRadius = 5;
        [_detail addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detail;
}

-(void)showDetail:(id)sender{
    if (self.showDetail) {
        self.showDetail(nil);
    }
}

-(void)reload:(PosInputInquiryModel*)model type:(NSString*)type{
    if ([type isEqualToString:@"check"]) {
        self.name.text = model.merchant_name;
        self.apply.text = [NSString stringWithFormat:@"商户号:%@",model.mer_code];
        self.shop.text =  [NSString stringWithFormat:@"审核时间:%@",model.cre_datetime];
    }else{
        self.name.text = model.merchant_name;
        self.apply.text =  [NSString stringWithFormat:@"退回原因:%@",model.biz_msg];
        self.shop.text =  [NSString stringWithFormat:@"审核时间:%@",model.cre_datetime];
    }
   
}
@end
