//
//  CountryModel.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/7/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel
+ (NSMutableArray *)getCountryModelData{
    NSMutableArray *countryAry = [NSMutableArray new];
    CountryModel *country01 = [[CountryModel alloc] init];
    country01.imageName = @"country_China.png";
    country01.countryName = @"简体中文";
    
    CountryModel *country02 = [[CountryModel alloc] init];
    country02.imageName = @"country_England.png";
    country02.countryName = @"English";
    
    [countryAry addObjectsFromArray:@[country01,country02]];
    return countryAry;
}
@end
