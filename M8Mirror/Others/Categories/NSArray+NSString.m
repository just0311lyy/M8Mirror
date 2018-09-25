//
//  NSArray+NSString.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/7/3.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "NSArray+NSString.h"

@implementation NSArray (NSString)
//将属性00,01……等转换为中文数组
+(NSArray *)arrayWithAttrString:(NSString *)string{
    NSArray *array = [string componentsSeparatedByString:@","];
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:8];
    if (array.count>0) {
        for (int i=0; i<array.count; i++) {
            NSString *oldFlag = [array objectAtIndex:i];
            if ([oldFlag isEqualToString:@"00"]) {
                [newArray addObject:@"补水类"];
            }
            if ([oldFlag isEqualToString:@"01"]) {
                [newArray addObject:@"淡斑类"];
            }
            if ([oldFlag isEqualToString:@"02"]) {
                [newArray addObject:@"清洁类"];
            }
            if ([oldFlag isEqualToString:@"03"]) {
                [newArray addObject:@"嫩肤类"];
            }
            if ([oldFlag isEqualToString:@"04"]) {
                [newArray addObject:@"抗衰老"];
            }
            if ([oldFlag isEqualToString:@"05"]) {
                [newArray addObject:@"修复类"];
            }
            if ([oldFlag isEqualToString:@"06"]) {
                [newArray addObject:@"保养类"];
            }
        }
    }
    return newArray;
}

@end
