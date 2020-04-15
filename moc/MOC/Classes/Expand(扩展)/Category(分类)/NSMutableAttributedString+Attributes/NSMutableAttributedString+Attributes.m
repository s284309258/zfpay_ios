//
//  NSMutableAttributedString+Helper.m
//  DossierPolice
//
//  Created by Dmitry Shmidt on 7/26/13.
//  Copyright (c) 2013 Shmidt Lab. All rights reserved.
//
#import "NSMutableAttributedString+Attributes.h"
@interface NSString(MASAttributes)
-(NSRange)rangeOfStringNoCase:(NSString*)s;
@end

@implementation NSString(MASAttributes)
-(NSRange)rangeOfStringNoCase:(NSString*)s
{
    return  [self rangeOfString:s options:NSCaseInsensitiveSearch];
}
@end
@implementation NSMutableAttributedString (Attributes)
- (void)addColor:(UIColor *)color substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:range];
    }
}
- (void)addBackgroundColor:(UIColor *)color substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSBackgroundColorAttributeName
                     value:color
                     range:range];
    }
}
- (void)addUnderlineForSubstring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute: NSUnderlineStyleAttributeName
                     value:@(NSUnderlineStyleSingle)
                     range:range];
    }
}
- (void)addStrikeThrough:(int)thickness substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute: NSStrikethroughStyleAttributeName
                     value:@(thickness)
                     range:range];
    }
}
- (void)addShadowColor:(UIColor *)color width:(int)width height:(int)height radius:(int)radius substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowColor:color];
        [shadow setShadowOffset:CGSizeMake (width, height)];
        [shadow setShadowBlurRadius:radius];
        
        [self addAttribute: NSShadowAttributeName
                     value:shadow
                     range:range];
    }
}
- (void)addFontWithName:(NSString *)fontName size:(int)fontSize substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && fontName != nil) {
        UIFont * font = [UIFont fontWithName:fontName size:fontSize];
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}
- (void)addFont:(UIFont *)font substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && font != nil) {
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}
- (void)addAlignment:(NSTextAlignment)alignment substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        NSMutableParagraphStyle* style=[[NSMutableParagraphStyle alloc]init];
        style.alignment = alignment;
        [self addAttribute: NSParagraphStyleAttributeName
                     value:style
                     range:range];
    }
}
- (void)addColorToRussianText:(UIColor *)color{
    
    if(color == nil) return;
    
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"];
    
    NSRange searchRange = NSMakeRange(0,self.string.length);
    NSRange foundRange;
    while (searchRange.location < self.string.length) {
        searchRange.length = self.string.length-searchRange.location;
        foundRange = [self.string rangeOfCharacterFromSet:set options:NSCaseInsensitiveSearch range:searchRange];
        if (foundRange.location != NSNotFound) {
            [self addAttribute:NSForegroundColorAttributeName
                         value:color
                         range:foundRange];
            
            searchRange.location = foundRange.location+1;
            
        } else {
            // no more substring to find
            break;
        }
    }
}
- (void)addStrokeColor:(UIColor *)color thickness:(int)thickness substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSStrokeColorAttributeName
                     value:color
                     range:range];
        [self addAttribute:NSStrokeWidthAttributeName
                     value:@(thickness)
                     range:range];
    }
}
- (void)addVerticalGlyph:(BOOL)glyph substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute:NSForegroundColorAttributeName
                     value:@(glyph)
                     range:range];
    }
}

- (void)addBaselineOffset:(CGFloat)offset substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute:NSBaselineOffsetAttributeName
                     value:@(offset)
                     range:range];
    }
}

- (void)setLineSpacing:(CGFloat)lineSpacing substring:(NSString *)substring alignment:(NSTextAlignment)alignment {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //[paragraphStyle setLineSpacing:lineSpacing];
    paragraphStyle.paragraphSpacing = lineSpacing;
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    NSRange range = [self.string rangeOfStringNoCase:substring];
    paragraphStyle.alignment = alignment;
    if (range.location != NSNotFound) {
        //[self addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:range];
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
}

///两端添加图片
- (void)addImage:(NSString *)leftImgName rightImage:(NSString *)rightImgName leftBound:(CGRect)leftBound rightBound:(CGRect)rightBound {
    NSTextAttachment *leftAttachment = [[NSTextAttachment alloc] init];
    leftAttachment.image = [UIImage imageNamed:leftImgName];
    leftAttachment.bounds = leftBound;
    
    NSTextAttachment *rightAttachment = [[NSTextAttachment alloc] init];
    rightAttachment.image = [UIImage imageNamed:rightImgName];
    rightAttachment.bounds = rightBound;
    NSAttributedString *leftAttString = [NSAttributedString attributedStringWithAttachment:leftAttachment];
    NSAttributedString *righAttString = [NSAttributedString attributedStringWithAttachment:rightAttachment];
    [self insertAttributedString:leftAttString atIndex:0];
    [self insertAttributedString:righAttString atIndex:self.length];
}

///头部添加图片
- (void)addImageInHead:(NSString *)imgName bound:(CGRect)bound {
    NSTextAttachment *leftAttachment = [[NSTextAttachment alloc] init];
    leftAttachment.image = [UIImage imageNamed:imgName];
    leftAttachment.bounds = bound;

    NSAttributedString *leftAttString = [NSAttributedString attributedStringWithAttachment:leftAttachment];
    [self insertAttributedString:leftAttString atIndex:0];
}

///尾部添加图片
- (void)addImageNameInTail:(NSString *)imgName bound:(CGRect)bound {
    NSTextAttachment *tailAttachment = [[NSTextAttachment alloc] init];
    tailAttachment.image = [UIImage imageNamed:imgName];
    tailAttachment.bounds = bound;
    
    NSAttributedString *tailAttString = [NSAttributedString attributedStringWithAttachment:tailAttachment];
    [self insertAttributedString:tailAttString atIndex:self.length];
}

///尾部添加图片
- (void)addImageInTail:(UIImage *)image bound:(CGRect)bound {
    NSTextAttachment *tailAttachment = [[NSTextAttachment alloc] init];
    tailAttachment.image = image;
    tailAttachment.bounds = bound;
    
    NSAttributedString *tailAttString = [NSAttributedString attributedStringWithAttachment:tailAttachment];
    [self insertAttributedString:tailAttString atIndex:self.length];
}


///文本插入图片
- (instancetype)initWithImageName:(NSString *)imageName andStringWithContentString:(NSString *)contentString andWithAttributedInsertType:(VZAttributedInsertType)type bound:(CGRect)bound {
    //根据附件生成富文本
    self = [[NSMutableAttributedString alloc] initWithString:contentString];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:imageName];
    //设置（图片）字体大小
    //CGFloat attachmentH = label.font.lineHeight;
//    CGFloat y = 0;
//    if(attachmentH > attachment.image.size.height) {
//        y = (attachmentH - attachment.image.size.height)/2;
//    } else {
//        y = -(attachment.image.size.height - attachmentH);
//    }
    attachment.bounds = bound;//CGRectMake(0, attachment.image.size.height/2, attachment.image.size.width, attachment.image.size.height);
    
    NSAttributedString *attString = [NSAttributedString attributedStringWithAttachment:attachment];
    if (type == VZAttributedInsertTypeFirst) {
        [self insertAttributedString:attString atIndex:0];
    } else {
        [self insertAttributedString:attString atIndex:contentString.length];
    }
    
    return self;
}
///文本最前面插入图片
+ (instancetype)attributedWithImageName:(NSString *)imageName andStringWithContentString:(NSString *)contentString bound:(CGRect)bound {
    return [[self alloc] initWithImageName:imageName andStringWithContentString:contentString andWithAttributedInsertType: VZAttributedInsertTypeFirst bound:bound];
}
///发送图片
- (instancetype)initWithImg:(UIImage *)image {
    //根据附件生成富文本
    self = [[NSMutableAttributedString alloc] init];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    //设置（图片）字体大小
    NSAttributedString *attString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    [self insertAttributedString:attString atIndex:0];
    return self;
}

+ (NSMutableAttributedString *)initWithTitles:(NSArray *)titlesArr colors:(NSArray *)colorsArr fonts:(NSArray *)fontsArr {
    if(titlesArr.count != colorsArr.count || titlesArr.count != fontsArr.count || colorsArr.count != fontsArr.count) {
        return nil;
    }
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[titlesArr componentsJoinedByString:@""]];
    [titlesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attString addColor:[colorsArr objectAtIndex:idx] substring:obj];
        [attString addFont:[fontsArr objectAtIndex:idx] substring:obj];
    }];
    return attString;
}

+ (NSMutableAttributedString *)initWithTitles:(NSArray *)titlesArr colors:(NSArray *)colorsArr fonts:(NSArray *)fontsArr placeHolder:(NSString *)placeHolder {
    if(titlesArr.count != colorsArr.count || titlesArr.count != fontsArr.count || colorsArr.count != fontsArr.count) {
        return nil;
    }
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[titlesArr componentsJoinedByString:placeHolder]];
    [titlesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attString addColor:[colorsArr objectAtIndex:idx] substring:obj];
        [attString addFont:[fontsArr objectAtIndex:idx] substring:obj];
    }];
    return attString;
}
@end

@implementation NSString (Russian)
- (BOOL)hasRussianCharacters{
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"];
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}
- (BOOL)hasEnglishCharacters{
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}
@end
