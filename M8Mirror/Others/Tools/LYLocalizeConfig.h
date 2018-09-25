//
//  LYLocalizeConfig.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/8/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

//设置语言函名标签
#define LY_LANGUAGE_IDENTIFIER @"LY_languageIdentifierString"
//当前系统的语言种类：
#define CURRENT_LANGUAGE  ([[NSLocale preferredLanguages] objectAtIndex:0])

@interface LYLocalizeConfig : NSObject

//语言本地化
+(NSString *)localizedString:(NSString *)localizedStrKey;
//语言初始化判断
+(void)initializeLanguageIdentifierString;

@end
