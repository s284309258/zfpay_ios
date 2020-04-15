//
//  HWBaseViewController.m
//  HWPanModal_Example
//
//  Created by heath wang on 2019/4/30.
//  Copyright © 2019 HeathWang. All rights reserved.
//

#import <HWPanModal/HWPanModal.h>
#import "HWBaseViewController.h"
#import <Masonry.h>
#import "UIView+Utils.h"
#import "PosOverlayView.h"
#import "ActivityOverlayView.h"
#import "BankOverlayView.h"
@interface HWBaseViewController () <HWPanModalPresentable>

@property (nonatomic , strong) ActivityOverlayView* activityView;

@property (nonatomic , strong) PosOverlayView* posView;

@property (nonatomic , strong) BankOverlayView* bankView;

@end

@implementation HWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self initUI];
    
    
}
-(void)initUI{
    if (self.type == ActivityOverlayType) {
        [self.view addSubview:self.activityView];
        [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.equalTo(@([self.activityView getHeight]));
        }];
    }else if(self.type == PosOverlayType) {
        [self.view addSubview:self.posView];
        [self.posView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.equalTo(@([self.posView getHeight]));
        }];
    }else if(self.type == BankOverlayType) {
        [self.view addSubview:self.bankView];
        [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.equalTo(@([self.posView getHeight]));
        }];
    }
    
}

-(ActivityOverlayView* )activityView{
    if (!_activityView) {
        _activityView = [[ActivityOverlayView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        [_activityView setBorderWithCornerRadius:10 byRoundingCorners:UIRectCornerTopLeft| UIRectCornerTopRight];
        _activityView.block = self.block;
    }
    return _activityView;
}

-(PosOverlayView* )posView{
    if (!_posView) {
        _posView = [[PosOverlayView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        _posView.block = self.block;
        [_posView setBorderWithCornerRadius:10 byRoundingCorners:UIRectCornerTopLeft| UIRectCornerTopRight];
    }
    return _posView;
}

-(BankOverlayView* )bankView{
    if (!_bankView) {
        _bankView = [[BankOverlayView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
        _bankView.block = self.block;
        [_bankView setBorderWithCornerRadius:10 byRoundingCorners:UIRectCornerTopLeft| UIRectCornerTopRight];
    }
    return _bankView;
}

#pragma mark - HWPanModalPresentable

- (PanModalHeight)shortFormHeight {
    if ([self isLandScape]) {
        return [self longFormHeight];
    }
    return PanModalHeightMake(PanModalHeightTypeMax, 200);
}
- (PanModalHeight)longFormHeight{
    return [self shortFormHeight];
}

// 当转屏且为横屏时，为全屏幕模式。
- (CGFloat)topOffset {
    if ([self isLandScape]) {
        return 0;
    } else {
        return 40;
    }
}

- (BOOL)shouldRespondToPanModalGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    return NO;
}


- (UIViewAnimationOptions)transitionAnimationOptions {
    return UIViewAnimationOptionCurveLinear;
}

- (BOOL)isLandScape {
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight ||
        [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
        return YES;
    }
    return NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (self.type == ActivityOverlayType) {
        CGPoint point = [[touches anyObject] locationInView:self.activityView];
        if (![self.activityView.layer containsPoint:point]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if(self.type == PosOverlayType) {
        CGPoint point = [[touches anyObject] locationInView:self.posView];
        if (![self.posView.layer containsPoint:point]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if(self.type == BankOverlayType) {
        CGPoint point = [[touches anyObject] locationInView:self.bankView];
        if (![self.bankView.layer containsPoint:point]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(void)configActivityModel:(NSArray*)activityArray{
    [self.activityView configActivityModel:activityArray];
}

-(void)configPosModel:(NSArray*)posArray{
    [self.posView configPosModel:posArray];
}
@end
