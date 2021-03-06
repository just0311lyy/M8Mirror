//
//  NSString+Wrapper.h
//  AduroSmart
//
//  Created by MacBook on 16/7/7.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Wrapper)

- (NSUInteger)indexOfString:(NSString*)str;

//为字符串拼接一个字符串
+(NSString *)changeGroupName:(NSString *)groupName withTypeId:(NSString *)typeId;
//将字符串还原
//+(NSString *)groupNameReturn;

+(NSString *)changeWithOldName:(NSString *)oldName;

//MD5小写加密
- (NSString*)md532BitLower;
//MD5大写加密
- (NSString*)md532BitUpper;

+(NSString *)base64StringWithImage:(UIImage *)image;

//根据字符串内容和宽度，计算高 calculate：计算
+(CGFloat)calculateRowHeightWithString:(NSString *)string andWidth:(CGFloat)width fontSize:(NSInteger)fontSize;
//根据字符串内容和高度，计算宽
+(CGFloat)calculateRowWidthWithString:(NSString *)string andHeight:(CGFloat)height fontSize:(NSInteger)fontSize;


//手机号验证
+(BOOL)checkTelNumber:(NSString *) telNumber;
//邮箱
+(BOOL)validateEmail:(NSString *)email;

- (CGSize)boundingRectWithSize:(CGSize)size fontOfLabel:(UIFont *)font;

- (CGSize)boundingRectWithFont:(UIFont *)font;

+ (NSString *)timeFormatTextWithSecond:(NSInteger)second;
+ (NSString *)getSerializationStrWithArray:(NSArray *)array;

+ (NSString *)dayDateForTime:(NSString*)time;

+ (NSString *)monthDateForTime:(NSString*)time;

+ (NSString *)getCountWithDecimalPoint:(CGFloat)count;

- (NSArray *)getArrayFromSerializationStr;

/**
 校验手机号
 */
- (BOOL)isMobileNumber;

/**
 校验数字和字母
 */
- (BOOL)isLetterNumber;

/**
 提取电话号码
 */
- (NSString *)getPhoneNumber;

/**
 电话号码加****
 */
-(NSString *)numberSuitScanf;

- (BOOL)isNumberRail;
@end
