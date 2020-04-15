//
//  LXChatBoxManager.h
//  Lcwl
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^InputMsgBlock)(NSString *msg);

@interface LXChatBoxManager : NSObject
@property(nonatomic, weak) UITableView *tableDelegate;
+ (LXChatBoxManager *)shared;
- (void)showKeyBoard:(nullable NSString *)placeHolder block:(InputMsgBlock)block;
- (void)hideKeyBoard;
@end

NS_ASSUME_NONNULL_END
