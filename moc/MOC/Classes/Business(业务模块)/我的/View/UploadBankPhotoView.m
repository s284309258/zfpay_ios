//
//  UploadBankPhotoView.m
//  XZF
//
//  Created by mac on 2019/8/14.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "UploadBankPhotoView.h"
#import "PhotoBrowser.h"
#import "QNManager.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "DocumentManager.h"
#import "ImageUtil.h"
static NSInteger padding = 15;
@interface UploadBankPhotoView()


@property (nonatomic ,strong) UILabel* desc;

@property (nonatomic ,strong) UIViewController* vc;

@property (nonatomic ,strong) RealNameForm* model;

@end
@implementation UploadBankPhotoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        [self layout];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.title];
    [self addSubview:self.desc];
    [self addSubview:self.upPhoto];
    [self addSubview:self.downPhoto];
    [self addSubview:self.handPhoto];
}

-(void)layout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(padding);
    }];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self.title.mas_bottom).offset(10);
    }];
    [self.upPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(105));
        make.height.equalTo(@(70));
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self.desc.mas_bottom).offset(10);
    }];
    [self.downPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(105));
        make.height.equalTo(@(70));
        make.left.equalTo(self.upPhoto.mas_right).offset(15);
        make.top.equalTo(self.desc.mas_bottom).offset(10);
    }];
    [self.handPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(105));
        make.height.equalTo(@(70));
        make.left.equalTo(self.downPhoto.mas_right).offset(15);
        make.top.equalTo(self.desc.mas_bottom).offset(10);
    }];
}

-(UILabel*)title{
    if (!_title) {
        _title = [UILabel new];
        _title.text = @"上传银行卡正反面照";
        _title.font = [UIFont font15];
        _title.textColor = [UIColor moBlack];
    }
    return _title;
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [UILabel new];
        _desc.text = @"请保持图片清晰可见";
        _desc.font = [UIFont font12];
        _desc.textColor = [UIColor moPlaceHolder];
    }
    return _desc;
}

- (SPButton *)upPhoto{
    if (!_upPhoto) {
        _upPhoto = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _upPhoto.tag = 100;
        _upPhoto.frame = CGRectMake(0, 0, 120, 80);
        _upPhoto.imagePosition = SPButtonImagePositionTop;
        [_upPhoto setTitle:@"银行卡正面照" forState:UIControlStateNormal];
        [_upPhoto setTitleColor:[UIColor colorWithHexString:@"#CED1DB"] forState:UIControlStateNormal];
        _upPhoto.titleLabel.font = [UIFont font11];
        [_upPhoto setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
        _upPhoto.layer.masksToBounds = YES;
        _upPhoto.layer.cornerRadius = 3;
        _upPhoto.layer.borderColor = [UIColor colorWithHexString:@"#CED1DB"].CGColor;
        _upPhoto.layer.borderWidth = 0.5;
        [_upPhoto addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
        _upPhoto.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        
    }
    return _upPhoto;
}

- (SPButton *)downPhoto{
    if (!_downPhoto) {
        _downPhoto = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _downPhoto.tag = 101;
        _downPhoto.frame = CGRectMake(0, 0, 120, 80);
        _downPhoto.imagePosition = SPButtonImagePositionTop;
        [_downPhoto setTitle:@"银行卡反面照" forState:UIControlStateNormal];
        [_downPhoto setTitleColor:[UIColor colorWithHexString:@"#CED1DB"] forState:UIControlStateNormal];
        _downPhoto.titleLabel.font = [UIFont font11];
        [_downPhoto setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
        _downPhoto.layer.masksToBounds = YES;
        _downPhoto.layer.cornerRadius = 3;
        _downPhoto.layer.borderColor = [UIColor colorWithHexString:@"#CED1DB"].CGColor;
        _downPhoto.layer.borderWidth = 0.5;
        [_downPhoto addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
        _downPhoto.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    }
    return _downPhoto;
}

- (SPButton *)handPhoto{
    if (!_handPhoto) {
        _handPhoto = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _handPhoto.tag = 102;
        _handPhoto.frame = CGRectMake(0, 0, 120, 80);
        _handPhoto.imagePosition = SPButtonImagePositionTop;
        [_handPhoto setTitle:@"手持身份证照" forState:UIControlStateNormal];
        [_handPhoto setTitleColor:[UIColor colorWithHexString:@"#CED1DB"] forState:UIControlStateNormal];
        _handPhoto.titleLabel.font = [UIFont font11];
        [_handPhoto setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
        _handPhoto.layer.masksToBounds = YES;
        _handPhoto.layer.cornerRadius = 3;
        _handPhoto.layer.borderColor = [UIColor colorWithHexString:@"#CED1DB"].CGColor;
        _handPhoto.layer.borderWidth = 0.5;
        [_handPhoto addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
        _handPhoto.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    }
    return _handPhoto;
}

-(void)uploadPhoto:(id)sender{
    SPButton* btn = (SPButton*)sender;
    NSInteger tag = btn.tag-100;
    [[PhotoBrowser shared] showPhotoLibrary:self.vc completion:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nullable assets, BOOL isOriginal) {
        if([images isKindOfClass:[NSArray class]]) {
            if([[images firstObject] isKindOfClass:[UIImage class]]) {
                UIImage *image = [images firstObject];
                NSString* imagePath = [self.class saveChatImage:image];
                image = [UIImage imageWithContentsOfFile:imagePath];
                [NotifyHelper showHUDAddedTo:self animated:YES];
                [[QNManager shared] uploadImage:image completion:^(id data) {
                     [NotifyHelper hideAllHUDsForView:self animated:YES];
                    if(data && [NSURL URLWithString:data]) {
                        if (tag == 0) {
                            self.model.leftImg = data;
                        }else if(tag == 1){
                            self.model.centerImg = data;
                        }else if(tag == 2){
                            self.model.rightImg = data;
                        }
                      
                        NSString* imageUrl = [NSString stringWithFormat:@"%@/%@",[QNManager shared].qnHost,data];
                        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            if (image) {
                                
                               [btn setImage:nil forState:UIControlStateNormal];
                               [btn setTitle:@"" forState:UIControlStateNormal];
                            }else{
                                NSLog(@"图片错误");
                            }
                        }];
                       
                    }
                }];
            }
        }
    }];
    
}
+(NSString*)saveChatImage:(UIImage *)image{

    double timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString* dateString = [NSString stringWithFormat:@"%d%lu",(int)timeInterval, (unsigned long)image.hash];
    NSString *imagePath=[DocumentManager fileSavePath:dateString];
    NSData *tempData=[ImageUtil compressionImage:image length:300];
    //儲存
    [tempData writeToFile:imagePath atomically:NO];
    return imagePath;
}

-(void)configVC:(UIViewController*)vc model:(RealNameForm*)form{
    self.vc = vc;
    self.model = form;
}

@end

