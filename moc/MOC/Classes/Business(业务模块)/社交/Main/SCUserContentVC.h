//
//  SCUserContentVC.h
//  Lcwl
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "BaseViewController.h"
#import "WBStatusLayout.h"

@protocol SCUserContentDelegate <NSObject>



@end
NS_ASSUME_NONNULL_BEGIN
///详情评论列表
@interface SCUserContentVC : BaseViewController
@property (nonatomic, copy) NSString *cellTitle;
@property (nonatomic, copy) NSString *circle_id;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WBStatusLayout *layout;

- (void)insetData:(NSDictionary *)dic;
- (void)removeData:(NSString *)itemId;
@end

NS_ASSUME_NONNULL_END
