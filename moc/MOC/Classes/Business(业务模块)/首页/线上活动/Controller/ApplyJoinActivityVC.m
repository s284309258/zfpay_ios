//
//  ApplyJoinActivityVC.m
//  XZF
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ApplyJoinActivityVC.h"
#import "RFHeader.h"
#import "CipherView.h"
#import "HWBaseViewController.h"
#import <HWPanModal/HWPanModal.h>
#import "NSObject+Home.h"
#import "PosActivityRewardModel.h"
static NSInteger padding = 15;
@interface ApplyJoinActivityVC ()

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) RFHeader *level;

@property (nonatomic,strong) RFHeader *sn;

@property (nonatomic,strong) CipherView *levelOption;

@property (nonatomic,strong) CipherView *snOption;

@property (nonatomic,strong) UIButton *submitBtn;

@property (nonatomic,strong)  HWBaseViewController *overlayVC;

@property (nonatomic,strong)  NSMutableArray *activityList;

@property (nonatomic,strong)  NSMutableArray *posList;

@property (nonatomic,strong)  PosActivityRewardModel *selectPosActivity;

@property (nonatomic,strong)  NSMutableArray *selectPosList;

@end

@implementation ApplyJoinActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self layout];
}

-(void)initUI{
    [self setNavBarTitle:@"参与活动"];
    self.activityList = [[NSMutableArray alloc]initWithCapacity:10];
    self.posList = [[NSMutableArray alloc]initWithCapacity:10];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.level];
    [self.backView addSubview:self.levelOption];
    [self.backView addSubview:self.sn];
    [self.backView addSubview:self.snOption];
    [self.backView addSubview:self.submitBtn];
}

-(void)layout{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(360));
    }];
    [self.level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(padding);
        make.right.equalTo(self.backView).offset(-padding);
        make.top.equalTo(self.backView).offset(padding);
        make.height.equalTo(@(30));
    }];
    [self.levelOption mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.level);
        make.top.equalTo(self.level.mas_bottom);
        make.height.equalTo(@(50));
    }];
    [self.sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.level);
        make.top.equalTo(self.levelOption.mas_bottom).offset(20);
        make.height.equalTo(@(30));
    }];
    [self.snOption mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.level);
        make.top.equalTo(self.sn.mas_bottom);
        make.height.equalTo(@(50));
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView).offset(-44);
        make.left.right.equalTo(self.levelOption);
        make.height.equalTo(@(44));
    }];
}


-(RFHeader*)level{
    if (!_level) {
        _level = [[RFHeader alloc]init];
        [_level reloadColor:@"#5B79E6" left:@"活动等级" right:@""];
    }
    return _level;
}

-(RFHeader*)sn{
    if (!_sn) {
        _sn = [[RFHeader alloc]init];
        [_sn reloadColor:@"#5B79E6" left:@"POS机SN码" right:@""];
    }
    return _sn;
}

-(CipherView*)levelOption{
    if (!_levelOption) {
        _levelOption = [[CipherView alloc]initWithFrame:CGRectZero];
        _levelOption.tf.secureTextEntry = NO;
        _levelOption.tf.enabled = NO;
        [_levelOption reloadPlaceHolder:@"请选择活动等级"];
        [_levelOption isHiddenLine:NO];
        [_levelOption.btn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
        [_levelOption.btn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateSelected];
        @weakify(self)
        _levelOption.rowClick  = ^(id data) {
            @strongify(self)
            self.overlayVC = [[HWBaseViewController alloc]init];
            self.overlayVC.type = ActivityOverlayType;
            self.overlayVC.block = ^(id data) {
                self.selectPosActivity = data;
                NSString* title = [NSString stringWithFormat:@"库存数量:%@台",self.selectPosActivity.pos_num];
                [_levelOption reloadPlaceHolder:title];
                [self.overlayVC dismissViewControllerAnimated:YES completion:nil];
            };
            [self presentPanModal:self.overlayVC];
            [self loadData:^(id data) {
                 [self.overlayVC configActivityModel:self.activityList];
            }];
            
        };
    }
    return _levelOption;
}

-(CipherView*)snOption{
    if (!_snOption) {
        _snOption = [[CipherView alloc]initWithFrame:CGRectZero];
        _snOption.tf.secureTextEntry = NO;
        _snOption.tf.enabled = NO;
        [_snOption reloadPlaceHolder:@"请选择参与活动的POS机SN码"];
        [_snOption isHiddenLine:NO];
        [_snOption.btn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
        [_snOption.btn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateSelected];
        @weakify(self)
        _snOption.rowClick = ^(id data) {
            @strongify(self)
            self.overlayVC = [[HWBaseViewController alloc]init];
            self.overlayVC.type = PosOverlayType;
            self.overlayVC.block = ^(id data) {
                self.selectPosList = data;
                [self.snOption reloadPlaceHolder:[self getPosStr:self.selectPosList]];
                [self.overlayVC dismissViewControllerAnimated:YES completion:nil];
            };
            [self presentPanModal:self.overlayVC];
            [self loadData:^(id data) {
                [self.overlayVC configPosModel:self.posList];
            }];
        };
    }
    return _snOption;
}

-(NSString*)getPosStr:(NSArray*)array{
    NSArray *unionOfObjects = [array valueForKeyPath:@"@unionOfObjects.sn"];
    return [unionOfObjects componentsJoinedByString:@","];
}

-(void)loadData:(CompletionBlock)block{
    if ([self.activity.type isEqualToString:@"0"]) {
        [self getTraditionalPosPartActivityInfo:@{@"activity_id":self.activity.activity_id} completion:^(id array, NSString *error) {
            if (array) {
                NSArray* tmpArray = array;
                self.posList = tmpArray[0];
                self.activityList = tmpArray[1];
                if (block) {
                    block(nil);
                }
            }
        }];

    }else if([self.activity.type isEqualToString:@"1"]) {
        [self getMposPartActivityInfo:@{@"activity_id":self.activity.activity_id} completion:^(id array, NSString *error) {
            if (array) {
                if (array) {
                    NSArray* tmpArray = array;
                    self.posList = tmpArray[0];
                    self.activityList = tmpArray[1];
                    [self.overlayVC configActivityModel:self.activityList];
                    if (block) {
                        block(nil);
                    }
                }
            }
        }];

    }else if ([self.activity.type isEqualToString:@"2"]) {
        [self getTraditionalPosPartActivityInfo:@{@"activity_id":self.activity.activity_id,@"pos_type":@"epos"} completion:^(id array, NSString *error) {
           if (array) {
               NSArray* tmpArray = array;
               self.posList = tmpArray[0];
               self.activityList = tmpArray[1];
               [self.overlayVC configActivityModel:self.activityList];
               if (block) {
                   block(nil);
               }
           }
       }];
   }
}

-(UIView*)backView{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundColor:[UIColor darkGreen]];
        [_submitBtn setTitle:@"申请参与" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        [_submitBtn addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(void)apply:(id)sender{
    if ([self.activity.type isEqualToString:@"0"]) {
        [self submitTraditionalPosActivityApply:@{@"activity_reward_id":self.selectPosActivity.activity_reward_id,@"sn_list":[self getPosStr:self.selectPosList]} completion:^(BOOL success, NSString *error) {
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else if([self.activity.type isEqualToString:@"1"]){
        [self submitMposActivityApply:@{@"activity_reward_id":self.selectPosActivity.activity_reward_id,@"sn_list":[self getPosStr:self.selectPosList]} completion:^(BOOL success, NSString *error) {
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else if ([self.activity.type isEqualToString:@"2"]) {
        [self submitTraditionalPosActivityApply:@{@"pos_type":@"epos",@"activity_reward_id":self.selectPosActivity.activity_reward_id,@"sn_list":[self getPosStr:self.selectPosList]} completion:^(BOOL success, NSString *error) {
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
   
}
@end
