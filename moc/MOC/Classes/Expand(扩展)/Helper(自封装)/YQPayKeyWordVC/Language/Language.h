//
//  Language.h
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LanguageChangedNotification @"LanguageChangedNotification"

#define Lang(key) [Language getValue:key value:nil]

@protocol LanguageDelegate <NSObject>
@required // 必须实现的方法
-(void)updateForLanguageChanged;
@end


typedef NS_ENUM(NSInteger,LanguageType) {
    LanguageTypeChinese,
    LanguageTypeEnglish,
    LanguageTypeFrench,
    LanguageTypeRussian,
    LanguageTypeCanada,
};

@interface Language : NSObject

+ (void)initialize;
+ (void)setLanguage:(LanguageType)language;
+ (LanguageType)currentLanguageType;
+ (NSString*)currentLanguageName;
+ (void)saveUserSelectedLanguage:(LanguageType)selectedLanguage;
+ (NSString *)getValue:(NSString *)key value:(NSString *)value;

@end
