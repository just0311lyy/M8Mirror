//
//  LYSQLDataOperation.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XmlImgDownloadModel.h"
#import "ProductModel.h"
#import "customerModel.h"
#import "ReportModel.h"
#import "ProductNetModel.h"

@interface LYSQLDataOperation : NSObject
//初始化FMDB
-(BOOL)openDatabase;
+(LYSQLDataOperation *)sharedDataInstance;
-(BOOL)excuteSqlString:(NSString *)sqlString;

/**************       广告图       ******************
 *  保存广告图对象
 *  @param imgModel 广告图对象
 *  @return 是否保存成功
 */
-(BOOL)saveAdvertImgData:(XmlImgDownloadModel *)imgModel;
/**
 *  查询广告图数据
 *  @return 返回的广告图对象数组
 */
-(NSArray *)getAllAdvertImgsData;
/**
 *  通过图片唯一标识符 imageId 删除表中该广告图对象数据
 *  @return 是否删除成功
 */
-(BOOL)deleteAdvertImgByImageID:(int)imageId;
/**
 *  删除广告图表中的所有数据 是否成功
 *  @return 是否删除成功
 */
-(BOOL)deleteAllAdvertImgs;

/**************       主页轮播图       ******************
 *  轮播显示图
 *  @param imgModel 显示图对象
 *  @return 是否保存成功
 */
-(BOOL)saveShowImageData:(XmlImgDownloadModel *)imgModel;
/**
 *  查询轮播图数据
 *  @return 返回的轮播图数组
 */
-(NSArray *)getAllShowImages;
/**
 *  通过图片唯一标识符 imageId 删除表中该广告图对象数据
 *  @return 是否删除成功
 */
-(BOOL)deleteShowImgByImageID:(int)imageId;
/**
 *  删除轮播图表中的所有数据 是否成功
 *  @return 是否删除成功
 */
-(BOOL)deleteAllShowImgs;

/**************       产品列表       ******************
 *  产品列表
 *  @param productModel 产品对象
 *  @return 是否保存成功
 */
-(BOOL)saveProductData:(ProductModel *)productModel;
/**
 *  查询产品列表
 *  @return 返回的产品列表数组
 */
-(NSArray *)getAllProducts;
/**
 *  通过id更新某个产品数据
 */
-(BOOL)updateProductData:(ProductModel *)productModel withID:(NSInteger)productId;
/**
 *  通过产品唯一标识符 productId 删除表中该产品对象数据
 *  @return 是否删除成功
 */
-(BOOL)deleteProductByProductID:(int)productId;
/**
 *  删除产品列表中的所有数据 是否成功
 *  @return 是否删除成功
 */
-(BOOL)deleteAllProducts;

/**************       用户列表       ******************
 *  用户列表
 *  @param model 用户对象
 *  @return 是否保存成功
 */
-(BOOL)saveCustomerData:(customerModel *)model;
/**
 *  查询客户列表
 *  @return 返回的客户列表数组
 */
-(NSArray *)getAllCustomers;
/**
 *  通过id更新某个客户数据
 */
-(BOOL)updateCustomerData:(customerModel *)model withID:(NSInteger)customerID;

/**
 *  通过客户唯一标识符 customerId 删除表中该客户对象数据
 *  @return 是否删除成功
 */
-(BOOL)deleteCustomerByCustomerID:(NSInteger)customerID;
/**
 *  删除客户列表 是否成功
 *  @return 是否删除成功
 */
-(BOOL)deleteAllCustomers;

/**************       客户检测记录列表       ******************
 *  新增 检测列表
 *  @param model 用户对象
 *  @return 是否保存成功
 */
-(BOOL)saveReportData:(ReportModel *)model;
/**
 *  查询客户检测记录列表
 *  @return 返回客户检测记录列表数组
 */
-(NSArray *)getAllReportsOfCustomerID:(NSInteger)customerID;
/**
 *  通过客户id以及检测时间更新某个检测数据
 */
-(BOOL)updateReportData:(ReportModel *)model withCustomerID:(NSInteger)customerID andReportDate:(NSString *)reportDate;
/**
 *  通过客户唯一标识符 customerId 以及检测记录的时间 删除表中该客户的此时间的检测记录
 *  @return 是否删除成功
 */
-(BOOL)deleteReportByCustomerID:(NSInteger)customerId andReportDate:(NSString *)reportDate;
/**
 *  通过客户唯一标识符 customerId 删除表中该客户的全部检测记录
 *  @return 是否删除成功
 */
-(BOOL)deleteReportsOfCustomerID:(NSInteger)customerId;
/**
 *  删除客户列表 是否成功
 *  @return 是否删除成功
 */
-(BOOL)deleteAllReports;

/**************       产品网络关系列表       ******************
 *  产品网络关系列表
 *  @param model 产品网络关系对象
 *  @return 是否保存成功
 */
-(BOOL)saveProductNetData:(ProductNetModel *)model;
/**
 *  查询产品网络关系列表
 *  @return 返回的产品网络关系列表数组
 */
-(NSArray *)getAllProductNets;
/**
 *  查询单个产品网络关系数据
 *  @return 返回单个产品网络关系数据
 */
-(ProductNetModel *)getProductNetDataByProductNetId:(NSInteger)productNetId;
/**
 *  通过id更新某个产品网络关系数据
 */
-(BOOL)updateProductNetData:(ProductNetModel *)model;
@end
