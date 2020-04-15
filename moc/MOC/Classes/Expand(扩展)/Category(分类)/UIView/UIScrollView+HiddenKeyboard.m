
//
//  UIScrollView+HiddenKeyboard.m
//  MoPromo_Develop
//
//  Created by fly on 15/12/29.
//  Copyright © 2015年 MoPromo. All rights reserved.
//

#import "UIScrollView+HiddenKeyboard.h"
#import <objc/runtime.h>

#define ADD_DYNAMIC_PROPERTY(PROPERTY_TYPE,PROPERTY_NAME,SETTER_NAME,POLICY) \
@dynamic PROPERTY_NAME ; \
static char kProperty##PROPERTY_NAME; \
- ( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
return ( PROPERTY_TYPE ) objc_getAssociatedObject(self, &(kProperty##PROPERTY_NAME ) ); \
} \
\
- (void) SETTER_NAME :( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
objc_setAssociatedObject(self, &kProperty##PROPERTY_NAME , PROPERTY_NAME , POLICY); \
} \


@implementation UIScrollView (HiddenKeyboard)

ADD_DYNAMIC_PROPERTY(UITapGestureRecognizer *, hiddenTap, setHiddenTap,OBJC_ASSOCIATION_RETAIN);
ADD_DYNAMIC_PROPERTY(NSNumber *, isNoticeOberver, setIsNoticeOberver,OBJC_ASSOCIATION_RETAIN
                     );

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNoticeOberver = @(NO);
    }
    return self;
}

- (void)addHiddenKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addHiddenKeyboardGesture) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeHiddenKeyboardGesture) name:UIKeyboardWillHideNotification object:nil];
    self.isNoticeOberver = @(YES);
}

- (void)removeHiddenKeyboardNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    self.isNoticeOberver = @(NO);
    if (self.hiddenTap) {
        [self removeHiddenKeyboardGesture];
    }
}

- (void)removeHiddenKeyboardGesture{
    if (self.hiddenTap) {
        [self removeGestureRecognizer:self.hiddenTap];
        self.hiddenTap = nil;
    }
}

- (void)addHiddenKeyboardGesture{
    if (self.hiddenTap) {
        return;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboardAction:)];
    [self addGestureRecognizer:tap];
    
    self.hiddenTap = tap;
}


- (void)hiddenKeyboardAction:(UIGestureRecognizer*)gesture{
    [self endEditing:YES];
}

@end
