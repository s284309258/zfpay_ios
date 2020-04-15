//
//  Notify.m
//  Moxian
//
//  Created by litiankun on 13-11-22.
//  Copyright (c) 2013年 Moxian. All rights reserved.
//

#import "NotifyHelper.h"
#import "StringUtil.h"
#import "MXLoadingGifView.h"

@interface NotifyHelper()<UIAlertViewDelegate>
{
    
}
@property (nonatomic,strong) AlertBlock myAlertBlock;

@end

@implementation NotifyHelper
@synthesize myAlertBlock;

/**
 * (NotifyHelper)单列模式:实例化对象
 */
#pragma mark - NotifyHelper sharedInstance
+ (NotifyHelper*)sharedInstance{
    
    static id sharedInstanceNH;
    static dispatch_once_t onceNH;
    dispatch_once(&onceNH, ^{
        sharedInstanceNH = [[[self class] alloc] init];
    });
    return sharedInstanceNH;
}
- (id)init{
    if(!(self = [super init])){
        return nil;
    }
    return self;
}


#pragma mark - showAlertProgressDialogAddedTo
+(void)showAlertProgressDialogAddedTo:(UIView*)view animated:(BOOL)animated {
   
    [super showHUDAddedTo:view animated:animated];
    
}

#pragma mark - hideAlertProgressDialogForView
+(void)hideAlertProgressDialogForView:(UIView *)view animated:(BOOL)animated {
    
    [super hideHUDForView:view animated:animated];
}

+ (MBProgressHUD *)showMXLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [super showHUDAddedTo:view animated:animated];
//    hud.minShowTime = 1.0f;
    hud.mode = MBProgressHUDModeCustomView;
    
    MXLoadingGifView *gifView = [[MXLoadingGifView alloc] init];
    [gifView show];
    hud.customView = gifView;
    
    return hud;
}

+ (MBProgressHUD *)showMXCustomView:(UIView *)customView animated:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow  animated:animated];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = customView;
    hud.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud setHidden:YES];
    });
    return hud;
}

+ (void)showHUDAddedTo:(UIView *)view makeText:(NSString *)text animated:(BOOL)animated {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelText = text;
    [view addSubview:hud];
    [hud show:animated];
}

#pragma mark 显示状态时同时加入描述内容
+ (void)showHUD {
	MBProgressHUD *hud = [[MBProgressHUD alloc] init];
	[[UIApplication sharedApplication].keyWindow addSubview:hud];
	[hud show:YES];
}

+ (void)hideHUD {
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+(void)showMessageWithMakeText:(NSString*)text delay:(int)del{
    if (del<1) {
        del = 2;
    }
    
    //先清除之前的视图
    for(id cc in [[[UIApplication sharedApplication].windows lastObject] subviews])
    {
        if([cc isKindOfClass:[MBProgressHUD class]])
        {
            MBProgressHUD *previousHUD = (MBProgressHUD *)cc;
            previousHUD.removeFromSuperViewOnHide = YES;
            [previousHUD hide:YES];
        }
    }
    
    UIView *baseView = [UIApplication sharedApplication].keyWindow;
#if 0
    for(UIView *cc in [[UIApplication sharedApplication].windows reverseObjectEnumerator])
    {
        if(cc.hidden == NO) {
            baseView = cc;
            break;
        }
    }
#endif
    
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES]; //这样可以不被键盘覆盖
	
	// Configure for text only and offset down
    hud.userInteractionEnabled = NO;
	hud.mode = MBProgressHUDModeText;
	hud.detailsLabelText = text;
//    hud.color=[UIColor moPurple];
    hud.labelFont = [UIFont boldSystemFontOfSize:13];
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
    
	[hud hide:YES afterDelay:del];
}

+ (MBProgressHUD *)showMessageWithMakeText:(NSString *)text onView:(UIView *)view delay:(int)del{
    if (del<1) {
        del = 2;
    }
    
    //先清除之前的视图
    for(id cc in [[[UIApplication sharedApplication].windows lastObject] subviews])
    {
        if([cc isKindOfClass:[MBProgressHUD class]])
        {
            MBProgressHUD *previousHUD = (MBProgressHUD *)cc;
            previousHUD.removeFromSuperViewOnHide = YES;
            [previousHUD hide:YES];
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ? :[[UIApplication sharedApplication].windows lastObject] animated:YES]; //这样可以不被键盘覆盖
    
    // Configure for text only and offset down
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = text;
    //    hud.color=[UIColor moPurple];
    hud.labelFont = [UIFont boldSystemFontOfSize:13];
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:del];
    
    return hud;
}


#pragma mark - showMessageWithMakeText
+(void)showMessageWithMakeText:(NSString *)text {
    if ([StringUtil isEmpty:text]) {
        return;
    }
#if 0
    UIView *topView = [[UIApplication sharedApplication].windows lastObject];
    if([[NSStringFromClass([topView class]) lowercaseString] containsString:@"keyboard"]) { //如果有键盘延迟调用,否则会一闪而过
        [NotifyHelper performSelector:@selector(showMessageWithMakeText:delay:) withObject:text afterDelay:0.5];
    } else {
        [NotifyHelper showMessageWithMakeText:text delay:2];
    }
#endif
    [NotifyHelper showMessageWithMakeText:text delay:2];
}


/***************************************************alertView*********************************************/

#pragma mark - showAlertView

-(void)showAlertViewWithTitle:(NSString*)title
                      message:(NSString*)message
            cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle
                   completion:(AlertBlock)_block {
    
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:title
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:cancelButtonTitle
                                            otherButtonTitles:otherButtonTitle,nil];
    myAlert.delegate=self;
    
    if (myAlert) {
        self.myAlertBlock = _block;
    }
    
    [myAlert show];
    
}

-(void)showAlertViewWithMessage:(NSString*)message
              cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle
                     completion:(AlertBlock)_block {

   

    [self showAlertViewWithTitle:nil message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle completion:_block];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.myAlertBlock!=nil) {
         self.myAlertBlock(buttonIndex);
    }
}

@end
