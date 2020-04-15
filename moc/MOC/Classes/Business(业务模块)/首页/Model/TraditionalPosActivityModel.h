//
//  TraditionalPosActivityModel.h
//  XZF
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TraditionalPosActivityModel : BaseObject

@property (nonatomic, strong) NSString* activity_id;

@property (nonatomic, strong) NSString* activity_name;

@property (nonatomic, strong) NSString* cover_url;

@property (nonatomic, strong) NSString* start_date;

@property (nonatomic, strong) NSString* end_date;

@end

NS_ASSUME_NONNULL_END
