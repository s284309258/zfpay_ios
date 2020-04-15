//
//  VideoPlayManager.h
//  BOB
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayManager : NSObject
+ (instancetype)share;
- (void)play:(NSString *)url superView:(UIView *)superView;
@end

NS_ASSUME_NONNULL_END
