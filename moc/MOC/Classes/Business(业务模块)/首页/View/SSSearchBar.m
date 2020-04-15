//
//  SSSearchBar.m
//  Demo
//
//  Created by xk jiang on 2017/10/10.
//  Copyright © 2017年 xk jiang. All rights reserved.
//

#import "SSSearchBar.h"
#import "UIImage+Tool.h"

// icon宽度
static CGFloat const searchIconW = 20.0;
// icon与placeholder间距
static CGFloat const iconSpacing = 10.0;
// 占位文字的字体大小
static CGFloat const placeHolderFont = 15.0;

@interface SSSearchBar ()<UITextFieldDelegate>
// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;
@end
@implementation SSSearchBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#define HEXCOLOR(rgbValue)                                                                                             \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
alpha:1.0]
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索";
        self.keyboardType = UIKeyboardTypeDefault;
        self.backgroundColor = [UIColor clearColor];

        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSearchFieldBackgroundImage:[self.class getImageWithColor:[UIColor colorWithHexString:@"#F0F0F0"] andHeight:30] forState:UIControlStateNormal];
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 6;
        
        self.searchBarStyle = UISearchBarStyleMinimal;
    }
    return self;
}

//- (void)didAddSubview:(UIView *)subview {
//    [super didAddSubview:subview];
//    [self becomeFirstResponder];
//}

- (UITextField *)findTextField:(UIView *)superView {
    for(UIView *view in superView.subviews) {
        NSLog(@"findTextField: %@",[view class]);
        if([view isKindOfClass:[UITextField class]]) {
            return (UITextField *)view;
        } else {
            UIView *findView = [self findTextField:view];
            if([findView isKindOfClass:[UITextField class]]) {
                return (UITextField *)findView;
            }
        }
    }
    return nil;
}
    

-(void)layoutSubviews{
    [super layoutSubviews];

    NSArray *subviewArr = self.subviews;
    CGFloat top = 4;
    CGFloat bottom = top;
    CGFloat left = 0;
    CGFloat right = left;
    UIEdgeInsets _insets = UIEdgeInsetsMake(top, left, bottom, right);
    
    UITextField *_searchField = [self findTextField:self];
    
    if([_searchField isKindOfClass:[UITextField class]]) {
//        CGRect frame = _searchField.frame;
//        CGFloat offsetX = frame.origin.x - _insets.left;
//        CGFloat offsetY = frame.origin.y - _insets.top;
//        frame.origin.x = _insets.left;
//        frame.origin.y = _insets.top;
//        frame.size.height += offsetY * 2;
//        frame.size.width += offsetX * 2;
//        _searchField.frame = frame;
//        _searchField.backgroundColor = [UIColor whiteColor];
        _searchField.font = [UIFont font15];
        _searchField.delegate = self;
        if (@available(iOS 11.0, *)) {
            if(self.positionType == PlaceHolderPositionType_Manual) {
                return;
            }
            // 先默认居中placeholder
            [self setPositionAdjustment:UIOffsetMake((self.frame.size.width-30-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
    }
}

// 计算placeholder、icon、icon和placeholder间距的总宽度
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:placeHolderFont]} context:nil].size;
        _placeholderWidth = size.width + iconSpacing + searchIconW;
    }
    return _placeholderWidth;
}

// 开始编辑的时候重置为靠左
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(self.positionType == PlaceHolderPositionType_Manual) {
        return YES;
    }
    // 继续传递代理方法
//    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
//        [self.delegate searchBarShouldBeginEditing:self];
//    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
// 结束编辑的时候设置为居中
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if(self.positionType == PlaceHolderPositionType_Manual) {
        return YES;
    }
//    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
//        [self.delegate searchBarShouldEndEditing:self];
//    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}

+ (UIImage *)getImageWithColor:(UIColor *)color andHeight:(CGFloat)height {
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
