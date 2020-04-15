//
//  MerchantDetailCell.h
//  XZF
//
//  Created by mac on 2019/8/23.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchantListCell : UITableViewCell

@property (nonatomic,strong) dispatch_block_t nameAndTel;

-(void)reload:(NSString* )title desc:(NSString* )desc ;

-(void)reload:(NSString* )title desc:(NSString* )desc mTitle:(NSString*)mTitle mDesc:(NSString*)mDesc;

@end

NS_ASSUME_NONNULL_END
