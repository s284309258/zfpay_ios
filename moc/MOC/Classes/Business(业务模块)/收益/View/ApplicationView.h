//
//  ApplicationView.h
//  MOC
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationView : UIView

@property (nonatomic, strong)  MXSeparatorLine* line ;

- (instancetype)initWithFrame:(CGRect)frame ;

-(void)reloadImg:(NSString* )imgPath text:(NSString* )text;

@end

NS_ASSUME_NONNULL_END
