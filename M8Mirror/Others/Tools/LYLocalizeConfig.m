//
//  LYLocalizeConfig.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/8/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LYLocalizeConfig.h"
#import "NSString+Wrapper.h"

NSString  *languageIdStr;

@implementation LYLocalizeConfig
//语言本地化
+(NSString *)localizedString:(NSString *)localizedStrKey{
    NSString *localizedStr = NSLocalizedString(localizedStrKey, nil);  //NSLocalizedString(内容，对内容的注释)
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:languageIdStr ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:resourcePath];
    localizedStr = [languageBundle localizedStringForKey:localizedStrKey value:@"" table:nil];
    return localizedStr;
}

//语言初始化判断
+(void)initializeLanguageIdentifierString{
    languageIdStr = [[NSString alloc] init];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    languageIdStr = [ud objectForKey:LY_LANGUAGE_IDENTIFIER];
    // 如果没有语言标签缓存，则调用当前语言
    if ([languageIdStr length] == 0 || [languageIdStr isEqualToString:@""] || languageIdStr == nil) {
        languageIdStr = CURRENT_LANGUAGE;
    }
    NSLog(@"languageIdentifierString1 = %@",languageIdStr);
    //
    if ([languageIdStr indexOfString:@"en"] != -1) {
        //包含“en”
    }
    NSLog(@"languageIdentifierString2 = %@",languageIdStr);
    
    if ([languageIdStr indexOfString:@"zh"] != -1) {
        //包含“zh”，则令：
        languageIdStr = @"zh-Hans";
    }else{ //不包含“zh”，则令：
        languageIdStr = @"en";
    }
    NSLog(@"languageIdentifierString3 = %@",languageIdStr);
}
@end
