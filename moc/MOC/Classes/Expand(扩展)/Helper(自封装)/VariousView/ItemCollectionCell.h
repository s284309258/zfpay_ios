//
//  MineBottomCell.h
//  MOC
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"
#import "ItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ItemCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) THLabel *nameLbl;

@property (nonatomic) int iconWidth;

-(void)reloadImg:(NSString* )path name:(NSString* )name imageSize:(CGSize )size;

-(void)reloadData:(ItemModel*)item;

@end

NS_ASSUME_NONNULL_END
