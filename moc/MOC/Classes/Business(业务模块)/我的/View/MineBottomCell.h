//
//  MineBottomCell.h
//  MOC
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineBottomCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *logoImgView;

@property (nonatomic, strong) UILabel *nameLbl;

@property (nonatomic) int iconWidth;

-(void)reloadImg:(NSString* )path name:(NSString* )name;

@end

NS_ASSUME_NONNULL_END
