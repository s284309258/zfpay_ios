//
//  HWBaseViewController.h
//  HWPanModal_Example
//
//  Created by heath wang on 2019/4/30.
//  Copyright © 2019 HeathWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosOnlineActivityModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    ActivityOverlayType = 0 ,
    PosOverlayType,
    BankOverlayType
} OverlayType;
@protocol OverlayDelegate <NSObject>

@required

@optional

@end
@interface HWBaseViewController : UIViewController


@property (nonatomic,strong) CompletionBlock block;

@property (nonatomic) OverlayType type;

-(void)configActivityModel:(NSArray*)activityArray;

-(void)configPosModel:(NSArray*)posArray;

@end

NS_ASSUME_NONNULL_END
