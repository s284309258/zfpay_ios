//
//  PhoneNumView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/5.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LoginRegModel;
@interface PhoneNumView : UIView

@property (nonatomic , strong) CompletionBlock getText;


-(void)reloadPlaceHolder:(NSString *) placeholder image:(NSString *)image;

//-(void)showBorder;

-(void)showDownLine:(BOOL)isShow;

-(void)reloadText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
