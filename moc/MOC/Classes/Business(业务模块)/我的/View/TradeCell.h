//
//  TradeCell.h
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    NormalButtonType = 0,
    UnableButtonType,
    SelectedButtonType
} ButtonType;

@interface TradeCell : UICollectionViewCell

-(void)reload:(NSString* )text state:(ButtonType)type;

@end

NS_ASSUME_NONNULL_END
