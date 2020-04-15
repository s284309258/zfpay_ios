//
//  ApplyRateRecordCell.h
//  XZF
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyScanRecordModel.h"
#import "ApplyRateRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplyRateRecordCell : UITableViewCell

-(void)reload:(ApplyScanRecordModel*)model;

-(void)reloadRate:(ApplyRateRecordModel *)model;

@end

NS_ASSUME_NONNULL_END
