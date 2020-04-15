//
//  ShareOverlayer.h
//  MOC
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareOverlayer : UIView


@property (nonatomic , strong) UIImageView *qrcodeImg;

@property (nonatomic , strong) UILabel *qrcodeLbl;

+(void)showOverLayer:(NSString*)qrcode_url share:(CompletionBlock)share save:(CompletionBlock)save imgArray:(NSMutableArray*)imgArray;

@end

NS_ASSUME_NONNULL_END
