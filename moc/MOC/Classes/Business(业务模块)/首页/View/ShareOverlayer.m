//
//  ShareOverlayer.m
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "ShareOverlayer.h"
#import "UIView+AZGradient.h"
#import <SDCycleScrollView.h>
#import "UIImage+Utils.h"
#import "UIView+Snapshot.h"
static NSInteger padding = 15;
static NSInteger height = 80;
@interface ShareOverlayer()<SDCycleScrollViewDelegate>

@property (nonatomic , strong) CompletionBlock share;

@property (nonatomic , strong) CompletionBlock save;

@property (nonatomic , strong) UIButton *shareBtn;

@property (nonatomic , strong) UIButton *saveBtn;



@property (nonatomic , strong) SDCycleScrollView *img;

@property (nonatomic) int currentIndex;

@end

@implementation ShareOverlayer

-(instancetype)init{
    if (self = [super init]) {
        
        UIView* backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        [self addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self addSubview:self.img];
        [self addSubview:self.shareBtn];
        [self addSubview:self.saveBtn];
        [self.img addSubview:self.qrcodeLbl];
        [self.img addSubview:self.qrcodeImg];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(255));
            make.height.equalTo(@(454));
            make.bottom.equalTo(self.shareBtn.mas_top).offset(-20);
            make.centerX.equalTo(self);
        }];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.saveBtn.mas_top).offset(-25);
            make.width.equalTo(@(180));
            make.height.equalTo(@(40));
            make.centerX.equalTo(self);
        }];
        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-30-SafeAreaBottomHeight);
            make.width.equalTo(@(75));
            make.height.equalTo(@(30));
            make.centerX.equalTo(self);
        }];
        [self.qrcodeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.img).offset(-5);
            make.bottom.equalTo(self.img).offset(-5);
            make.width.equalTo(@(100));
            make.height.equalTo(@(36));
        }];
        [self.qrcodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(50));
            make.centerX.equalTo(self.qrcodeLbl);
            make.bottom.equalTo(self.qrcodeLbl.mas_top).offset(-5);
        }];
      
    }
    return self;
}
+(void)showOverLayer:(NSString*)qrcode_url share:(CompletionBlock)share save:(CompletionBlock)save imgArray:(NSMutableArray*)imgArray{
    ShareOverlayer *view=[ShareOverlayer new];
    view.share = share;
    view.save = save;
    view.img.imageURLStringsGroup = imgArray;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    NSString* tmp = qrcode_url;
    if ([StringUtil isEmpty:tmp]) {
        view.qrcodeImg.hidden = YES;
        view.qrcodeLbl.hidden = YES;
    }else{
        UIImage *qrCode = [UIImage encodeQRImageWithContent:tmp size:CGSizeMake(50, 50)];
        view.qrcodeImg.image = qrCode;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

-(void)btnClick:(id)sender{
//    [self removeFromSuperview];
//    UIButton* tmp = (UIButton*)sender;
//    if (self.block) {
//        self.block(@(tmp.tag - 100));
//    }
}

-(SDCycleScrollView*)img{
    if (!_img) {
        _img = [SDCycleScrollView new];
        _img = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 255, 454) delegate:self placeholderImage:nil];
        _img.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _img.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
            self.currentIndex = currentIndex;
        };
        _img.autoScroll = NO;
        _img.layer.masksToBounds = YES;
    }
    return _img;
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

-(UIButton*)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitleColor:[UIColor moGreen] forState:UIControlStateNormal];
        [_shareBtn setTitle:@"立即分享" forState:UIControlStateNormal];
        _shareBtn.layer.masksToBounds = YES;
        _shareBtn.layer.cornerRadius = 20;
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _shareBtn.backgroundColor = [UIColor whiteColor];
        [_shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

-(UIButton*)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _saveBtn.backgroundColor = [UIColor clearColor];
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.layer.cornerRadius = 15;
        _saveBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _saveBtn.layer.borderWidth = 1;
         [_saveBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

-(void)share:(id)sender{
    if (self.share) {
        self.share(@(self.currentIndex));
    }
}

-(void)save:(id)sender{
    if (self.save) {
        self.save(self.img.snapshotImage);
    }
}

-(UILabel*)qrcodeLbl{
    if (!_qrcodeLbl) {
        _qrcodeLbl = [UILabel new];
        _qrcodeLbl.numberOfLines = 2;
        _qrcodeLbl.text = [NSString stringWithFormat:@"/推荐码/\n%@",AppUserModel.user_tel];

        _qrcodeLbl.font = [UIFont font12];
        _qrcodeLbl.textAlignment = NSTextAlignmentCenter;
        _qrcodeLbl.textColor = [UIColor whiteColor];
        _qrcodeLbl.backgroundColor = [UIColor lightGrayColor];
        _qrcodeLbl.layer.cornerRadius = 18;
        _qrcodeLbl.layer.masksToBounds = YES;
    }
    return _qrcodeLbl;
}

-(UIImageView*)qrcodeImg{
    if (!_qrcodeImg) {
        _qrcodeImg = [UIImageView new];
        _qrcodeImg.backgroundColor = [UIColor moPlaceHolder];
     
    }
    return _qrcodeImg;
}
@end
