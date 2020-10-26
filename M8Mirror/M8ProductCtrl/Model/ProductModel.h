//
//  ProductModel.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;

@interface ProductModel : NSObject
@property (nonatomic ,assign) int productId;             //产品唯一编号
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *attrib;          //产品属性，00-淡斑 01-补水 02--清洁 03--嫩肤 04--抗衰 05--修复 06--保养
@property (nonatomic ,strong) NSString *grade;           //产品类别：0--基础产品 1--中端产品 2--高端产品
@property (nonatomic ,strong) NSString *price;
@property (nonatomic ,strong) NSString *discount;        //折扣
@property (nonatomic ,strong) NSString *useMethod;
//@property (nonatomic ,strong) NSString *base64ImgStr;    //base64字符串
@property (nonatomic ,strong) NSString *imgDocumentPath; //图片保存在沙盒中的路径
@property (nonatomic ,strong) NSString *putdate;         //添加日期
@property (nonatomic ,assign) int deptid;                //所属连锁机构
@property (nonatomic ,assign) int parlorid;              //所属美容院
@property (nonatomic ,strong) NSString *userid;          //所属用户

+ (NSMutableArray *)getProductModelData;
+ (BOOL)isProduct:(ProductModel *)product haveAttribString:(NSString *)string;

+ (ProductModel *)modelOfSourceWithSqlResult:(FMResultSet *)result;
@end
