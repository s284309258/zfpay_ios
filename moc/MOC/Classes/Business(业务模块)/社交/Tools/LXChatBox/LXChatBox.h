//
//  LXChatBox.h
//  LXChatBox
//
//  Created by zlwl001 on 2017/3/7.
//  Copyright © 2017年 manman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+Placeholder.h"

typedef NS_ENUM(NSInteger, LXChatBoxStatus) {
    LXChatBoxStatusNothing,     // 默认状态,该状态不会显示在底部
    LXChatBoxStatusChatNothing, // 聊天默认状态,该状态会显示在底部
    LXChatBoxStatusShowVoLXe,   // 录音状态
    LXChatBoxStatusShowFace,    // 输入表情状态
    LXChatBoxStatusShowMore,    // 显示“更多”页面状态
    LXChatBoxStatusShowKeyboard,// 正常键盘
    LXChatBoxStatusShowVideo    // 录制视频
};

@protocol LXChatBoxDelegate <NSObject>

-(void)changeStatusChat:(CGFloat)chatBoxY;
-(void)chatBoxSendTextMessage:(NSString *)message;

@end

@interface LXChatBox : UIView
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,assign)LXChatBoxStatus status;
@property(nonatomic,assign)BOOL isDisappear;
//非聊天的情况下只会有表情包，没有录音和更多按钮
@property(nonatomic,assign)BOOL isChatBar;
@property(nonatomic,assign)NSInteger maxVisibleLine;
@property(nonatomic,weak)id<LXChatBoxDelegate>delegate;

@end
