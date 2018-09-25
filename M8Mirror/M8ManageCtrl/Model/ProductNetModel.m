//
//  ProductNetModel.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ProductNetModel.h"

@implementation ProductNetModel
+ (NSMutableArray *)getProductNetModelData {
    NSMutableArray *proNetModelAry = [NSMutableArray new];
    ProductNetModel *pro01 = [[ProductNetModel alloc] init];
    pro01.productNetId = 111;
    pro01.typeName = @"RGB色斑";
    pro01.minPercent = 0;
    pro01.maxPercent = 100;
    pro01.productTypeArr = @[@"淡斑类",@"清洁类"];
    
    ProductNetModel *pro02 = [[ProductNetModel alloc] init];
    pro02.productNetId = 222;
    pro02.typeName = @"RGB粗糙度";
    pro02.minPercent = 0;
    pro02.maxPercent = 100;
    pro02.productTypeArr = @[@"补水类",@"抗衰老"];
    
    ProductNetModel *pro03 = [[ProductNetModel alloc] init];
    pro03.productNetId = 333;
    pro03.typeName = @"UV皱纹";
    pro03.minPercent = 0;
    pro03.maxPercent = 100;
    pro03.productTypeArr = @[@"嫩肤类",@"修复类"];
    
    ProductNetModel *pro04 = [[ProductNetModel alloc] init];
    pro04.productNetId = 444;
    pro04.typeName = @"UV粉刺";
    pro04.minPercent = 0;
    pro04.maxPercent = 100;
    pro04.productTypeArr = @[@"清洁类",@"保养类"];
    
    ProductNetModel *pro05 = [[ProductNetModel alloc] init];
    pro05.productNetId = 555;
    pro05.typeName = @"UV色素";
    pro05.minPercent = 0;
    pro05.maxPercent = 100;
    pro05.productTypeArr = @[@"补水类",@"抗衰老"];
    
    [proNetModelAry addObjectsFromArray:@[pro01,pro02,pro03,pro04,pro05]];
    return proNetModelAry;
}
@end
