//
//  PXAlertView+Customization.m
//  PXAlertViewDemo
//
//  Created by Michal Zygar on 21.10.2013.
//  Copyright (c) 2013 panaxiom. All rights reserved.
//

#import "PXAlertView+Customization.h"
#import <objc/runtime.h>

void * const kCanceledBGKey = (void * const) &kCanceledBGKey;
void * const kNonSelectedCancelBGKey = (void * const) &kNonSelectedCancelBGKey;
void * const kOtherBGroupKey = (void * const) &kOtherBGroupKey;
void * const kNonSelectedOtherBGKey = (void * const) &kNonSelectedOtherBGKey;
void * const kAllBGroupKey = (void * const) &kAllBGroupKey;
void * const kNonSelectedAllBGKey = (void * const) &kNonSelectedAllBGKey;

@interface PXAlertView ()

@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIView *alertView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) UIButton *otherButton;
@property (nonatomic) NSArray *buttons;
@property (nonatomic) UIScrollView *messageScrollView;

@end

@implementation PXAlertView (Customization)

- (void)useDefaultIOS7Style {
    [self setTapToDismissEnabled:NO];
    UIColor *ios7BlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    [self setAllButtonsTextColor:ios7BlueColor];
    [self setTitleColor:[UIColor blackColor]];
//    [self setMessageColor:[UIColor blackColor]];
    UIColor *defaultBackgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    [self setAllButtonsBackgroundColor:defaultBackgroundColor];
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)setCornerRadius:(CGFloat)radius
{
    self.alertView.layer.cornerRadius = radius;
}

- (void)setCenter:(CGPoint)center
{
	self.alertView.center = center;
}

- (void)setWindowTintColor:(UIColor *)color
{
    self.backgroundView.backgroundColor = color;
}

- (void)setBackgroundColor:(UIColor *)color
{
    self.alertView.backgroundColor = color;
}

- (void)setTitleColor:(UIColor *)color
{
    self.titleLabel.textColor = color;
}

- (void)setTitleFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

- (void)setMessageColor:(UIColor *)color
{
    self.messageLabel.textColor = color;
}

- (void)setMessageFont:(UIFont *)font
{
    self.messageLabel.font = font;
}

- (CGRect)adjustLabelFrameHeight:(UILabel *)label
{
    CGFloat height;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGSize size = [label.text sizeWithFont:label.font
                             constrainedToSize:CGSizeMake(label.frame.size.width, FLT_MAX)
                                 lineBreakMode:NSLineBreakByWordWrapping];
        
        height = size.height;
#pragma clang diagnostic pop
    } else {
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        context.minimumScaleFactor = 1.0;
        CGRect bounds = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, FLT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:label.font}
                                                 context:context];
        height = bounds.size.height;
    }
    
    return CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, height);
}

- (void)setCustomTitleLbl:(UILabel *)lbl
{
    [self.messageLabel removeFromSuperview];
    self.messageLabel = lbl;
//    self.messageLabel = [[UILabel alloc] initWithFrame:(CGRect){9, 0,
//        self.messageScrollView.frame.size}];
    lbl.frame = (CGRect){9, 0,
        self.messageScrollView.frame.size};
//    self.messageLabel.backgroundColor = [UIColor clearColor];
//    self.messageLabel.textColor = [UIColor whiteColor];
//    self.messageLabel.textAlignment = NSTextAlignmentLeft;
//    self.messageLabel.font = [UIFont systemFontOfSize:15];
//    self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    self.messageLabel.numberOfLines = 0;
    self.messageLabel.frame = [self adjustLabelFrameHeight:self.messageLabel];
    self.messageScrollView.contentSize = self.messageLabel.frame.size;
    [self.messageScrollView addSubview:lbl];
}

#pragma mark -
#pragma mark Buttons Customization
#pragma mark Buttons Background Colors
- (void)setCustomBackgroundColorForButton:(id)sender
{
    if (sender == self.cancelButton && [self cancelButtonBackgroundColor]) {
        self.cancelButton.backgroundColor = [self cancelButtonBackgroundColor];
    } else if (sender == self.otherButton && [self otherButtonBackgroundColor]) {
        self.otherButton.backgroundColor = [self otherButtonBackgroundColor];
    } else if ([self allButtonsBackgroundColor]) {
        [sender setBackgroundColor:[self allButtonsBackgroundColor]];
    } else {
        [sender setBackgroundColor:[UIColor colorWithRed:94/255.0 green:196/255.0 blue:221/255.0 alpha:1]];
    }
}

- (void)setNonSelectedCustomBackgroundColorForButton:(id)sender
{
    if (sender == self.cancelButton && [self nonSelectedCancelButtonBackgroundColor]) {
        self.cancelButton.backgroundColor = [self nonSelectedCancelButtonBackgroundColor];
    } else if (sender == self.otherButton && [self nonSelectedOtherButtonBackgroundColor]) {
        self.otherButton.backgroundColor = [self nonSelectedOtherButtonBackgroundColor];
    } else if ([self nonSelectedAllButtonsBackgroundColor]) {
        [sender setBackgroundColor:[self nonSelectedAllButtonsBackgroundColor]];
    } else {
        [sender setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)setCancelButtonBackgroundColor:(UIColor *)color
{
    objc_setAssociatedObject(self, kCanceledBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.cancelButton addTarget:self action:@selector(setCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
    [self.cancelButton addTarget:self action:@selector(setCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragEnter];
    [self.cancelButton addTarget:self action:@selector(setNonSelectedCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
}

- (UIColor *)cancelButtonBackgroundColor
{
    return objc_getAssociatedObject(self, kCanceledBGKey);
}

- (void)setCancelButtonNonSelectedBackgroundColor:(UIColor *)color
{
    objc_setAssociatedObject(self, kNonSelectedCancelBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.cancelButton.backgroundColor = color;
}

- (UIColor *)nonSelectedCancelButtonBackgroundColor
{
    return objc_getAssociatedObject(self, kNonSelectedCancelBGKey);
}

- (void)setAllButtonsBackgroundColor:(UIColor *)color
{
    objc_setAssociatedObject(self, kOtherBGroupKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kCanceledBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kAllBGroupKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (UIButton *button in self.buttons) {
        [button addTarget:self action:@selector(setCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(setCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragEnter];
        [button addTarget:self action:@selector(setNonSelectedCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
    }
}

- (UIColor *)allButtonsBackgroundColor
{
    return objc_getAssociatedObject(self, kAllBGroupKey);
}

- (void)setAllButtonsNonSelectedBackgroundColor:(UIColor *)color
{
    objc_setAssociatedObject(self, kNonSelectedOtherBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kNonSelectedCancelBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, kNonSelectedAllBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    for (UIButton *button in self.buttons) {
        button.backgroundColor = color;
    }
}

- (UIColor *)nonSelectedAllButtonsBackgroundColor
{
    return objc_getAssociatedObject(self, kNonSelectedAllBGKey);
}

- (void)setOtherButtonBackgroundColor:(UIColor *)color
{
    objc_setAssociatedObject(self, kOtherBGroupKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.otherButton addTarget:self action:@selector(setCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
    [self.otherButton addTarget:self action:@selector(setCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragEnter];
    [self.otherButton addTarget:self action:@selector(setNonSelectedCustomBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
}

- (UIColor *)otherButtonBackgroundColor
{
    return objc_getAssociatedObject(self, kOtherBGroupKey);
}

- (void)setOtherButtonNonSelectedBackgroundColor:(UIColor *)color
{
    objc_setAssociatedObject(self, kNonSelectedOtherBGKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.otherButton.backgroundColor = color;
}

- (UIColor *)nonSelectedOtherButtonBackgroundColor
{
    return objc_getAssociatedObject(self, kNonSelectedOtherBGKey);
}

#pragma mark Buttons Text Colors
- (void)setCancelButtonTextColor:(UIColor *)color
{
    [self.cancelButton setTitleColor:color forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:color forState:UIControlStateHighlighted];
}

- (void)setAllButtonsTextColor:(UIColor *)color
{
    for (UIButton *button in self.buttons) {
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateHighlighted];
    }
}

- (void)setOtherButtonTextColor:(UIColor *)color
{
    [self.otherButton setTitleColor:color forState:UIControlStateNormal];
    [self.otherButton setTitleColor:color forState:UIControlStateHighlighted];
}
@end
