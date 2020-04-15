//
//  RFCellView.h
//  XZF
//
//  Created by mac on 2019/8/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFCellView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

-(void)reloadBack:(NSString* )img
            title:(NSString* )title desc:(NSString* )desc
            sub:(NSString* )subTitle subDesc:(NSString* )subDesc
            sub1:(NSString* )subTitle1 subDesc:(NSString* )subDesc1
            sub2:(NSString*)subTitle2 subDesc:(NSString* )subDesc2;

@end

NS_ASSUME_NONNULL_END
