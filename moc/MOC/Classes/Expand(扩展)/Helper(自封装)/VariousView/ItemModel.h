//
//  ItemModel.h
//  MOC
//
//  Created by mac on 2019/7/26.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemModel : NSObject

@property (nonatomic ,copy) NSString* image;

@property (nonatomic ,copy) NSString* text;

@property (nonatomic) CGSize imageSize;

@property (nonatomic ,strong) dispatch_block_t block;

@property (nonatomic ,strong) UIColor* strokeColor;

@property (nonatomic) NSInteger strokeSize;

@property (nonatomic) UIFont* font;

@property (nonatomic ,strong) UIColor* textColor;

@property (nonatomic) BOOL hasPoint;

@end

NS_ASSUME_NONNULL_END
