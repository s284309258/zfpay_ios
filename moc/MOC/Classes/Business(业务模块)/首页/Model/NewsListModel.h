//
//  ArticleListModel.h
//  AdvertisingMaster
//
//  Created by mac on 2019/4/10.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsListModel : BaseObject

@property (nonatomic,copy) NSString* news_id;

@property (nonatomic,copy) NSString* news_title;

@property (nonatomic,copy) NSString* news_cover;

@property (nonatomic,copy) NSString* browse_num;

@property (nonatomic,copy) NSString* cre_date;

@property (nonatomic,copy) NSString* news_nav;

@property (nonatomic,copy) NSString* news_content;

@end

NS_ASSUME_NONNULL_END
