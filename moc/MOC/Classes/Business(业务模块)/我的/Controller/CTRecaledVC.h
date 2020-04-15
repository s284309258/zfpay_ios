//
//  CTRecaledVC.h
//  XZF
//
//  Created by mac on 2019/8/24.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTRecaledVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

NS_ASSUME_NONNULL_END
