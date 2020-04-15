//
//  SuggestVC.m
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "SuggestVC.h"
#import "PersonalCenterHelper.h"
#import "UIView+WebCache.h"

@interface SuggestVC ()
@property (weak, nonatomic) IBOutlet UIImageView *whiteBG;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImgView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;
@end

@implementation SuggestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor moBackground];
    [self setNavBarTitle:Lang(@"投诉建议")];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(30));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
    }];
    
    [self.qrCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLbl.mas_bottom).offset(27);
        make.left.equalTo(@(60));
        make.right.equalTo(@(-60));
        make.height.equalTo(@(SCREEN_WIDTH-120));
    }];
    
    [self.subTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrCodeImgView.mas_bottom).offset(27);
        make.left.equalTo(@(0));
        make.right.equalTo(@(-0));
    }];
    
    [self.view insertSubview:self.whiteBG atIndex:0];
    
    [self.whiteBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(self.subTitleLbl.mas_bottom).offset(33);
    }];
    
    [self getData];
}

- (void)getData {
//    [self.qrCodeImgView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [self.qrCodeImgView sd_addActivityIndicator];
//    [PersonalCenterHelper feedback:self.view completion:^(BOOL success, id object, NSString *error) {
//        [self.qrCodeImgView sd_removeActivityIndicator];
//        NSString *url = [object valueForKey:@"picPath"];
//        if(url) {
//            [self.qrCodeImgView sd_setImageWithURL:[NSURL URLWithString:url]];
//        }
//    }];
}


@end
