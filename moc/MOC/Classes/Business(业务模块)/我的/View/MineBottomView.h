//
//  MineBottomView.h
//  MOC
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineBottomView : UIView

@property (nonatomic , copy) CompletionBlock  block;
@property (nonatomic) NSInteger  nums;

- (void)reloadData:(NSArray*)data;

- (instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num height:(int)height imgWidth:(int)width;


@end

NS_ASSUME_NONNULL_END
