//
//  CipherView.h
//  ScanPay
//
//  Created by mac on 2019/7/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CipherView : UIView

@property (nonatomic, strong) UITextField     *tf;

@property (nonatomic , strong) CompletionBlock getText;

@property (nonatomic , strong) CompletionBlock btnClick;

@property (nonatomic , strong) CompletionBlock rowClick;

@property (nonatomic, strong) UIButton        *btn;

-(void)reloadTitle:(NSString *) title placeHolder:(NSString *)placeHolder;

-(void)reloadImg:(NSString *) image  placeHolder:(NSString *)placeHolder;

-(void)reloadPlaceHolder:(NSString *)placeHolder;

-(void)isHiddenLine:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
