//
//  LYUserDefault.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LYUserDefault.h"

@implementation LYUserDefault
static  NSString *LYUserNameStr = @"LYUserNameStr";
static  NSString *LYAccountStr = @"LYAccountStr";
static  NSString *LYPasswardStr = @"LYPasswardStr";
static  NSString *LYDeptTypeStr = @"LYDeptTypeStr";
static  NSString *LYDeptNameStr = @"LYDeptNameStr";

/*缓存管理员账号*/
+(void)saveAccountCache:(NSString *)account{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:account forKey:LYAccountStr];
    [ud synchronize];
}
/*加载管理员账号缓存*/
+(NSString *)loadAccountCache{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userIDString = [ud objectForKey:LYAccountStr];
    return userIDString;
}

/** 缓存管理员密码*/
+(void)saveUserPasswardCache:(NSString *)passward{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:passward forKey:LYPasswardStr];
    [ud synchronize];
}
/** 加载管理员密码缓存 */
+(NSString *)loadUserPasswardCache{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *passwardString = [ud objectForKey:LYPasswardStr];
    return passwardString;
}

/*缓存管理员用户名*/
+(void)saveUserNameCache:(NSString *)userName{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:userName forKey:LYUserNameStr];
    [ud synchronize];
}
/*加载管理员用户名缓存*/
+(NSString *)loadUserNameCache{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userNameString = [ud objectForKey:LYUserNameStr];
    return userNameString;
}

/*缓存管理员所属机构类型*/
+(void)saveDeptTypeCache:(NSString *)deptType{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:deptType forKey:LYDeptTypeStr];
    [ud synchronize];
}
/*加载管理员所属机构类型缓存*/
+(NSString *)loadDeptTypeCache{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *deptTypeString = [ud objectForKey:LYDeptTypeStr];
    return deptTypeString;
}

/*缓存管理员所属机构名称*/
+(void)saveDeptNameCache:(NSString *)deptName{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:deptName forKey:LYDeptNameStr];
    [ud synchronize];
}
/*加载管理员所属机构类型缓存*/
+(NSString *)loadDeptNameCache{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *deptNameString = [ud objectForKey:LYDeptNameStr];
    return deptNameString;
}


/*删除网关key缓存*/
//+(void)deleteGatewayKeyCache{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud removeObjectForKey:ASGatewayKeyStr];
//    [ud synchronize];
//}

/*缓存网关对象*/
//+(void)saveGatewayCache:(AduroGateway *)gateway{
//    NSData *encodeData = [NSKeyedArchiver archivedDataWithRootObject:gateway];
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:encodeData forKey:@"CurrentGateway"];
//    [ud synchronize];
//}
/*加载网关对象*/
//+(AduroGateway *)loadGatewayCache{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *myEncodedObject = [defaults objectForKey:@"CurrentGateway"];
//    AduroGateway *gateway = (AduroGateway *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
//    return gateway;
//}

@end
