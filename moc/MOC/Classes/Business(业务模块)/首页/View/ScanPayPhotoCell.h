//
//  ScanPayCell.h
//  XZF
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanPayPhotoCell : UICollectionViewCell

@property (nonatomic,strong) CompletionBlock block;

-(void)reload:(NSString*)image title:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
