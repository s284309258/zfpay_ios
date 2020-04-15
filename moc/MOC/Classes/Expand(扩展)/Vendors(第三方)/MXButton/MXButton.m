//
//  MXButton.m
//  Moxian
//  此按钮为本app所有的公共类,特别说明：
//  1.所有按钮的图片尺寸大小基本上为44 x 44
//  2.默认给按钮的大小是22 x 22
//  3.可以根据MXImagePositionStyle枚举来控制按钮图标的位置

//  Created by litiankun on 14-5-9.
//  Copyright (c) 2014年 Moxian. All rights reserved.
//

#import "MXButton.h"
#import "ImageUtil.h"

@implementation MXButton

@synthesize isHaveCircle;
@synthesize defaultPurple;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 默认大小
        self.contentSize = CGSizeMake(22, 22);
        self.imageOffset = CGPointMake(0, 0);
        
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor moPurple]  forState:UIControlStateHighlighted];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        // 默认大小
        self.contentSize = CGSizeMake(22, 22);
        self.imageOffset = CGPointMake(0, 0);
        
//        if (isHaveCircle) {
//            // fkq A 20140705 添加边框线
//            self.layer.borderColor = [UIColor grayColor].CGColor;
//            self.layer.borderWidth = 0.5f;
//            self.layer.cornerRadius = 5.0f;
//        }

    }
    return self;
}

// 重置ICON的位置和大小
/**
 */
- (void)layoutSubviews
{
    [super layoutSubviews];

    UIImageView *imageView = [self imageView];
    CGRect imageFrame = imageView.frame;
    imageFrame.size.width = self.contentSize.width;
    imageFrame.size.height = self.contentSize.height;
    switch (self.imagePositionStyle) {
        case MX_IMAGE_POSITION_LEFT: {
            imageFrame.origin.x =0;
            imageFrame.origin.y = self.frame.size.height/2 - self.contentSize.height/2;
             break;
        }
           
        case MX_IMAGE_POSITION_CENTER: {
            imageFrame.origin.x =self.frame.size.width/2 - imageFrame.size.width/2;
            imageFrame.origin.y = self.frame.size.height/2 - self.contentSize.height/2;
            break;
        }
            
        case MX_IMAGE_POSITION_RIGHT: {
            imageFrame.origin.x = CGRectGetWidth(self.frame) - imageFrame.size.width;
            imageFrame.origin.y = self.frame.size.height/2 - self.contentSize.height/2;
            
            break;
        }
        case MX_IMAGE_POSITION_CUSTOM: {
            imageFrame.origin.x = self.imageOffset.x;
            imageFrame.origin.y = self.imageOffset.y;
            break;
        }
        case MX_IMAGE_POSITION_VERTICAL_CENTER: {
            imageFrame.origin.y = self.frame.size.height/2 - self.contentSize.height/2;
            
            break;
        }
        default:
            imageFrame.origin.x =self.frame.size.width/2 - imageFrame.size.width/2;
            imageFrame.origin.y = self.frame.size.height/2 - self.contentSize.height/2;
            break;
    }
    imageView.frame = imageFrame;
    
    // 标题
    UILabel *titleLabel = [self titleLabel];
    CGRect titleFrame = titleLabel.frame;
    titleFrame.origin.x = self.frame.size.width/2.0 - titleFrame.size.width/2.0;
    titleLabel.frame = titleFrame;
    
}

// 根据按钮状态来加载小图
+ (UIImage*)backgroundImageOfSmallImage:(UIControlState) controlState withCGSize:(CGSize) size {
    
    UIImage *image=nil;
    
    switch (controlState) {
        case UIControlStateNormal:
            image = [ImageUtil imagewithStretch:@"common_small_button_background_normal" withSize:size];
            break;
        case UIControlStateHighlighted:
            image = [ImageUtil imagewithStretch:@"common_small_button_background_normal" withSize:size];
            break;
        case UIControlStateSelected:
            image = [ImageUtil imagewithStretch:@"common_small_button_background_normal" withSize:size];
            break;
        default:
            break;
    }
    return image;
}

// 根据按钮状态来加载中图
+ (UIImage*)backgroundImageOfMiddleImage:(UIControlState) controlState withCGSize:(CGSize) size {
    
    UIImage *image=nil;
    
    switch (controlState) {
        case UIControlStateNormal:
            image = [ImageUtil imagewithStretch:@"common_middle_button_background_normal" withSize:size];
            break;
        case UIControlStateHighlighted:
            image = [ImageUtil imagewithStretch:@"common_middle_button_background_hl" withSize:size];
            break;
        case UIControlStateSelected:
            image = [ImageUtil imagewithStretch:@"common_middle_button_background_hl" withSize:size];
            break;
        default:
            break;
    }
    return image;

}

// 根据按钮状态来加载大图
+ (UIImage*)backgroundImageOfLargeImage:(UIControlState) controlState withCGSize:(CGSize) size {
    
    UIImage *image=nil;
    
    switch (controlState) {
        case UIControlStateNormal:
            image = [ImageUtil imagewithStretch:@"common_big_button_background_normal" withSize:size];
            break;
        case UIControlStateHighlighted:
            image = [ImageUtil imagewithStretch:@"common_big_button_background_hl" withSize:size];
            break;
        case UIControlStateSelected:
            image = [ImageUtil imagewithStretch:@"common_big_button_background_hl" withSize:size];
            break;
        default:
            break;
    }
    return image;

}


// 根据枚举来加载按钮图片背景
- (void)loadBackgroundImageWithStyle:(MXButtonBackgroundImageStyle) backgroundImageStyle {

    switch (backgroundImageStyle) {
        case MX_BACKGROUND_IMAGE_SMALL: {
            [self setBackgroundImage:[MXButton backgroundImageOfSmallImage:UIControlStateNormal withCGSize:self.frame.size] forState:UIControlStateNormal];
            [self setBackgroundImage:[MXButton backgroundImageOfSmallImage:UIControlStateHighlighted withCGSize:self.frame.size] forState:UIControlStateHighlighted];
            [self setBackgroundImage:[MXButton backgroundImageOfSmallImage:UIControlStateSelected withCGSize:self.frame.size] forState:UIControlStateSelected];
        }
            
            break;
        case MX_BACKGROUND_IMAGE_MIDDLE: {
            [self setBackgroundImage:[MXButton backgroundImageOfMiddleImage:UIControlStateNormal withCGSize:self.frame.size] forState:UIControlStateNormal];
            [self setBackgroundImage:[MXButton backgroundImageOfMiddleImage:UIControlStateHighlighted withCGSize:self.frame.size] forState:UIControlStateHighlighted];
            [self setBackgroundImage:[MXButton backgroundImageOfMiddleImage:UIControlStateSelected withCGSize:self.frame.size] forState:UIControlStateSelected];
        }
            
            break;
        case MX_BACKGROUND_IMAGE_LARGE: {
            [self setBackgroundImage:[MXButton backgroundImageOfLargeImage:UIControlStateNormal withCGSize:self.frame.size] forState:UIControlStateNormal];
            [self setBackgroundImage:[MXButton backgroundImageOfLargeImage:UIControlStateHighlighted withCGSize:self.frame.size] forState:UIControlStateHighlighted];
            [self setBackgroundImage:[MXButton backgroundImageOfLargeImage:UIControlStateSelected withCGSize:self.frame.size] forState:UIControlStateSelected];
        }
            
            break;
        default:
            break;
    }
}



//
- (void)drawCircle{
    isHaveCircle = YES;
    self.currentBorderStyle=MXButtonBorderStyleGray;
    if (isHaveCircle) {
        // fkq A 20140705 添加边框线
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5f;
        //self.layer.cornerRadius = 5.0f;
    }
}

- (void)setDefaultPurple {
    defaultPurple=YES;
    self.currentBorderStyle=MXButtonBorderStylePurple;
    if (defaultPurple) {

        self.layer.borderColor = [UIColor moPurple].CGColor;
        self.layer.borderWidth = 0.5f;
    }
}

//完成一个点击事件时触发的方法,来自继承类UIControl
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.currentBorderStyle == MXButtonBorderStyleGray) {
        if (!isHaveCircle) {
            return;
        }
        
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5f;
    }else if (self.currentBorderStyle==MXButtonBorderStylePurple) {
        
        if (!defaultPurple) {
            return;
        }
        
        self.layer.borderColor = [UIColor moPurple].CGColor;
        self.layer.borderWidth = 0.5f;
    }

}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
 
    if (self.currentBorderStyle == MXButtonBorderStyleGray) {
        
        if (!isHaveCircle) {
            return true;
        }
        self.layer.borderColor = [UIColor moPurple].CGColor;
        self.layer.borderWidth = 1.0f;
    }else if (self.currentBorderStyle==MXButtonBorderStylePurple) {
        
        if (!defaultPurple) {
            return true;
        }
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    

    return true;
}


- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if (self.currentBorderStyle == MXButtonBorderStyleGray) {
        if (!isHaveCircle) {
            return true;
        }
        
        if (self.state == UIControlStateHighlighted) {
            self.layer.borderColor = [UIColor moPurple].CGColor;
            self.layer.borderWidth = 1.0f;
            
        }else{
            self.layer.borderColor = [UIColor grayColor].CGColor;
            self.layer.borderWidth = 0.5f;
            
        }
        
    }else if (self.currentBorderStyle==MXButtonBorderStylePurple) {
        if (!defaultPurple) {
            return true;
        }
        
        if (self.state == UIControlStateHighlighted) {
            self.layer.borderColor = [UIColor grayColor].CGColor ;
            self.layer.borderWidth = 1.0f;
            
        }else{
            self.layer.borderColor = [UIColor moPurple].CGColor;
            self.layer.borderWidth = 0.5f;
            
        }
    }
    
    
    
    return true;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event{
    
    if (!isHaveCircle) {
        return;
    }
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}


@end
