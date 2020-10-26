//
//  ProductInfoModel.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/5.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "ProductInfoModel.h"

@implementation ProductInfoModel

+(NSMutableArray<ProductInfoModel *> *)arrayWithProductInfoModels{
    NSMutableArray *mutArray = [NSMutableArray arrayWithCapacity:5];
    
    ProductInfoModel *nameModel = [[ProductInfoModel alloc] init];
    nameModel.titleName = @"产品名称";
    nameModel.productInfoType = ProductInfoTypeName;
    nameModel.contentString = CHECK_Nil(@"请输入产品名称") ;
    nameModel.contentLabel.text = CHECK_Nil(@"请输入产品名称");
    //    nameModel.contentTextField
    
    ProductInfoModel *originalPriceModel = [[ProductInfoModel alloc] init];
    originalPriceModel.titleName = @"原价";
    originalPriceModel.productInfoType = ProductInfoTypeOriginalPrice;
    originalPriceModel.contentString = CHECK_Nil(@"请输入原价") ;
    originalPriceModel.contentLabel.text = CHECK_Nil(@"请输入原价");
    
    ProductInfoModel *discountModel = [[ProductInfoModel alloc] init];
    discountModel.titleName = @"折扣";
    discountModel.productInfoType = ProductInfoTypeDiscount;
    discountModel.contentString = CHECK_Nil(@"请输入折扣") ;
    discountModel.contentLabel.text = CHECK_Nil(@"请输入折扣");
    
    ProductInfoModel *discountPriceModel = [[ProductInfoModel alloc] init];
    discountPriceModel.titleName = @"折扣价";
    discountPriceModel.productInfoType = ProductInfoTypeDiscountPrice;
    discountPriceModel.contentString = CHECK_Nil(@"请输入折扣价") ;
    discountPriceModel.contentLabel.text = CHECK_Nil(@"请输入折扣价");
    
    ProductInfoModel *attributeModel = [[ProductInfoModel alloc] init];
    attributeModel.titleName = @"产品属性";
    attributeModel.productInfoType = ProductInfoTypeAttribute;
    attributeModel.contentString = CHECK_Nil(@"请输入产品属性") ;
    attributeModel.contentLabel.text = CHECK_Nil(@"请输入产品属性");
    
    ProductInfoModel *classModel = [[ProductInfoModel alloc] init];
    classModel.titleName = @"产品类别";
    classModel.productInfoType = ProductInfoTypeClass;
    classModel.contentString = CHECK_Nil(@"请输入产品类别") ;
    classModel.contentLabel.text = CHECK_Nil(@"请输入产品类别");
    
    ProductInfoModel *useMethodModel = [[ProductInfoModel alloc] init];
    useMethodModel.titleName = @"使用方法";
    useMethodModel.productInfoType = ProductInfoTypeUseMethod;
    useMethodModel.contentString = CHECK_Nil(@"请输入使用方法") ;
    useMethodModel.contentLabel.text = CHECK_Nil(@"请输入使用方法");
    
    [mutArray addObjectsFromArray:@[nameModel,originalPriceModel,discountModel,discountPriceModel,attributeModel,classModel,useMethodModel]];
    return mutArray;
}

@end
