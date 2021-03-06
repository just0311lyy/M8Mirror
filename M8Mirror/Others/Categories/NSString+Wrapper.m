//
//  NSString+Wrapper.m
//  AduroSmart
//
//  Created by MacBook on 16/7/7.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "NSString+Wrapper.h"
#import <CommonCrypto/CommonDigest.h>
#define JavaNotFound  (-1)

@implementation NSString (Wrapper)

- (NSUInteger)indexOfString:(NSString*)str{
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound) {
        return JavaNotFound; //不包含该字段  return -1；
    }
    return range.location;  //包含该字段 return 该字段首字母所在位置
}

//为字符串拼接一个字符串
+(NSString *)changeGroupName:(NSString *)groupName withTypeId:(NSString *)typeId{
    NSString *newName = [groupName stringByAppendingString:@"-"];
    newName = [newName stringByAppendingString:typeId];
    return newName;
}

////将字符串还原
//+(NSString *)returnTheGroupName:(NSString *)groupName{
//    
//    
//    
//}

//将数组转换为字符串(中间为“，”)
//(void)stringWithArray:(NSArray *)array{
//    NSString *detailStr = @"";
//    if (array.count > 0) {
//        for (int i = 0; i < array.count; i++) {
//            detailStr = [detailStr stringByAppendingFormat:@",%@",array[i]];
//        }
//    }
//}

+(NSString *)changeWithOldName:(NSString *)oldName{
    NSArray *array = [oldName componentsSeparatedByString:@","];
    NSMutableString *newString = [[NSMutableString alloc] initWithString:@""];
    if (array.count>0) {
        for (int i=0; i<array.count; i++) {
            NSString *oldFlag = [array objectAtIndex:i];
            if ([oldFlag isEqualToString:@"00"]) {
                [newString appendString:@" 补水类"];
            }
            if ([oldFlag isEqualToString:@"01"]) {
                [newString appendString:@" 淡斑类"];
            }
            if ([oldFlag isEqualToString:@"02"]) {
                [newString appendString:@" 清洁类"];
            }
            if ([oldFlag isEqualToString:@"03"]) {
                [newString appendString:@" 嫩肤类"];
            }
            if ([oldFlag isEqualToString:@"04"]) {
                [newString appendString:@" 抗衰老"];
            }
            if ([oldFlag isEqualToString:@"05"]) {
                [newString appendString:@" 修复类"];
            }
            if ([oldFlag isEqualToString:@"06"]) {
                [newString appendString:@" 保养类"];
            }
            
        }
    }
    return newString;
}

//小写
- (NSString*)md532BitLower
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
//大写
- (NSString*)md532BitUpper
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+(NSString *)base64StringWithImage:(UIImage *)image{
    NSData *data = UIImagePNGRepresentation(image);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

+(CGFloat)calculateRowHeightWithString:(NSString *)string andWidth:(CGFloat)width fontSize:(NSInteger)fontSize{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:style};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}

+(CGFloat)calculateRowWidthWithString:(NSString *)string andHeight:(CGFloat)height fontSize:(NSInteger)fontSize{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,height)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}


#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber{
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *pattern = @"^1+[3578]+\\d{9}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:telNumber];
    NSString *phoneRegex =@"^1[3|4|5|6|7|8|9][0-9]{1}[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch = [phoneTest evaluateWithObject:telNumber];
    return isMatch;
}

//邮箱
+(BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

////验证非0的正整数
//+ (BOOL)checkFiveNumber:(NSString *)strNumber{
//    NSString *pattern = @"^\+?[1-9][0-9]*$";
//    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    //    BOOL isMatch = [pred evaluateWithObject:telNumber];
////    NSString *phoneRegex =@"^1[3|4|5|6|7|8|9][0-9]{1}[0-9]{8}$";
//    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
//    BOOL isMatch = [test evaluateWithObject:pattern];
//    return isMatch;
//}

- (CGSize)boundingRectWithSize:(CGSize)size fontOfLabel:(UIFont *)font
{
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
                              context:nil].size;
}

- (CGSize)boundingRectWithFont:(UIFont *)font
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
                              context:nil].size;
}

+ (NSString *)timeFormatTextWithSecond:(NSInteger)second
{
    NSInteger hourNumber = second/3600;
    NSInteger minuteNumber = (second - hourNumber*3600) /60;
    NSInteger secondNumber = second % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hourNumber,(long)minuteNumber,(long)secondNumber];
}

+ (NSString *)dayDateForTime:(NSString*)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:time];
    [dateFormatter setDateFormat:@"dd"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)monthDateForTime:(NSString*)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:time];
    [dateFormatter setDateFormat:@"MM"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getSerializationStrWithArray:(NSArray *)array
{
    NSArray *pois = [array copy];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:pois
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        jsonString = @"";
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSArray *)getArrayFromSerializationStr
{
    NSData *data =[self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

- (BOOL)isMobileNumber
{
    //    NSString *MOBILE = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSString *MOBILE = @"^1[2|3|4|5|6|7|8|9][0-9]\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject: self];
}

- (BOOL)isLetterNumber
{
    NSString *Letter = @"^[A-Za-z0-9]+$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Letter];
    return [regextestmobile evaluateWithObject: self];
}


- (BOOL)isNumber
{
    NSString *Letter = @"^[0-9]*$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Letter];
    return [regextestmobile evaluateWithObject: self];
}

// 数字 -
- (BOOL)isNumberRail
{
    NSString *Letter = @"^[0-9,-]*$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Letter];
    return [regextestmobile evaluateWithObject: self];
}

- (NSString *)getPhoneNumber
{
    if (self == nil || [self isEqual:[NSNull null]]) {
        return nil;
    }
    
    BOOL isHaveNumber = NO;
    
    NSString *noneSpace = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    for (int i = 0; i < noneSpace.length; i++) {
        NSString *str = [noneSpace substringWithRange:NSMakeRange(i, 1)];
        
        if ([str isNumberRail]) {
            isHaveNumber = YES;
        }
        
        if (isHaveNumber) {
            
            if (![str isNumberRail]) {
                
                return [[noneSpace substringWithRange:NSMakeRange(0, i)] getNumber];
            }
        }
    }
    
    return [noneSpace getNumber];
}

- (NSString *)getNumber
{
    NSMutableString *mutableStr = [NSMutableString string];
    for (int i = 0; i < self.length; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        if ([str isNumber]) {
            [mutableStr appendString:str];
        }
    }
    
    return mutableStr;
}

-(NSString *)numberSuitScanf
{
    if ([self isMobileNumber]) {
        
        NSString *numberString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return numberString;
    }
    return self;
}

+ (NSString *)countNumberForComment:(NSString*)count
{
    NSInteger countNumber = [count integerValue];
    
    if (countNumber < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)countNumber];
    } else if (countNumber >= 999500) {
        
        return @"999k+";
    } else {
        
        return [NSString stringWithFormat:@"%.0fk",countNumber/1000.0];
    }
}

+ (NSString *)getCountWithDecimalPoint:(CGFloat)count
{
    if (fmodf(count, 1)==0) {
        return [NSString stringWithFormat:@"%.0f",count];
    } else if (fmodf(count*10, 1)==0) {
        return [NSString stringWithFormat:@"%.1f",count];
    } else {
        return [NSString stringWithFormat:@"%.2f",count];
    }
}
@end
