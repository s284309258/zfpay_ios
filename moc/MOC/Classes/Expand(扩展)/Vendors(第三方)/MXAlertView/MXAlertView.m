//
//  MXAlertView.m
//  MXAlertViewDemo
//
//  Created by Alex Jarvis on 25/09/2013.
//  Copyright (c) 2013 Panaxiom Ltd. All rights reserved.
//

#import "MXAlertView.h"
#import "StringUtil.h"
#import "MXButton.h"
#import "UIAlertView+Blocks.h"


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MX_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MX_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

@interface MXAlertViewStack : NSObject

@property (nonatomic) NSMutableArray *alertViews;

+ (MXAlertViewStack *)sharedInstance;

- (void)push:(MXAlertView *)alertView;
- (void)pop:(MXAlertView *)alertView;

@end

static const CGFloat AlertViewWidth = 260.0;
static const CGFloat AlertViewContentMargin = 20;
static const CGFloat AlertViewVerticalElementSpace = 15;
static const CGFloat AlertViewButtonHeight = 30;
static const CGFloat AlertViewOneButtonWidth = 145;
static const CGFloat AlertViewTwoButtonWidth = 105;

@interface MXAlertView ()

@property (nonatomic) UIView *line;
@property (nonatomic) UIWindow *mainWindow;
@property (nonatomic) UIWindow *alertWindow;
@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIView *alertView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) MXButton *cancelButton;
@property (nonatomic) MXButton *otherButton;
@property (nonatomic) NSArray *buttons;
@property (nonatomic) CGFloat buttonsY;
@property (nonatomic) CALayer *verticalLine;
@property (nonatomic) UITapGestureRecognizer *tap;
@property (nonatomic, copy) void (^completion)(BOOL cancelled, NSInteger buttonIndex);
@property (nonatomic, assign) CGFloat buttonWidth ;
@end

@implementation MXAlertView

- (void)dealloc
{
    
}

- (UIWindow *)windowWithLevel:(UIWindowLevel)windowLevel
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.windowLevel == windowLevel) {
            return window;
        }
    }
    return nil;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
         otherTitle:(NSString *)otherTitle
        contentView:(UIView *)contentView
         completion:(MXAlertViewCompletionBlock)completion
{
    return [self initWithTitle:title
                       message:message
                   cancelTitle:cancelTitle
                   otherTitles:(otherTitle) ? @[ otherTitle ] : nil
                   contentView:contentView
                    completion:completion];
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
        otherTitles:(NSArray *)otherTitles
        contentView:(UIView *)contentView
         completion:(MXAlertViewCompletionBlock)completion
{
    self = [super init];
    if (self) {
        _mainWindow = [self windowWithLevel:UIWindowLevelNormal];
        _alertWindow = [self windowWithLevel:UIWindowLevelAlert];

        if (!_alertWindow) {
            _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _alertWindow.windowLevel = UIWindowLevelAlert;
            _alertWindow.backgroundColor = [UIColor clearColor];
        }
        _alertWindow.rootViewController = self;

        CGRect frame = [self frameForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
        self.view.frame = frame;
        //大背景
        _backgroundView = [[UIView alloc] initWithFrame:frame];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
        _backgroundView.alpha = 0;
        [self.view addSubview:_backgroundView];

        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 2.0;
        _alertView.layer.opacity = 1;
        _alertView.clipsToBounds = YES;
        [self.view addSubview:_alertView];
        
        
        if ([StringUtil isEmpty:title]) { //
            //            title = MXLang(@"ErrorCode_NotifyTitle", @"提示");
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AlertViewContentMargin,
                                                                    0,
                                                                    AlertViewWidth - AlertViewContentMargin*2,
                                                                    AlertViewVerticalElementSpace)];
        }else{
            // Title
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AlertViewContentMargin,
                                                                    AlertViewVerticalElementSpace,
                                                                    AlertViewWidth - AlertViewContentMargin*2,
                                                                    44)];
            _titleLabel.text = title;
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.font = [UIFont boldSystemFontOfSize:14];
            _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _titleLabel.numberOfLines = 0;
            _titleLabel.frame = [self adjustLabelFrameHeight:self.titleLabel];
            [_alertView addSubview:_titleLabel];
            
        }
        
        CGFloat messageLabelY =  CGRectGetMaxY(_titleLabel.frame) + 20;//AlertViewVerticalElementSpace;

        // Optional Content View
        if (contentView) {
            _contentView = contentView;
            _contentView.frame = CGRectMake(0,
                                            messageLabelY,
                                            _contentView.frame.size.width,
                                            _contentView.frame.size.height);
            _contentView.center = CGPointMake(AlertViewWidth/2, _contentView.center.y);
            [_alertView addSubview:_contentView];
            messageLabelY += contentView.frame.size.height + 20;//AlertViewVerticalElementSpace;
        }
        
        // Message
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AlertViewContentMargin,
                                                                  messageLabelY,
                                                                  AlertViewWidth - AlertViewContentMargin*2,
                                                                  30)];
        _messageLabel.text = message;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont font14];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.numberOfLines = 0;
        _messageLabel.frame = [self adjustLabelFrameHeight:self.messageLabel];
        [_alertView addSubview:_messageLabel];
        
        _line=[[UIView alloc]initWithFrame:CGRectMake(AlertViewContentMargin, _messageLabel.frame.origin.y-10, AlertViewWidth - AlertViewContentMargin*2, 1)];
        _line.backgroundColor=[UIColor colorWithWhite:0.4 alpha:0.4];
        _line.hidden=YES;
        [_alertView addSubview:_line];
        // Line
//        CALayer *lineLayer = [self lineLayer];
//        lineLayer.frame = CGRectMake(0, _messageLabel.frame.origin.y + _messageLabel.frame.size.height + AlertViewVerticalElementSpace, AlertViewWidth, AlertViewLineLayerWidth);
//        [_alertView.layer addSublayer:lineLayer];
        
      //  _buttonsY = lineLayer.frame.origin.y + lineLayer.frame.size.height;
        _buttonsY = CGRectGetMaxY(_messageLabel.frame)+AlertViewVerticalElementSpace;
        // Buttons
        if (otherTitles!=nil) {
            _buttonWidth = AlertViewTwoButtonWidth;
        }else{
            _buttonWidth = AlertViewOneButtonWidth;
        }
        if (cancelTitle) {
            [self addButtonWithTitle:cancelTitle titleArray:nil];
        } else {
            [self addButtonWithTitle:@"确定"];
        }
        //按钮
        
        if (otherTitles && [otherTitles count] > 0) {
            for (id otherTitle in otherTitles) {
                NSParameterAssert([otherTitle isKindOfClass:[NSString class]]);
                [self addButtonWithTitle:(NSString *)otherTitle titleArray:otherTitles];
            }
        }

        _alertView.bounds = CGRectMake(0, 0, AlertViewWidth, AlertViewVerticalElementSpace+_titleLabel.frame.size.height+AlertViewVerticalElementSpace+_messageLabel.frame.size.height+AlertViewVerticalElementSpace+_buttonWidth+20);//AlertViewVerticalElementSpace);
    
        if (completion) {
            _completion = completion;
        }

        [self resizeViews];
        _alertView.center = [self centerWithFrame:frame];

       // [self setupGestures];
    }
    return self;
}

- (CGRect)frameForOrientation:(UIInterfaceOrientation)orientation
{
    CGRect frame;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        frame = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
    } else {
        frame = [UIScreen mainScreen].bounds;
    }
    return frame;
}

- (CGRect)adjustLabelFrameHeight:(UILabel *)label
{
    CGFloat height;
    if(!IOS6_Later){
//    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
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
        CGSize maxSize = CGSizeMake(label.frame.size.width, FLT_MAX);
        CGSize size = MX_MULTILINE_TEXTSIZE(label.text, label.font, maxSize, label.lineBreakMode);
//        CGRect bounds = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, FLT_MAX)
//                                                 options:NSStringDrawingUsesLineFragmentOrigin
//                                              attributes:@{NSFontAttributeName:label.font}
//                                                 context:context];
        
        height = size.height;
    }

    return CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, height);
}

- (MXButton *)genericButton
{
    // fkq m 用mxbutton
    MXButton *button = [MXButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont font14];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:112.0/255.0 green:88.0/255.0 blue:164.0/255.0 alpha:1]  forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
//    [button addTarget:self action:@selector(setBackgroundColorForButton:) forControlEvents:UIControlEventTouchDown];
//    [button addTarget:self action:@selector(clearBackgroundColorForButton:) forControlEvents:UIControlEventTouchDragExit];
    return button;
}

- (CGPoint)centerWithFrame:(CGRect)frame
{
    return CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - [self statusBarOffset]);
}

- (CGFloat)statusBarOffset
{
    CGFloat statusBarOffset = 0;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        statusBarOffset = 20;
    }
    return statusBarOffset;
}

- (void)setupGestures
{
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [self.tap setNumberOfTapsRequired:1];
    [self.backgroundView setUserInteractionEnabled:YES];
    [self.backgroundView setMultipleTouchEnabled:NO];
    [self.backgroundView addGestureRecognizer:self.tap];
}

- (void)resizeViews
{
    CGFloat totalHeight = 0;
    for (UIView *view in [self.alertView subviews]) {
        if ([view class] != [MXButton class]) { // fkq m 20170707 change the class beacause use mxbutton
            totalHeight += view.frame.size.height + AlertViewVerticalElementSpace;
        }
    }
    if (self.buttons) {
        NSUInteger otherButtonsCount = [self.buttons count];
        totalHeight += (AlertViewButtonHeight+AlertViewVerticalElementSpace) * (otherButtonsCount > 2 ? otherButtonsCount : 1);
    }
    totalHeight +=AlertViewVerticalElementSpace;
    self.alertView.frame = CGRectMake(self.alertView.frame.origin.x,
                                      self.alertView.frame.origin.y,
                                      self.alertView.frame.size.width,
                                      totalHeight);  // fke M 20140707 heith change (-40)
}

- (void)setBackgroundColorForButton:(id)sender
{
    [sender setBackgroundColor:[UIColor colorWithRed:94/255.0 green:196/255.0 blue:221/255.0 alpha:1.0]];
}

- (void)clearBackgroundColorForButton:(id)sender
{
    [sender setBackgroundColor:[UIColor clearColor]];
}

- (void)show
{
    [[MXAlertViewStack sharedInstance] push:self];
}

- (void)showInternal
{
    [self.alertWindow addSubview:self.view];
    [self.alertWindow makeKeyAndVisible];
    self.visible = YES;
    [self showBackgroundView];
    [self showAlertAnimation];
}

- (void)showBackgroundView
{
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        [self.mainWindow tintColorDidChange];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.alpha = 1;
    }];
}

- (void)hide
{
    [self.view removeFromSuperview];
}

- (void)dismiss:(id)sender
{
    [self dismiss:sender animated:YES];
}

- (void)dismiss:(id)sender animated:(BOOL)animated
{
    self.visible = NO;

    if ([[[MXAlertViewStack sharedInstance] alertViews] count] == 1) {
        if (animated) {
            [self dismissAlertAnimation];
        }
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            self.mainWindow.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            [self.mainWindow tintColorDidChange];
        }
        [UIView animateWithDuration:(animated ? 0.2 : 0) animations:^{
            self.backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.alertWindow removeFromSuperview];
            self.alertWindow.rootViewController = nil;
            self.alertWindow = nil;
            [self.mainWindow makeKeyAndVisible];
        }];
    }

    [UIView animateWithDuration:(animated ? 0.2 : 0) animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [[MXAlertViewStack sharedInstance] pop:self];
        [self.view removeFromSuperview];
    }];

    if (self.completion) {
        BOOL cancelled = NO;
        if (sender == self.cancelButton){ //|| sender == self.tap) {
            cancelled = YES;
        }
        NSInteger buttonIndex = -1;
        if (self.buttons) {
            NSUInteger index = [self.buttons indexOfObject:sender];
            if (buttonIndex != NSNotFound) {
                buttonIndex = index;
            }
        }
        self.completion(cancelled, buttonIndex);
    }
}

- (void)showAlertAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;

    [self.alertView.layer addAnimation:animation forKey:@"showAlert"];
}

- (void)dismissAlertAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeRemoved;
    animation.duration = .2;

    [self.alertView.layer addAnimation:animation forKey:@"dismissAlert"];
}

- (CALayer *)lineLayer
{
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [[UIColor colorWithWhite:0.90 alpha:0.3] CGColor];
    return lineLayer;
}

#pragma mark -
#pragma mark UIViewController

- (BOOL)prefersStatusBarHidden
{
	return [UIApplication sharedApplication].statusBarHidden;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect frame = [self frameForOrientation:interfaceOrientation];
    self.backgroundView.frame = frame;
    self.alertView.center = [self centerWithFrame:frame];
}

#pragma mark -
#pragma mark Public

+ (instancetype)showAlertWithTitle:(NSString *)title
{
    return [[self class] showAlertWithTitle:title message:nil cancelTitle:NSLocalizedString(@"Ok", nil) completion:nil];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
{
    return [[self class] showAlertWithTitle:title message:message cancelTitle:NSLocalizedString(@"Ok", nil) completion:nil];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(MXAlertViewCompletionBlock)completion
{
    return [[self class] showAlertWithTitle:title message:message cancelTitle:NSLocalizedString(@"确定", nil) completion:completion];
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        completion:(MXAlertViewCompletionBlock)completion
{
    return [self showAlertWithTitle:title message:message cancelTitle:cancelTitle otherTitle:nil completion:completion];
}

//canceltitle为nil时 默认显示的时 确定
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                        completion:(MXAlertViewCompletionBlock)completion
{
    if (IOS6_Later) {
        RIButtonItem *cancle = [RIButtonItem itemWithLabel:cancelTitle action:^{
            if (completion) {
                completion(YES, 0);
            }
        }];

        RIButtonItem *ok;
        if (otherTitle) {
            ok = [RIButtonItem itemWithLabel:otherTitle action:^{
                if (completion) {
                    completion(NO, 1);
                }
            }];
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message cancelButtonItem:cancle otherButtonItems:ok, nil];
        [alert show];
        return nil;
    } else {
        MXAlertView *alertView = [[self alloc] initWithTitle:title
                                                     message:message
                                                 cancelTitle:cancelTitle
                                                  otherTitle:otherTitle
                                                 contentView:nil
                                                  completion:completion];
        [alertView show];
        return alertView;
    }
    
    return nil;
}


+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                        completion:(MXAlertViewCompletionBlock)completion
{
    MXAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                             otherTitles:otherTitles
                                             contentView:nil
                                              completion:completion];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                        otherTitle:(NSString *)otherTitle
                       contentView:(UIView *)view
                        completion:(MXAlertViewCompletionBlock)completion
{
    MXAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                              otherTitle:otherTitle
                                             contentView:view
                                              completion:completion];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message
                       cancelTitle:(NSString *)cancelTitle
                       otherTitles:(NSArray *)otherTitles
                       contentView:(UIView *)view
                        completion:(MXAlertViewCompletionBlock)completion
{
    MXAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                             cancelTitle:cancelTitle
                                             otherTitles:otherTitles
                                             contentView:view
                                              completion:completion];
    [alertView show];
    return alertView;
}

- (NSInteger)addButtonWithTitle:(NSString *)title titleArray:(NSArray*)array {
    MXButton *button = [self genericButton];
 
    [button setTitle:title forState:UIControlStateNormal];
    
//    if (array && array.count > 0) {
//        [button setDefaultPurple];
//        [button setTitleColor:[UIColor moPurple] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//        [button setTitleColor:[UIColor colorWithRed:112.0/255.0 green:88.0/255.0 blue:164.0/255.0 alpha:1]  forState:UIControlStateSelected];
//    }else{
        [button drawCircle];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:112.0/255.0 green:88.0/255.0 blue:164.0/255.0 alpha:1]  forState:UIControlStateSelected];
//    }
    
    
    

    button.backgroundColor = [UIColor whiteColor];
    if (!self.cancelButton) {
        self.cancelButton = button;
        if (_buttonWidth == AlertViewTwoButtonWidth) {
            self.cancelButton.frame = CGRectMake(AlertViewContentMargin, self.buttonsY, _buttonWidth, AlertViewButtonHeight);
        }else{
            self.cancelButton.frame = CGRectMake((AlertViewWidth-_buttonWidth)/2, self.buttonsY, _buttonWidth, AlertViewButtonHeight);
        }
    }
    else {
        button.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame)+10, self.buttonsY, _buttonWidth, AlertViewButtonHeight);
//        button.layer.borderColor = [UIColor moPurple].CGColor;
//        button.layer.borderWidth = 0.5;
        
        self.otherButton = button;
        
    }
    
    [self.alertView addSubview:button];
    self.buttons = (self.buttons) ? [self.buttons arrayByAddingObject:button] : @[ button ];
    return [self.buttons count] - 1;
}

- (NSInteger)addButtonWithTitle:(NSString *)title
{
    return [self addButtonWithTitle:title titleArray:nil];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if (buttonIndex >= 0 && buttonIndex < [self.buttons count]) {
        [self dismiss:self.buttons[buttonIndex] animated:animated];
    }
}

- (void)setTapToDismissEnabled:(BOOL)enabled
{
    self.tap.enabled = enabled;
}

@end

@implementation MXAlertViewStack

+ (instancetype)sharedInstance
{
    static MXAlertViewStack *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MXAlertViewStack alloc] init];
        _sharedInstance.alertViews = [NSMutableArray array];
    });

    return _sharedInstance;
}

- (void)push:(MXAlertView *)alertView
{
    [self.alertViews addObject:alertView];
    [alertView showInternal];
    for (MXAlertView *av in self.alertViews) {
        if (av != alertView) {
            [av hide];
        }
    }
}

- (void)pop:(MXAlertView *)alertView
{
    [self.alertViews removeObject:alertView];
    MXAlertView *last = [self.alertViews lastObject];
    if (last) {
        [last showInternal];
    }
}

@end
