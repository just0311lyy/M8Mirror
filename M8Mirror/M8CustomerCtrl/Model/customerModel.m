//
//  customerModel.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/10.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "customerModel.h"

@implementation customerModel
+ (NSMutableArray *)getCustomerModelData {
    NSMutableArray *custAry = [NSMutableArray new];
    customerModel *cust01 = [[customerModel alloc] init];
    cust01.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"Amin.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust01.customerId = 1001;
    cust01.sexStr = @"woman";
    cust01.name = @"阿敏";
    cust01.phoneNumber = @"13886689702";
    cust01.birthday = @"1986-10-12";
    cust01.email = @"38784698@qq.com";
    cust01.address = @"深圳市南山区XXX街道阳光花园8栋1808";
    cust01.profession = @"人事行政";
    cust01.hobby = @"健身";
    cust01.isOrNo = YES;
    cust01.products = @"雅思洗面奶、兰蔻小黑瓶肌底液";
    
    customerModel *cust02 = [[customerModel alloc] init];
    cust02.customerId = 1002;
    cust02.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"Aiqingqing.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust02.sexStr = @"woman";
    cust02.name = @"艾青青";
    cust02.phoneNumber = @"13516539988";
    cust02.birthday = @"1989-03-08";
    
    customerModel *cust03 = [[customerModel alloc] init];
    cust03.customerId = 1003;
    cust03.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"Boren.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust03.sexStr = @"man";
    cust03.name = @"伯仁";
    cust03.phoneNumber = @"13282654469";
    cust03.birthday = @"1978-03-16";
    
    customerModel *cust04 = [[customerModel alloc] init];
    cust04.customerId = 1004;
    cust04.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"Baini.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust04.sexStr = @"woman";
    cust04.name = @"白妮";
    cust04.phoneNumber = @"13654749686";
    cust04.birthday = @"1992-10-15";
    
    customerModel *cust05 = [[customerModel alloc] init];
    cust05.customerId = 1005;
    cust05.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"Baochunwei.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust05.sexStr = @"man";
    cust05.name = @"鲍春伟";
    cust05.phoneNumber = @"18916498426";
    cust05.birthday = @"1996-06-25";
    
    customerModel *cust06 = [[customerModel alloc] init];
    cust06.customerId = 1006;
    cust06.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"Chenjiacheng.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust06.sexStr = @"man";
    cust06.name = @"程嘉诚";
    cust06.phoneNumber = @"15898346599";
    cust06.birthday = @"1985-12-26";
    
    customerModel *cust07 = [[customerModel alloc] init];
    cust07.customerId = 1007;
    cust07.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"cus_woman.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust07.sexStr = @"woman";
    cust07.name = @"陈丹彤";
    cust07.phoneNumber = @"13655329856";
    cust07.birthday = @"1989-06-25";
    
    customerModel *cust08 = [[customerModel alloc] init];
    cust08.customerId = 1008;
    cust08.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"cus_man.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust08.sexStr = @"man";
    cust08.name = @"李明";
    cust08.phoneNumber = @"13883728702";
    cust08.birthday = @"1986-10-12";
    
    customerModel *cust09 = [[customerModel alloc] init];
    cust09.customerId = 1009;
    cust09.headImgOfBase64String = [UIImagePNGRepresentation([UIImage imageNamed:@"cus_woman.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    cust09.sexStr = @"woman";
    cust09.name = @"amin";
    cust09.phoneNumber = @"13883728702";
    cust09.birthday = @"1986-10-12";
    
    [custAry addObjectsFromArray:@[cust01,cust02,cust03,cust04,cust05,cust06,cust07,cust08,cust09]];
//    for (NSInteger index = 0; index < ary1.count;index++){
//        customerModel *customer = [customerModel new];
//        customer.image = [UIImage imageNamed:@"login_bg02.jpg"];
//        customer.name = ary1[index];
//        //        customer.number = [ary2[index] integerValue];
//        customer.number = ary2[index];
//        customer.birth = ary3[index];
//        [ary addObject:customer];
//    }
    return custAry;
}
@end
