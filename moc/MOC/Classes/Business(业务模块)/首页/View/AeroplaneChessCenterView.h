//
//  AeroplaneChessCenterView.h
//  MOC
//
//  Created by mac on 2019/6/19.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessBnt.h"

NS_ASSUME_NONNULL_BEGIN

@interface AeroplaneChessCenterView : UIView
@property(nonatomic, strong) ChessBnt *chessBnt;
@property(nonatomic, copy) CompletionBlock multiBlock;
@property(nonatomic, copy) CompletionBlock throwDiceblock;
- (void)reloadUI:(NSString *)multi saleCount:(NSString *)saleCount;
- (void)reloadMultiLabel:(NSString *)multi;
- (void)startAnimationView:(NSNumber *)jump;
@end

NS_ASSUME_NONNULL_END
