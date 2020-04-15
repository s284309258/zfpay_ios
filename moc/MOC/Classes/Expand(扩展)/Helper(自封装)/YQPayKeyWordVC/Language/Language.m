//
//  Language.h
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 AlphaGo. All rights reserved.d.
//

#import "Language.h"

@implementation Language

static NSBundle *bundle = nil;

static NSArray *langeArray = nil;

NSString *const LanguageCodeIdIndentifier = @"LanguageCodeIdIndentifier";

+ (void)initialize {
    langeArray = @[@"zh-Hans",@"en",@"fr",@"ru",@"en"];
    NSString *path = [[NSBundle mainBundle] pathForResource:[self currentLanguageCode] ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
}

+ (NSString *)type:(LanguageType)language {
    return [langeArray objectAtIndex:language];
    
//    NSString *lan = nil;
//    if(language == LanguageTypeEnglish) {
//        lan = @"en";
//    } else if(language == LanguageTypeVietnam) {
//        lan = @"vi";
//    } else if(language == LanguageTypeIndonesia) {
//        lan = @"id";
//    } else if(language == LanguageTypeKorea) {
//        lan = @"ko";
//    } else {
//        lan = @"zh-Hans";
//    }
//    return lan;
}
+ (NSString*)currentLanguageName{
    LanguageType lan = [self.class currentLanguageType];
    NSString* lang = @"";
    if(lan == LanguageTypeEnglish) {
        lang = @"English";
    } else if(lan == LanguageTypeFrench) {
        lang = @"Le français";
    } else if(lan == LanguageTypeRussian) {
        lang = @"Русский язык";
    }  else if(lan == LanguageTypeCanada) {
        lang = @"English";
    }  else {
        lang = @"中文";
    }
    return lang;
}

+ (void)setLanguage:(LanguageType)language {
    NSString *path = [[NSBundle mainBundle] pathForResource:[langeArray objectAtIndex:language] ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    [self saveUserSelectedLanguage:language];
    [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangedNotification object:nil];
}

+ (LanguageType)currentLanguageType {
    return LanguageTypeChinese;
    return [[[NSUserDefaults standardUserDefaults] objectForKey:LanguageCodeIdIndentifier] integerValue];
}

+ (NSString *)currentLanguageCode {
    NSNumber *userSelectedLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageCodeIdIndentifier];
    if (userSelectedLanguage) {
        // Store selected language in local
        return [self type:[userSelectedLanguage integerValue]];
    }
    
    LanguageType type = LanguageTypeChinese;
    NSString *systemLanguage = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    //系统语言是中文、英文、越南三种则按照系统语言，否则采用中文
    if ([systemLanguage isEqualToString:@"zh-Hans"]) {
        type = LanguageTypeChinese;
    } else if ([systemLanguage isEqualToString:@"en"]) {
        type = LanguageTypeEnglish;
    } else if([systemLanguage isEqualToString:@"fr"]) {
        type = LanguageTypeFrench;
    } else if([systemLanguage isEqualToString:@"ru"]) {
        type = LanguageTypeRussian;
    } else if([systemLanguage isEqualToString:@"en"]) {
        type = LanguageTypeCanada;
    }  else { //默认中文
        systemLanguage = @"zh-Hans";
    }
    [self saveUserSelectedLanguage:type];
    return systemLanguage;
}

+ (void)saveUserSelectedLanguage:(LanguageType)selectedLanguage {
    [[NSUserDefaults standardUserDefaults] setObject:@(selectedLanguage) forKey:LanguageCodeIdIndentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getValue:(NSString *)key value:(NSString *)value {
    return [bundle localizedStringForKey:key value:value table:nil];
}

@end
