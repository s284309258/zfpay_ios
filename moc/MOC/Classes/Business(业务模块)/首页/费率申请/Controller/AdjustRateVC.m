//
//  AdjustRateVC.m
//  XZF
//
//  Created by mac on 2019/8/10.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "AdjustRateVC.h"
#import "TextTextImgView.h"
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
#import "CreditCardRateSliderVC.h"
#import "NSObject+Home.h"
static NSInteger padding = 15;
@interface AdjustRateVC ()

@property (nonatomic ,strong) TextTextImgView* topView;

@property (nonatomic ,strong) UIView* backView;

@property (nonatomic ,strong) UIView* foreView;

@property (nonatomic ,strong) UILabel* tipLbl;

@property (nonatomic ,strong) MXSeparatorLine* line;

@property (nonatomic ,strong) UIButton* submitBtn;

@property (nonatomic ,strong) NSString* credit_card_rate;



@end

@implementation AdjustRateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self layout];
}

-(void)initUI{
    [self setNavBarTitle:@"调整费率"];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.topView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;//双击
    [self.topView addGestureRecognizer:tap];
    [self.backView addSubview:self.line];
    [self.backView addSubview:self.foreView];
    [self.foreView addSubview:self.tipLbl];
    [self.backView addSubview:self.submitBtn];
    
}

-(void)tapGesture:(UITapGestureRecognizer*)recognizer{
    CreditCardRateSliderVC* slider = [[CreditCardRateSliderVC alloc]init];
    slider.type = self.type;
    slider.subType = @"credit_card_rate";
    @weakify(self)
    slider.block = ^(id data) {
        @strongify(self)
        self.credit_card_rate = data;
        [self.topView reloadImg:@"选择" title:@"刷卡费率" desc:self.credit_card_rate];
    };
    [self.viewDeckController setRightViewController:slider];
    [self.viewDeckController openSide:IIViewDeckSideRight animated:YES];
}

-(void)layout{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(340));
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView);
        make.left.equalTo(self.backView).offset(padding);
        make.right.equalTo(self.backView).offset(-padding);
        make.height.equalTo(@(50));
     }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topView);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.equalTo(@(1));
    }];
    [self.foreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topView);
        make.top.equalTo(self.line.mas_bottom).offset(30);
        make.height.equalTo(@(100));
    }];
    [self.tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.foreView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44));
        make.left.right.equalTo(self.foreView);
        make.bottom.equalTo(self.backView).offset(-30);
    }];
}

-(UIView*)backView{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(TextTextImgView*)topView{
    if (!_topView) {
        _topView = [TextTextImgView new];
        [_topView reloadImg:@"选择" title:@"刷卡费率" desc:@"请选择刷卡费率"];
    }
    return _topView;
}

-(MXSeparatorLine*)line{
    if (!_line) {
        _line = [MXSeparatorLine initHorizontalLineWidth:0 orginX:0 orginY:0];
    }
    return _line;
}

-(UIView*)foreView{
    if (!_foreView) {
        _foreView = [UIView new];
        _foreView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    }
    return _foreView;
}

-(UILabel *)tipLbl{
    if (!_tipLbl) {
        _tipLbl = [UILabel new];
        _tipLbl.numberOfLines = 4;
        _tipLbl.font = [UIFont font12];
        _tipLbl.textColor = [UIColor moPlaceHolder];
        
        NSString* str = @"*温馨提示：\n申请费率调整须知;\n1.已激活机器 T(工作日)+1生效;\n2.未激活机器 工作日当天生效.";
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc]initWithString:str];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attr length])];
        [attr addColor:[UIColor moPlaceHolder] substring:str];
        [attr addFont:[UIFont systemFontOfSize:12] substring:str];
        _tipLbl.attributedText = attr;
    }
    return _tipLbl;
}

-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.backgroundColor = [UIColor darkGreen];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(void)submit:(id)sender{
    if ([self.type isEqualToString:@"MPOS"]) {
        [self addApplyRateMpos:@{@"sn_list":self.sn_list,@"credit_card_rate":self.credit_card_rate} completion:^(BOOL success, NSString *error) {
            if (success) {
                
            }
        }];
    }else{
        NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"sn_list":self.sn_list,@"credit_card_rate":self.credit_card_rate}];
        if ([self.type isEqualToString:@"EPOS"]) {
            [param setObject:@"epos" forKey:@"pos_type"];
        }
        [self addApplyRateTraditionalPos:param completion:^(BOOL success, NSString *error) {
            if (success) {
                
            }
        }];
    }
}
@end
