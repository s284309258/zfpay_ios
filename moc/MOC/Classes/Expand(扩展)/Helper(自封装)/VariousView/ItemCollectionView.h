//
//  ItemCollectionView.h
//  MOC
//
//  Created by mac on 2019/7/26.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemCollectionView : UIView

@property (nonatomic , copy) CompletionBlock  block;

@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithFrame:(CGRect)frame;

- (int)viewHeight;

- (void)reloadData;

- (void)reloadData:(NSArray*)data layout:(UICollectionViewFlowLayout*)layout;

@end

NS_ASSUME_NONNULL_END
