//
//  InfoCellView.h
//  MOC
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoCellView : UIView

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *descLbl;

@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) MXSeparatorLine* line;

- (instancetype)initWithFrame:(CGRect)frame;

-(void)reloadTitle:(NSString* )title desc:(NSString* )desc;

@end

NS_ASSUME_NONNULL_END
