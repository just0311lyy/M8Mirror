//
//  CountryModel.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/7/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryModel : NSObject
@property (nonatomic ,strong) NSString *imageName;
@property (nonatomic ,strong) NSString *countryName;

+ (NSMutableArray *)getCountryModelData;
@end
