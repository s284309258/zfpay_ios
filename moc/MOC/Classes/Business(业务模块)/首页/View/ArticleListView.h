//
//  ArticleListView.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/10.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsListModel;
NS_ASSUME_NONNULL_BEGIN

@interface ArticleListView : UIView

-(void)reloadData:(NewsListModel *)model;

@end

NS_ASSUME_NONNULL_END
