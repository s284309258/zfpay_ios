//
//  ActivityVC.m
//  XZF
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ActivityVC.h"
#import "NSObject+Home.h"
#import "PosOnlineActivityModel.h"
#import "QNManager.h"
@interface ActivityVC ()

@property (strong, nonatomic) UIButton *submitBtn;

@property (strong, nonatomic) UIImageView *backImg;

@property (strong, nonatomic) PosOnlineActivityModel *model;

@end

@implementation ActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    
}

-(void)initUI{
    [self setNavBarTitle:@"活动详情"];
    [self.view addSubview:self.backImg];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44));
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight-20);
    }];
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)initData{
    if ([self.type isEqualToString:@"0"]) {
        [self getTraditionalPosOnlineActivityDetail:@{@"activity_id":self.activity_id} completion:^(id object, NSString *error) {
            if (object) {
                self.model = object;
                self.model.type = @"0";
                NSString* url = [NSString stringWithFormat:@"%@/%@", [QNManager shared].qnHost,self.model.detail_url];
                [self.backImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            }
        }];
    }else if([self.type isEqualToString:@"1"]){
        [self getMposOnlineActivityDetail:@{@"activity_id":self.activity_id} completion:^(id object, NSString *error) {
            if (object) {
                self.model = object;
                self.model.type = @"1";
                NSString* url = [NSString stringWithFormat:@"%@/%@", [QNManager shared].qnHost,self.model.detail_url];
                [self.backImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            }
        }];
    }else if([self.type isEqualToString:@"2"]){
        [self getTraditionalPosOnlineActivityDetail:@{@"activity_id":self.activity_id,@"pos_type":@"epos"} completion:^(id object, NSString *error) {
            if (object) {
                self.model = object;
                self.model.type = @"2";
                NSString* url = [NSString stringWithFormat:@"%@/%@", [QNManager shared].qnHost,self.model.detail_url];
                [self.backImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            }
        }];
    }
}

-(UIImageView*)backImg{
    if (!_backImg) {
        _backImg = [UIImageView new];
    }
    return _backImg;
}

-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"我要参与" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
         [_submitBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"#FB4425"],[UIColor colorWithHexString:@"#FFA800"]] locations:nil startPoint:CGPointMake(0, 1) endPoint:CGPointMake(0, 0)];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(join:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submitBtn;
}

-(void)join:(id)sender{
    if (self.model) {
        [MXRouter openURL:@"lcwl://ApplyJoinActivityVC" parameters:@{@"activity":self.model}];
    }
}
@end
