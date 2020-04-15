//
//  ImgCaptchaView.h
//  ScanPay
//
//  Created by mac on 2019/7/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImgCaptchaView : UIView


@property (nonatomic, strong) UITextField     *tf;

@property (nonatomic , strong) CompletionBlock getText;

@property (nonatomic , strong) CompletionBlock picBlock;
//标题
-(void)reloadTitle:(NSString *) title placeHolder:(NSString *)placeHolder;
//图片
-(void)reloadImg:(NSString *) img placeHolder:(NSString *)placeHolder;

-(void)reloadplaceHolder:(NSString *)placeHolder;

-(void)reloadRightImg:(UIImage *)image;

-(void)reloadRightImgUrl:(NSString *)image;

-(void)setLeftPadding:(NSInteger)padding;

//-(void)showBorder;

-(void)showDownLine:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
