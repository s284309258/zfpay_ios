//
//  CashOutRecordCell.h
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CashOutRecordCell : UITableViewCell

-(void)reload:(CashRecordModel*)model;

@end

NS_ASSUME_NONNULL_END
