//
//  TextChangeVC.m
//  Lcwl
//
//  Created by AlphaGO on 2018/11/21.
//  Copyright © 2018年 lichangwanglai. All rights reserved.
//

#import "TextChangeVC.h"
#import "PersonalCenterHelper.h"
#import "UIView+Utils.h"
#import "UIView+AZGradient.h"

@interface TextChangeVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *tipInfoLbl;
@property (weak, nonatomic) IBOutlet UIButton *saveBnt;

@property ( nonatomic) NSUInteger end;

@property ( nonatomic) NSUInteger begin;
@end

@implementation TextChangeVC
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.end = 100;
    self.begin = 0;
    //[self setNavBarRightBtnWithTitle:@"保存" andImageName:nil];
    [self setNavBarTitle:Lang(@"修改昵称")];
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.saveBnt setTitle:Lang(@"保存") forState:UIControlStateNormal];
    self.saveBnt.backgroundColor = [UIColor darkGreen];
//     [self.saveBnt az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"#4C6EFF"],[UIColor colorWithHexString:@"#5B8FFA"]] locations:nil startPoint:CGPointMake(0, 1) endPoint:CGPointMake(0, 0)];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    leftView.backgroundColor = [UIColor whiteColor];
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.placeholder = self.placeholder;
    self.tipInfoLbl.text = self.tipInfo;
    self.textField.text = self.text ?: @"";
    self.textField.delegate = self;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(65));
    }];
    
    [self.saveBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.textField.mas_bottom).offset(100);
        make.height.equalTo(@(44));
    }];
    
//    [self.tipInfoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(10);
//        make.right.equalTo(self.view).offset(-10);
//        make.top.equalTo(self.textField.mas_bottom).offset(5);
//    }];
//
//    [self.tipInfoLbl becomeFirstResponder];
//    if ([self.title isEqualToString:@"设置名字"]) {
//        self.end = 12;
//    }else if([self.title isEqualToString:@"设置礼常往来号"]){
//        self.begin = 6;
//        self.end = 20;
//    }
    
}


- (BOOL)isValidateName:(NSString *)name{
//    NSUInteger  character = 0;
//    for(int i=0; i< [name length];i++){
//        int a = [name characterAtIndex:i];
//        if( a >= 0x4e00 && a <= 0x9fa5){ //判断是否为中文
//            character +=2;
//        }else{
//            character +=1;
//        }
//    }
//
//    if (character >= self.begin && character <= self.end) {
//        return YES;
//    }else{
//        return NO;
//    }
    return YES;
}

- (IBAction)saveBntClick:(id)sender {
    if([StringUtil isEmpty:self.textField.text]) {
        return;
    }
    
    if(![StringUtil isEmpty:self.textField.text]) {
        [PersonalCenterHelper userInfoModify:@{@"username":self.textField.text} completion:^(BOOL success, id object, NSString *error) {
            
            if(success) {
//                AppUserModel.username = self.textField.text;
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}
@end
