//
//  LYUserDefault.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYUserDefault : NSObject
/********     管理员账号     *********
 *    @brief 缓存账号.
 *
 *    @para NSString 类型.
 */
+(void)saveAccountCache:(NSString *)account;
/**
 *    @brief 加载账号.
 *
 *    @para NSString 类型.
 */
+(NSString *)loadAccountCache;

/********     管理员密码     *********
 *    @brief 缓存用户密码.
 *
 *    @para NSString 类型.
 */
+(void)saveUserPasswardCache:(NSString *)passward;
/**
 *    @brief    加载用户名密码缓存.
 *
 *    @para     无.
 */
+(NSString *)loadUserPasswardCache;

/********     管理员用户     *********
 *    @brief 缓存用户名.
 *
 *    @para NSString 类型.
 */
+(void)saveUserNameCache:(NSString *)userName;
/**
 *    @brief    加载用户名缓存.
 *
 *    @para  无.
 */
+(NSString *)loadUserNameCache;

/********     管理员所属机构类型     *********
 *    @brief 缓存管理员所属机构类型.
 *
 *    @para NSString 类型.
 */
+(void)saveDeptTypeCache:(NSString *)deptType;
/**
 *    @brief    加载管理员所属机构类型缓存.
 *
 *    @para  无.
 */
+(NSString *)loadDeptTypeCache;

/********     管理员所属机构名称     *********
 *    @brief 缓存机构名称.
 *
 *    @para NSString 类型.
 */
+(void)saveDeptNameCache:(NSString *)deptName;
/**
 *    @brief    加载机构名称缓存.
 *
 *    @para  无.
 */
+(NSString *)loadDeptNameCache;

/**
 *    @brief 缓存网关对象.
 *
 *    @param 网关对象 类型.
 */
//+(void)saveGatewayCache:(AduroGateway *)gateway;
/**
 *    @brief    加载网关对象.
 *
 *    @param     无.
 */
//+(AduroGateway *)loadGatewayCache;









///**
// *    @brief    保存是否记住用户名标记.
// *
// *    @param 布尔值  YES or NO.
// */
//+(void)saveUserNameIsRemember:(BOOL)isRemember;
//
///**
// *    @brief      加载是否记住用户名标记
// *
// *    @return bool 类型 YES or NO.
// */
//+ (BOOL)loadUserIsRemember;
@end
