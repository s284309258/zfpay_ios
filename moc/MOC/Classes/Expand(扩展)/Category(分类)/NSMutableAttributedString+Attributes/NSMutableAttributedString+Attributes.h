//
//  NSMutableAttributedString+Helper.h
//  DossierPolice
//
//  Created by Dmitry Shmidt on 7/26/13.
//  Copyright (c) 2013 Shmidt Lab. All rights reserved.
//

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
typedef NSFont UIFont;
typedef NSColor UIColor;
#endif


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,VZAttributedInsertType) {
    VZAttributedInsertTypeFirst,
    VZAttributedInsertTypeLast
};

@interface NSMutableAttributedString (Attributes)
- (void)addColor:(UIColor *)color substring:(NSString *)substring;
- (void)addBackgroundColor:(UIColor *)color substring:(NSString *)substring;
- (void)addUnderlineForSubstring:(NSString *)substring;
- (void)addStrikeThrough:(int)thickness substring:(NSString *)substring;
- (void)addShadowColor:(UIColor *)color width:(int)width height:(int)height radius:(int)radius substring:(NSString *)substring;
- (void)addFontWithName:(NSString *)fontName size:(int)fontSize substring:(NSString *)substring;
- (void)addFont:(UIFont *)font substring:(NSString *)substring;
- (void)addAlignment:(NSTextAlignment)alignment substring:(NSString *)substring;
- (void)addColorToRussianText:(UIColor *)color;
- (void)addStrokeColor:(UIColor *)color thickness:(int)thickness substring:(NSString *)substring;
- (void)addVerticalGlyph:(BOOL)glyph substring:(NSString *)substring;
- (void)addBaselineOffset:(CGFloat)offset substring:(NSString *)substring;
///1.设置某一行的行间距需要传入前面那一行的字符串，比如要修改第二行和第三行的间距那么请传第二行的文本 2.传如整个文本则会设置所有行的行间距
- (void)setLineSpacing:(CGFloat)lineSpacing substring:(NSString *)substring alignment:(NSTextAlignment)alignment;
///两端添加图片
- (void)addImage:(NSString *)leftImgName rightImage:(NSString *)rightImgName leftBound:(CGRect)leftBound rightBound:(CGRect)rightBound;
///文本最前面插入图片

- (void)addImageInHead:(NSString *)imgName bound:(CGRect)bound;
///文本最后面插入图片
- (void)addImageNameInTail:(NSString *)imgName bound:(CGRect)bound;
- (void)addImageInTail:(UIImage *)image bound:(CGRect)bound;

///文本最前面或最后面插入图片
- (instancetype)initWithImageName:(NSString *)imageName andStringWithContentString:(NSString *)contentString andWithAttributedInsertType:(VZAttributedInsertType)type bound:(CGRect)bound;
///文本最前面插入图片
+ (instancetype)attributedWithImageName:(NSString *)imageName andStringWithContentString:(NSString *)contentString bound:(CGRect)bound;

///通过传入的字符数组以及对应的属性数组生成属性字符串
+ (NSMutableAttributedString *)initWithTitles:(NSArray *)titlesArr colors:(NSArray *)colorsArr fonts:(NSArray *)fontsArr;

+ (NSMutableAttributedString *)initWithTitles:(NSArray *)titlesArr colors:(NSArray *)colorsArr fonts:(NSArray *)fontsArr placeHolder:(NSString *)placeHolder;
@end

@interface NSString (Russian)
- (BOOL)hasRussianCharacters;
- (BOOL)hasEnglishCharacters;
@end
