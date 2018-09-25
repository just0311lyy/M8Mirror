//
//  AdminModel.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdminModel : NSObject
@property (nonatomic,strong) NSString *account;  //账号
@property (nonatomic,strong) NSString *password;  //密码
@property (nonatomic,strong) NSString *username;  //用户名
@property (nonatomic,strong) NSString *type;  //机构类型
@property (nonatomic,strong) NSString *deptname;  //机构名称
@end
