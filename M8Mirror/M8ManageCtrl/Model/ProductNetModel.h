//
//  ProductNetModel.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductNetModel : NSObject
@property (nonatomic ,assign) int productNetId; //产品网络关系id
@property (strong, nonatomic) NSString *typeName;
@property (assign, nonatomic) NSInteger minPercent;
@property (assign, nonatomic) NSInteger maxPercent;
@property (strong, nonatomic) NSArray *productTypeArr;
+ (NSMutableArray *)getProductNetModelData;
@end
