//
//  M8GlobalData.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/27.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>
///**
// *  @author Lyy
// *
// *  @brief 数组下标
// */
//extern NSInteger *_index;


/**
 *  @author Lyy
 *
 *  @brief 对象数据源数组 客户
 */
extern NSMutableArray *_globalCustAry;

/**
 *  @author Lyy
 *
 *  @brief 主页轮转广告图数组 base64String
 */
extern NSMutableArray *_globalShowImgAry;

/**
 *  @author Lyy
 *
 *  @brief 产品列表数组 products
 */
extern NSMutableArray *_globalProductsAry;


@interface M8GlobalData : NSObject

@end
