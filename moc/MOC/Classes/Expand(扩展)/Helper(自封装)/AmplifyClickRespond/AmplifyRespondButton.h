//
//  AmplifyRespondButton.h
//  MoPal_Developer
//
//  该类用于改善一些button由于过小难以点击的问题,默认button的点击响应范围向四周扩大10个像素
//
//  Created by xgh on 15/9/16.
//  Copyright (c) 2015年 MoXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmplifyRespondButton : UIButton
@property (nonatomic,assign) CGFloat expendDx;
@property (nonatomic,assign) CGFloat expendDy;
@end
