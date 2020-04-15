//
//  SCUserContentCell.h
//  Lcwl
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialDetailListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCUserContentCell : UITableViewCell
@property(nonatomic, copy) CompletionBlock block;

- (void)hideMoreBnt:(BOOL)hidden;
- (void)configUI:(SocialDetailListModel *)model indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
