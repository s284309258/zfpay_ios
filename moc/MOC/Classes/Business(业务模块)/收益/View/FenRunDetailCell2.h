//
//  FenRunDetailCell2.h
//  XZF
//
//  Created by mac on 2019/8/8.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MachineBackPosModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FenRunDetailCell2 : UITableViewCell

-(void)reload:(MachineBackPosModel*)model type:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
