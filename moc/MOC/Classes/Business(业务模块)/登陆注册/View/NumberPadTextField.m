//
//  NumberPadTextField.m
//  MoRadioFilterDemo
//
//  Created by fly on 16/1/9.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "NumberPadTextField.h"

@interface NumberPadTextField () <UITextFieldDelegate>

@property(nullable, nonatomic, weak) id<UITextFieldDelegate>
    swapDelegate;

@end

@implementation NumberPadTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.delegate = self;
    self.maxInputLength = 20;
    self.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark - Reset

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))//禁止粘贴
        return NO;
//    if (action == @selector(select:))// 禁止选择
//        return NO;
//    if (action == @selector(selectAll:))// 禁止全选
//        return NO;
    return [super canPerformAction:action withSender:sender];
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate{
    [super setDelegate:self];
    if (delegate != self) {
        self.swapDelegate = delegate;
    }
//    NSAssert(delegate == self, @"delegate 方法设置错误，外面不要设置delegate");
}

- (void)setSpecialCharacters:(NSSet *)specialCharacters{
    _specialCharacters = specialCharacters;
    for (id specialObj in specialCharacters) {
        NSAssert([specialObj isKindOfClass:[NSString class]], @"必须是字符串类型");
    }
}

#pragma mark - TextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_swapDelegate && [_swapDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_swapDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_swapDelegate && [_swapDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
         [_swapDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (_swapDelegate && [_swapDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_swapDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_swapDelegate && [_swapDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_swapDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
    if (range.length > 0) {
        if (_swapDelegate && [_swapDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            return [_swapDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
        }
        return YES;
    }
    BOOL isIntType = [self isPureInt:string];
    BOOL isAllowedCharacter = NO;
    if (self.specialCharacters) {
        isAllowedCharacter = [self.specialCharacters containsObject:string];
    }
    BOOL ismaxInputLength = ([textField.text length] < self.maxInputLength);
    BOOL isValidNumber = ((isIntType || isAllowedCharacter) && ismaxInputLength);
    if (isValidNumber) {
        if (_swapDelegate && [_swapDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            BOOL result = [_swapDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
            return (isValidNumber && result);
        }
    }
    return isValidNumber;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (_swapDelegate && [_swapDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [_swapDelegate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_swapDelegate && [_swapDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [_swapDelegate textFieldShouldReturn:textField];
    }
    return YES;
}


//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//this is must
-(BOOL) respondsToSelector:(SEL)aSelector {
    
    NSString * selectorName = NSStringFromSelector(aSelector);
    NSString * overlayName = [NSString stringWithFormat:@"%@%@%@",@"custom",@"Overlay",@"Container"];
    if ([selectorName isEqualToString:overlayName]) {
        
        return NO;
    }
    return [super respondsToSelector:aSelector];
}

@end
