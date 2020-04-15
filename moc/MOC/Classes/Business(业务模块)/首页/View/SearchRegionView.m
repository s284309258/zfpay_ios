//
//  SearchRegionView.m
//  XZF
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "SearchRegionView.h"
@interface SearchRegionView()

@property (nonatomic ,strong) UITextField* tf1;

@property (nonatomic ,strong) UITextField* tf2;

@property (nonatomic ,strong) UILabel* separate;

@property (nonatomic ,strong) UIButton* btn;

@end

@implementation SearchRegionView

- (id)init{
    self=[super init];
    
    if (self) {
        [self initUI];
        [self layout];
    }
    
    return self;
}

-(void)initUI{
    [self addSubview:self.tf1];
    [self addSubview:self.separate];
    [self addSubview:self.tf2];
    [self addSubview:self.btn];
}

-(void)layout{
    [self.tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.width.equalTo(@(120));
        make.left.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.separate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tf1.mas_right).offset(2);
        make.centerY.equalTo(self);
        make.width.equalTo(@(10));
        make.height.equalTo(@(1));
    }];
    [self.tf2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.width.equalTo(@(120));
        make.left.equalTo(self.separate.mas_right).offset(2);
        make.centerY.equalTo(self);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(@(30));
        make.width.equalTo(@(65));
    }];
}

-(UITextField*)tf1{
    if (!_tf1) {
        _tf1 = [UITextField new];
        _tf1.layer.masksToBounds = YES;
        _tf1.layer.cornerRadius = 5;
        _tf1.layer.borderColor = [UIColor moPlaceHolder].CGColor;
        _tf1.layer.borderWidth = 1;
        _tf1.leftViewMode = UITextFieldViewModeAlways;
        _tf1.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        _tf1.minimumFontSize = 9;
        _tf1.adjustsFontSizeToFitWidth = YES;
    }
    return _tf1;
}

-(UILabel*)separate{
    if (!_separate) {
        _separate= [UILabel new];
        _separate.backgroundColor = [UIColor moPlaceHolder];
    }
    return _separate;
}

-(UITextField*)tf2{
    if (!_tf2) {
        _tf2 = [UITextField new];
        _tf2.layer.masksToBounds = YES;
        _tf2.layer.cornerRadius = 5;
        _tf2.layer.borderColor = [UIColor moPlaceHolder].CGColor;
        _tf2.layer.borderWidth = 1;
        _tf2.leftViewMode = UITextFieldViewModeAlways;
        _tf2.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        _tf2.minimumFontSize = 9;
        _tf2.adjustsFontSizeToFitWidth = YES;
        
    }
    return _tf2;
}

-(UIButton*)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"搜索" forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor darkGreen];
        _btn.titleLabel.font = [UIFont font15];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 5;
        [_btn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(void)search:(id)sender{
    if (self.block) {
        self.block(@[self.tf1.text,self.tf2.text]);
    }
}
@end
