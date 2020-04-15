//
//  XWMoneyTextField.m
//  XWMoneyTextField
//
//  Created by smile.zhang on 16/3/10.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWMoneyTextField.h"
#import "XWMoneyTextFieldLimit.h"

@interface XWMoneyTextField ()
@property (nonatomic, strong) XWMoneyTextFieldLimit *limit;
@end

@implementation XWMoneyTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self.limit;
        [self addTarget:self.limit
                 action:@selector(valueChange:)
       forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self.limit;
        [self addTarget:self.limit
                 action:@selector(valueChange:)
       forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

// 禁止 粘贴、剪切、选择、选择全部
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
////禁止粘贴
//if (action == @selector(paste:)){
//return NO;
//}
//if (action == @selector(cut:)) {
//return NO;
//}
//    if (action == @selector(copy:)) {
//        return NO;
//    }
//    if (action == @selector(select:)) {
//        return NO;
//    }
//    if (action == @selector(selectAll:)) {
//        return NO;
//    }
//    
//    return [super canPerformAction:action withSender:sender];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    //expand the clickable area
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, _expendDx, _expendDy);
    return CGRectContainsPoint(bounds, point);
}

#pragma mark - Getter
- (XWMoneyTextFieldLimit *)limit{
    if (!_limit) {
        _limit = [[XWMoneyTextFieldLimit alloc] init];
    }
    return _limit;
}


@end
