//
//  NoticeModel.h
//  JiuJiuEcoregion
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeModel : BaseObject

@property (nonatomic, strong) NSString* notice_id;

@property (nonatomic, strong) NSString* notice_title;

@property (nonatomic, strong) NSString* notice_content;

@property (nonatomic, strong) NSString* cre_date;


@end

NS_ASSUME_NONNULL_END
