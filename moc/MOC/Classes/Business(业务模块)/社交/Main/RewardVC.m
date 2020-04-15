//
//  RewardVC.m
//  Lcwl
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "RewardVC.h"
#import "SCRequestHelper.h"
#import "XWMoneyTextField.h"
#import "XWMoneyTextFieldLimit.h"
#import "YQPayKeyWordVC.h"

@interface RewardVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet XWMoneyTextField *txtFiled;
@property (weak, nonatomic) IBOutlet UILabel *starLbl;
@property (weak, nonatomic) IBOutlet UILabel *unitLbl;
@property (weak, nonatomic) IBOutlet UILabel *starsCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *rewardButton;

@end

@implementation RewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"打赏";
    self.txtFiled.limit.max = @"999.9999";
    self.txtFiled.delegate = self.txtFiled.limit;
    
    self.starLbl.layer.cornerRadius = 6;
    self.starLbl.clipsToBounds = YES;
    
    self.rewardButton.layer.cornerRadius = 6;
    self.rewardButton.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(textFiledEditChanged:)
     name:UITextFieldTextDidChangeNotification
     object:self.txtFiled];
    
    //self.txtFiled.textColor = [UIColor moDarkGray];
//    self.txtFiled.layer.borderWidth = 0;
//    self.txtFiled.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(@(30));
    }];
    
    [self.starLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
        make.top.equalTo(self.titleLbl.mas_bottom).offset(15);
        make.height.equalTo(@(50));
    }];
    
    [self.unitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.starLbl.mas_right).offset(-10);
        make.centerY.equalTo(self.starLbl);
    }];
    
    [self.txtFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starLbl.mas_left).offset(60);
        make.right.equalTo(self.unitLbl.mas_left).offset(-10);
        make.top.bottom.equalTo(self.starLbl);
    }];
    
    [self.starsCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
        make.top.equalTo(self.starLbl.mas_bottom).offset(25);
    }];
    
    [self.rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
        make.top.equalTo(self.starsCountLbl.mas_bottom).offset(25);
        make.height.equalTo(@(50));
    }];
}

- (IBAction)rewardBntClick:(UIButton *)sender {
    if(self.txtFiled.text.length > 0 && self.circleId.length > 0 && [self.txtFiled.text doubleValue] > 0) {
        @weakify(self)
        [[YQPayKeyWordVC alloc] showInViewController:self tiltle:@"请输入支付密码" subtitle:$str(@"%@星星",self.txtFiled.text) block:^(NSString * password) {
            @strongify(self)
            [SCRequestHelper circleReward:@{@"circle_id":self.circleId,@"num": self.txtFiled.text,@"pay_password":password,@"circle_user_id":self.circleUserId} completion:^(id data) {
                if([data valueForKey:@"success"]) {
                    Block_Exec(self.block,nil);
                    [NotifyHelper showMessageWithMakeText:@"打赏成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }];
    }
}

- (void)textFiledEditChanged:(NSNotification *)sender
{
    self.starsCountLbl.text = self.txtFiled.text;
}
@end
