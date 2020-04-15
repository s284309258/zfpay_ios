//
//  MXMoMessageToolbar.m
//  MoPal_Developer
//
//  Created by yang.xiangbao on 15/6/17.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import "MXMoMessageToolbar.h"
#import "MJPhoto.h"
#import "MBProgressHUD+MJ.h"
#import "UIButton+ActionBlock.h"
#import "UIActionSheet+MKBlockAdditions.h"

@interface MXMoMessageToolbar ()

@property (nonatomic, strong) UIButton *saveImageBtn;

@end

@implementation MXMoMessageToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    // 保存图片按钮
    CGFloat btnWidth = 50;
    _saveImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveImageBtn.frame = CGRectMake(SCREEN_WIDTH - btnWidth - 10, 0, btnWidth, 30);
    [_saveImageBtn setTitle:MXLang(@"Public_save", @"保存") forState:UIControlStateNormal];
    _saveImageBtn.titleLabel.font = [UIFont font14];
    _saveImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //special by lhy 修改保存按钮样式  2015年11月12日
    _saveImageBtn.backgroundColor = [[UIColor moPlaceholderLight] colorWithAlphaComponent:0.5];
    [_saveImageBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveImageBtn];
}

- (void)saveImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MJPhoto *photo = self.photos[self.currentPhotoIndex];
        UIImageWriteToSavedPhotosAlbum(photo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showSuccess:MXLang(@"Talk_Save_Error", @"保存失败") toView:nil];
    } else {
        MJPhoto *photo = self.photos[self.currentPhotoIndex];
        photo.save = YES;
        _saveImageBtn.enabled = NO;
        [MBProgressHUD showSuccess:MXLang(@"Talk_Save_Photo_Success", @"成功保存到相册") toView:nil];
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    MJPhoto *photo = self.photos[_currentPhotoIndex];
    // 按钮
    _saveImageBtn.enabled = photo.image != nil && !photo.save;
}

@end


@implementation TBDeleteButton

// 重置图片的位置和大小
- (void)layoutSubviews
{
    [super layoutSubviews];
    UIImageView *imageView = [self imageView];
    CGRect imageFrame = imageView.frame;
    
    imageFrame.origin.x = self.frame.size.width - 22;
    imageFrame.size.width = 22;
    imageFrame.size.height = 22;
    imageFrame.origin.y = self.frame.size.height/2 - 22/2;
    imageView.frame = imageFrame;
    
    
}

@end


#define bottomBar_button_width 140

@interface MXMySelfCenterToolbar()

@property (nonatomic, strong) FBKVOController *kvoController;

@end



@implementation MXMySelfCenterToolbar

- (void)dealloc{
    [self.kvoController unobserve:self.photos];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.kvoController = [FBKVOController controllerWithObserver:self];
        
        [self.kvoController observe:self keyPath:@"photos" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            self.defaultAvatarButton.hidden = ([self.photos count] <= 1);
            self.deleteAvatarButton.hidden = ([self.photos count] <= 1);
        }];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    if (![self.changeAvatarButton superview]) {
        [self addSubview:self.changeAvatarButton];
    }
    if (![self.defaultAvatarButton superview]) {
        [self addSubview:self.defaultAvatarButton];
    }
    if (![self.deleteAvatarButton superview]) {
        [self addSubview:self.deleteAvatarButton];
    }

}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex{
    _currentPhotoIndex = currentPhotoIndex;
    self.defaultAvatarButton.hidden = currentPhotoIndex == 0;
}

- (UIButton *)changeAvatarButton {
    if (!_changeAvatarButton) {
        _changeAvatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (SCREEN_WIDTH <= 320.0f) {
            _changeAvatarButton.titleLabel.font=[UIFont font14];
        }else{
            _changeAvatarButton.titleLabel.font=[UIFont font14];
        }
        [_changeAvatarButton setTitle:MXLang(@"PersonalCenter_details_avtar_change_avatar_8", @"更换头像") forState:UIControlStateNormal];
        _changeAvatarButton.frame = CGRectMake(0,0,100,CGRectGetHeight(self.bounds));
    }
    return _changeAvatarButton;
}


- (UIButton *)defaultAvatarButton {
    if (!_defaultAvatarButton) {
        _defaultAvatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (SCREEN_WIDTH <= 320.0f) {
            _defaultAvatarButton.titleLabel.font=[UIFont font14];
        }else{
            _defaultAvatarButton.titleLabel.font=[UIFont font14];
        }
        [_defaultAvatarButton setTitle:MXLang(@"PersonalCenter_details_avtar_setdefault_7", @"设为当前头像") forState:UIControlStateNormal];
        _defaultAvatarButton.frame = CGRectMake(self.bounds.size.width/2 - bottomBar_button_width/2 + 10,
                                                0,
                                                bottomBar_button_width,
                                                CGRectGetHeight(self.bounds));
        
    }
    return _defaultAvatarButton;
}

- (UIButton *)deleteAvatarButton {
    if (!_deleteAvatarButton) {
        _deleteAvatarButton = [TBDeleteButton buttonWithType:UIButtonTypeCustom];
        
        _deleteAvatarButton.titleLabel.font=[UIFont font14];
        [_deleteAvatarButton setImage:[UIImage imageNamed:@"personalCenter_userdetails_avatar_delete"] forState:UIControlStateNormal];
        _deleteAvatarButton.frame = CGRectMake(self.bounds.size.width - (bottomBar_button_width/2)-6,
                                               0,
                                               bottomBar_button_width/2,
                                               CGRectGetHeight(self.bounds));
    }
    return _deleteAvatarButton;
}

@end

@interface MXGroupAvatarToolbar()


@end



@implementation MXGroupAvatarToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self addSubview:self.changeAvatarButton];
    
}

- (UIButton *)changeAvatarButton {
    if (!_changeAvatarButton) {
        _changeAvatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (SCREEN_WIDTH <= 320.0f) {
            _changeAvatarButton.titleLabel.font=[UIFont font14];
        }else{
            _changeAvatarButton.titleLabel.font=[UIFont font14];
        }
        [_changeAvatarButton setTitle:MXLang(@"PersonalCenter_details_avtar_change_avatar_8", @"更换头像") forState:UIControlStateNormal];
        _changeAvatarButton.frame = CGRectMake((SCREEN_WIDTH-100)/2,0,100,CGRectGetHeight(self.bounds));
    }
    return _changeAvatarButton;
}

@end

