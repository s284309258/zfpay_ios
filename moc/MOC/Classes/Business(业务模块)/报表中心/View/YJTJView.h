//
//  YJTJView.h
//  XZF
//
//  Created by mac on 2019/8/7.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFPosDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YJTJView : UIView

@property (nonatomic , strong) CompletionBlock dateBlock;

@property (nonatomic , strong) CompletionBlock chartBlock;

+(NSInteger)getHeight;

-(void)refreshHeader:(NSString* )color text:(NSString *)text desc:(NSString *)desc;

-(void)reload:(RFPosDetailModel*)model btnTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
