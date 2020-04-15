//
//  AeroplaneChessCell.h
//  MOC
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CellItemWidth ((SCREEN_WIDTH-20-5*4) / 5)
#define CellItemHeight CellItemWidth*52.0/67.0

NS_ASSUME_NONNULL_BEGIN

@interface AeroplaneChessCell : UICollectionViewCell
@property(nonatomic, copy) CompletionBlock starPressBlock;
- (void)reloadUI:(NSDictionary *)dic index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
