//
//  AppImgModel.h
//  XZF
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppImgModel : BaseObject

@property (nonatomic ,copy) NSString* id;

@property (nonatomic ,copy) NSString* img_type;

@property (nonatomic ,copy) NSString* img_url;

@end

NS_ASSUME_NONNULL_END
