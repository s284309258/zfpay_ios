//
//  FriendUnlockListModel.h
//  MOC
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendUnlockListModel : BaseObject
@property (nonatomic, copy)   NSString *_id;
@property (nonatomic, copy)   NSString *helpUserId;
@property (nonatomic, assign) NSInteger unblockStatus;
@property (nonatomic, copy)   NSString *helpUserMobile;
@property (nonatomic, copy)   NSString *helpRemark;
@property (nonatomic, strong) NSString *userRemark;
@property (nonatomic, copy)   NSString *unblockTime;
@property (nonatomic, copy)   NSString *freezeTime;
@property (nonatomic, copy)   NSString *userId;
@property (nonatomic, assign) NSInteger helpStatus;
@property (nonatomic, copy)   NSString *createTime;
@property (nonatomic, copy)   NSString *reason;
@property (nonatomic, copy)   NSString *helpTime;
@property (nonatomic, copy)   NSString *userMobile;
@property (nonatomic, assign) NSInteger unblockAmount;
@property (nonatomic, copy)   NSString *updateTime;
@end

NS_ASSUME_NONNULL_END
