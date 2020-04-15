//
//  MachineManageCell.h
//  XZF
//
//  Created by mac on 2019/8/15.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosAllocationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MachineManageCell : UITableViewCell

@property (nonatomic , strong) UIImageView* iconImg;

-(void)reload:(PosAllocationModel*)model select:(BOOL)isSelect type:(NSInteger)type;

-(void)LLKLayout;

@end

NS_ASSUME_NONNULL_END
