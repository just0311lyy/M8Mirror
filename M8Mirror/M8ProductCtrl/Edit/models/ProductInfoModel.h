//
//  ProductInfoModel.h
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/5.
//  Copyright © 2019 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ProductInfoType) {
    ProductInfoTypeName = 0,        //产品名称
    ProductInfoTypeOriginalPrice,   //原价
    ProductInfoTypeDiscount,        //折扣
    ProductInfoTypeDiscountPrice,   //折扣价
    ProductInfoTypeAttribute,       //产品属性
    ProductInfoTypeClass,           //产品类别
    ProductInfoTypeUseMethod,       //使用方法
};

NS_ASSUME_NONNULL_BEGIN

@interface ProductInfoModel : NSObject
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *contentString;
@property (nonatomic, assign) ProductInfoType productInfoType;

@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) UILabel * contentLabel;

+(NSMutableArray<ProductInfoModel *> *)arrayWithProductInfoModels;
@end

NS_ASSUME_NONNULL_END
