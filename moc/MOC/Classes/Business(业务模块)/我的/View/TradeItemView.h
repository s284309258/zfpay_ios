//
//  TradeItemView.h
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TradeItemView : UIView


@property (nonatomic, strong) UILabel *lbl;

@property (nonatomic , strong) CompletionBlock block;

@property (nonatomic , strong) CompletionBlock selectedBlock;

- (instancetype)initWithFrame:(CGRect)frame column:(NSInteger) column;

-(void)configData:(NSArray*)dataArray;

-(NSInteger)getHeight;

@end

NS_ASSUME_NONNULL_END
