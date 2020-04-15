//
//  MineCenterCell.h
//  MOC
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineCenterCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *nameLbl;

-(void)reloadTitle:(NSString* )title name:(NSString* )name;

@end

NS_ASSUME_NONNULL_END
