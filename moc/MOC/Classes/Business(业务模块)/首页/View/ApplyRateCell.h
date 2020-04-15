//
//  PosDetailCell.h
//  XZF
//
//  Created by mac on 2019/8/10.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyRateModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplyRateCell : UITableViewCell

-(void)reload:(ApplyRateModel*)model select:(BOOL)select type:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
