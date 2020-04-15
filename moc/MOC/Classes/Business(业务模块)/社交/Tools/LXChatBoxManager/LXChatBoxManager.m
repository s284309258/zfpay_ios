//
//  LXChatBoxManager.m
//  Lcwl
//
//  Created by mac on 2018/12/27.
//  Copyright © 2018 lichangwanglai. All rights reserved.
//

#import "LXChatBoxManager.h"
#import "LXChatBox.h"
#import "LXEmotionManager.h"

@interface LXChatBoxManager ()<LXChatBoxDelegate>
@property(nonatomic,strong)LXChatBox *chatBox;
@property(nonatomic, copy) InputMsgBlock block;
@property(nonatomic,strong) UIControl *backgroundControl;
@end

@implementation LXChatBoxManager
+ (LXChatBoxManager *)shared {
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void)showKeyBoard:(nullable NSString *)placeHolder block:(InputMsgBlock)block {
    self.block = block;
    
    if(self.chatBox == nil) {
        self.chatBox = [[LXChatBox alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TabbarHeight, SCREEN_WIDTH, TabbarHeight)];
        self.chatBox.maxVisibleLine = 4;
        self.chatBox.delegate = self;
        self.chatBox.isChatBar = YES;
        self.backgroundControl = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.backgroundControl addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(placeHolder && placeHolder.length > 0) {
        self.chatBox.textView.placeholder = placeHolder;
    }
    
    [[[UIApplication sharedApplication] delegate].window addSubview:self.backgroundControl];
    [[[UIApplication sharedApplication] delegate].window addSubview:self.chatBox];
    self.chatBox.status = LXChatBoxStatusShowKeyboard;
}

- (void)hideKeyBoard {
    [self.backgroundControl removeFromSuperview];
    self.chatBox.status = LXChatBoxStatusNothing;
    [self.chatBox removeFromSuperview];
}

- (void)changeStatusChat:(CGFloat)chatBoxY {
    if(self.tableDelegate && [self.tableDelegate isKindOfClass:[UITableView class]]) {
//        tableDelegate.frame = CGRectMake(0, 64, KScreenW, chatBoxY - 20-64);
//        [tableDelegate scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.array.count -1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void)chatBoxSendTextMessage:(NSString *)message {
    //[self performSelector:@selector(hideKeyBoard) withObject:nil afterDelay:0.3];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideKeyBoard];
    });
    
    Block_Exec(self.block, message);
}

@end
