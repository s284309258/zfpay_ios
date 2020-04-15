//
//  SetPhoneNumView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetPhoneNumView : UIView

-(void)reload:(NSString *)title desc:(NSString* )desc;

-(void)setTitleColor:(UIColor* )titleCol descColor:(UIColor *)descCol;

@end

NS_ASSUME_NONNULL_END
