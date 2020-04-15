//
//  SSSearchBar.h
//  Demo
//
//  Created by xk jiang on 2017/10/10.
//  Copyright © 2017年 xk jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,PlaceHolderPositionType) {
    PlaceHolderPositionType_Manual,
    PlaceHolderPositionType_Auto,
};

@interface SSSearchBar : UISearchBar

@property(nonatomic, assign) PlaceHolderPositionType positionType;

@end

NS_ASSUME_NONNULL_END
