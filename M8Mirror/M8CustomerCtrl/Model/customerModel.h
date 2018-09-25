//
//  customerModel.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/10.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface customerModel : NSObject
@property (assign, nonatomic) NSInteger customerId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *sexStr;
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *profession;   //职业
@property (strong, nonatomic) NSString *hobby;

@property (nonatomic) BOOL isOrNo;   //是否做过医美
@property (strong, nonatomic) NSString *products;   //现用护肤品

@property (strong, nonatomic) NSString *username;  //注册用户名
@property (strong, nonatomic) NSString *lastdate;  //注册时间
@property (strong, nonatomic) NSString *headImgOfBase64String;  //头像
@property (strong, nonatomic) NSString *adminuser;  //所属终端

+ (NSMutableArray *)getCustomerModelData;
@end
