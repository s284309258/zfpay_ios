//
//  UIViewController+Customize.m
//  meiliyue
//
//  Created by fly on 12-12-14.
//  Copyright (c) 2012年 sjxu. All rights reserved.
//

#import "UIViewController+Customize.h"

#define kNavBtnHeight               30
#define kNavBtnIconImgWidth         16
#define kNavBtnIconImgHeight        16
#define kNavBtnIconImgYMagin        6
#define kNavBtnIconImgXMagin        8
#define kNavBtnIconLabXMagin        3
#define kNavBtnIconLabRightMagin    11

#define kNavBtnTag                  10212


@implementation UIViewController (Customize)

- (BOOL)isModal{
    if (self.navigationController != nil) {
        return NO;
    }
    return YES;
}

- (BOOL)isNavRootViewController{
    if(self.navigationController == nil){
        return NO;
    }
    
    UIViewController * pRoot	= [self.navigationController.viewControllers safeObjectAtIndex:0];
    if (nil == pRoot || self == pRoot) {
        return YES;
    }
    return NO;
}


-(void)closeViewAnimated:(BOOL)animated{
	if([self isModal])
		[self dismissViewControllerAnimated:animated completion:nil];
	else {
		[self.navigationController popViewControllerAnimated:animated];
	}
}

- (UIButton*)buttonWithNavBackStyle:(NSString*)strTitle{
    return [self buttonWithNavBackStyle:strTitle withBtnImageName:@"btn_back.png"];
}

- (UIButton*)buttonWithNavBackStyle:(NSString*)strTitle withBtnImageName:(NSString *)strImgName {
    UIFont* font            = [UIFont boldSystemFontOfSize:14.0f];
    CGSize nSize            = [strTitle sizeWithAttributes:@{NSFontAttributeName:font}];
    int nNewWidth           = nSize.width + 29 < 55 ? 55 : nSize.width + 26;
    
	UIButton* btn			= [[UIButton alloc] initWithFrame:CGRectMake(0,0,nNewWidth,kNavBtnHeight)];
	btn.titleLabel.font		= font;
    btn.titleLabel.shadowColor = [UIColor blackColor];
    btn.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    UIEdgeInsets edge = btn.titleEdgeInsets;
    edge.left +=5;
    btn.titleEdgeInsets = edge;
    
	[btn setTitle:strTitle forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	return btn;
}

- (UIButton*)buttonWithNavLeftStyle:(NSString*)strTitle withBtnImageName:(NSString *)strImgName {
    UIFont* font            = [UIFont boldSystemFontOfSize:12.0f];
    CGSize nSize            = [strTitle sizeWithAttributes:@{NSFontAttributeName:font}];
    int nNewWidth           = nSize.width + 25 < 52 ? 52 : nSize.width + 16;
    
	UIButton* btn			= [[UIButton alloc] initWithFrame:CGRectMake(0,0,nNewWidth,kNavBtnHeight)];
	btn.titleLabel.font		= font;
    btn.titleLabel.shadowColor = [UIColor blackColor];
    btn.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    UIEdgeInsets edge = btn.titleEdgeInsets;
    edge.left +=5;
    btn.titleEdgeInsets = edge;
    
	[btn setTitle:strTitle forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	return btn;
}

- (UIButton*)buttonWithConfirmStyle:(NSString*)strTitle{
    return [self buttonWithConfirmStyle:strTitle imageName:nil];
}

- (UIButton*)buttonWithIcon:(NSString*)strImgName{
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,44,kNavBtnHeight)];
    [button setImage:[UIImage imageNamed:strImgName] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    return button;
}

- (UIButton*)buttonWithConfirmStyle:(NSString*)strTitle imageName:(NSString *)strImgName{
    UIFont* font            = [UIFont font17];
    CGSize nSize            = [strTitle sizeWithAttributes:@{NSFontAttributeName:font}];
    int nNewWidth           = nSize.width + 25 < 52 ? 52 : nSize.width + 16;
    //wujuan.begin
    if([StringUtil isEmpty:strTitle] && ![StringUtil isEmpty:strImgName]) {
        nNewWidth = 20.0f;
    }
    //wujuan.end
	UIButton* btn			= [[UIButton alloc] initWithFrame:CGRectMake(0,0,nNewWidth,kNavBtnHeight)];
    btn.tag  = kNavBtnTag;
	btn.titleLabel.font		= font;
    btn.titleLabel.shadowColor = [UIColor blackColor];
    btn.titleLabel.shadowOffset = CGSizeMake(0, -1.0);
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -20);

    
	[btn setTitle:strTitle forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor moBlack] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn setImage:[UIImage imageNamed:strImgName] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 5)];
    if([StringUtil isEmpty:strTitle] && ![StringUtil isEmpty:strImgName]) {
          [btn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
    }
	return btn;
}



- (void)removeNavLeftButton{
    UIView *vi = [[UIView alloc] init];
    vi.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:vi];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle{
    [self addNavConfirmButtonWithDefaultAction:strTitle backGroundImgName:nil];
}

- (void)addNavConfirmButtonWithIconName:(NSString *)strImgName{
    UIButton *btn = [self buttonWithIcon:strImgName];
    if (btn) {
        [btn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rItem	= [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = rItem;
    }
}

- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle backGroundImgName:(NSString *)strImgName{
    UIButton* btn;
    if (strImgName == nil) {
        btn = [self buttonWithConfirmStyle:strTitle];
    }else{
        btn = [self buttonWithConfirmStyle:strTitle imageName:strImgName];
    }
    if (btn) {
        btn.tag  = kNavBtnTag;
        [btn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rItem	= [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = rItem;
    }
}

- (void)setConfirmButtonTitle:(NSString *)strTitle{
    UIButton *btn = (UIButton *)[self.navigationController.view viewWithTag:kNavBtnTag];
    if (btn && [[btn superview] isKindOfClass:[UINavigationBar class]]) {
        [btn setTitle:strTitle forState:UIControlStateNormal];
    }
}

- (void)setConfirmButtonEnabled:(BOOL)nEnabled{
    UIButton *btn = (UIButton *)[self.navigationController.view viewWithTag:kNavBtnTag];
    if (btn && [[btn superview] isKindOfClass:[UINavigationBar class]]) {
        btn.enabled = nEnabled;
    }
}


- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle iconImageName:(NSString *)strIconImgName{
    UIView *rView = [self viewWithConfirmStyle:strTitle iconImgName:strIconImgName];
    
    UIBarButtonItem* lItem	= [[UIBarButtonItem alloc] initWithCustomView:rView];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = lItem;
}

- (void)addNavConfirmButtonWithDefaultAction:(NSString*)strTitle
                               iconImageName:(NSString *)strIconImgName
                         withBackGroundImage:(NSString*)bgImg{
    UIView *rView = [self viewWithConfirmStyle:strTitle iconImgName:strIconImgName withBackGroundImage:bgImg];
    
    UIBarButtonItem* lItem	= [[UIBarButtonItem alloc] initWithCustomView:rView];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = lItem;
}


- (UIView *)viewWithConfirmStyle:(NSString *)strTitle
                     iconImgName:(NSString *)strIconImgName{
    return [self viewWithConfirmStyle:strTitle iconImgName:strIconImgName withBackGroundImage:@"btn_next_blue.png"];
}

- (UIView *)viewWithConfirmStyle:(NSString *)strTitle
                     iconImgName:(NSString *)strIconImgName
             withBackGroundImage:(NSString*)strBgImg{
    UIFont* font            = [UIFont boldSystemFontOfSize:11.0f];
    CGSize nSize            = [strTitle sizeWithAttributes:@{NSFontAttributeName:font}];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:strIconImgName]];
    CGFloat imgWidth    = iconImgView.image.size.width /2.0f;
    CGFloat imgHeight   = iconImgView.image.size.height /2.0f;
    iconImgView.frame = CGRectMake(kNavBtnIconImgXMagin, (kNavBtnHeight - imgHeight)/2.0f, imgWidth , imgHeight);
    CGFloat labXMagin = CGRectGetMaxX(iconImgView.frame) + kNavBtnIconLabXMagin;
    UILabel *rLab = [[UILabel alloc] init];
    if (strTitle) {
        rLab.frame = CGRectMake(labXMagin, (kNavBtnHeight - nSize.height)/2.0f, nSize.width, nSize.height);
        rLab.text = strTitle;
        rLab.shadowColor    = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        rLab.shadowOffset   = CGSizeMake(0, -1);
        rLab.textColor      = [UIColor whiteColor];
        rLab.backgroundColor = [UIColor clearColor];
        rLab.font = font;
    }
    
    UIView *rView = [[UIView alloc] init];
    CGFloat rViewWidth = labXMagin + CGRectGetWidth(rLab.frame) + kNavBtnIconLabRightMagin;
    if (!strTitle) {
        rViewWidth -= 5;
    }
    rView.frame =  CGRectMake(0, 0, rViewWidth, kNavBtnHeight);
    UIButton* btn = [[UIButton alloc] initWithFrame:rView.frame];
    if (btn) {
        [rView addSubview:btn];
        [rView addSubview:iconImgView];
        [rView addSubview:rLab];
        
        
        [btn addTarget:self action:@selector(navLeftBtnItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return rView;
}


#pragma mark - action 

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backBtnClick:(id)sender
{
    [self closeViewAnimated:YES];
}

- (void)confirmBtnClick:(id)sender
{
    
}

- (void)navLeftBtnItemClick:(id)sender
{
    
}

- (void)cancelButtonClick:(UIButton *)button
{
    
}
- (void)leftButtonClick:(id)sender
{


}

@end
