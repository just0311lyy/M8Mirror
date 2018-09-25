//
//  ProductModel.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ProductModel.h"
#import "NSArray+NSString.h"

@implementation ProductModel
+ (NSMutableArray *)getProductModelData{
    NSMutableArray *productAry = [NSMutableArray new];
    ProductModel *product01 = [[ProductModel alloc] init];
    product01.base64ImgStr = [UIImagePNGRepresentation([UIImage imageNamed:@"picture01.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    product01.name = @"悦诗风吟绿茶保湿面膏";
    product01.useMethod = @"每日早晚使用，加水揉搓出泡沫，涂抹在湿润的面部轻柔按摩……";
    product01.price = @"198";
    product01.discount = @"85";
    product01.attrib = @"00,01";
    product01.grade = @"基础";
    
    
    ProductModel *product02 = [[ProductModel alloc] init];
    product02.base64ImgStr = [UIImagePNGRepresentation([UIImage imageNamed:@"picture02.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    product02.name = @"悦诗风吟绿茶保湿面膏";
    product02.useMethod = @"每日早晚使用，加水揉搓出泡沫，涂抹在湿润的面部轻柔按摩……";
    product02.price = @"198";
    product02.discount = @"80";
    product02.attrib = @"01,02";
    product02.grade = @"中端";
    
    ProductModel *product03 = [[ProductModel alloc] init];
    product03.base64ImgStr = [UIImagePNGRepresentation([UIImage imageNamed:@"picture03.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    product03.name = @"悦诗风吟绿茶保湿面膏";
    product03.useMethod = @"每日早晚使用，加水揉搓出泡沫，涂抹在湿润的面部轻柔按摩……";
    product03.price = @"198";
    product03.discount = @"95";
    product03.attrib = @"02,03";
    product03.grade = @"基础";
    
    ProductModel *product04 = [[ProductModel alloc] init];
    product04.base64ImgStr = [UIImagePNGRepresentation([UIImage imageNamed:@"picture04.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    product04.name = @"悦诗风吟绿茶保湿面膏";
    product04.useMethod = @"每日早晚使用，加水揉搓出泡沫，涂抹在湿润的面部轻柔按摩……";
    product04.price = @"198";
    product04.discount = @"85";
    product04.attrib = @"03,04";
    product04.grade = @"基础";
    
    ProductModel *product05 = [[ProductModel alloc] init];
    product05.base64ImgStr = [UIImagePNGRepresentation([UIImage imageNamed:@"picture05.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    product05.name = @"悦诗风吟绿茶保湿面膏";
    product05.useMethod = @"每日早晚使用，加水揉搓出泡沫，涂抹在湿润的面部轻柔按摩……";
    product05.price = @"198";
    product05.discount = @"90";
    product05.attrib = @"04,05";
    product05.grade = @"基础";
    
    ProductModel *product06 = [[ProductModel alloc] init];
    product06.base64ImgStr = [UIImagePNGRepresentation([UIImage imageNamed:@"picture06.png"]) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    product06.name = @"悦诗风吟绿茶保湿面膏";
    product06.useMethod = @"每日早晚使用，加水揉搓出泡沫，涂抹在湿润的面部轻柔按摩……";
    product06.price = @"198";
    product06.discount = @"96";
    product06.attrib = @"05,06";
    product06.grade = @"高端";

    [productAry addObjectsFromArray:@[product01,product02,product03,product04,product05,product06]];
    //    for (NSInteger index = 0; index < ary1.count;index++){
    //        customerModel *customer = [customerModel new];
    //        customer.image = [UIImage imageNamed:@"login_bg02.jpg"];
    //        customer.name = ary1[index];
    //        //        customer.number = [ary2[index] integerValue];
    //        customer.number = ary2[index];
    //        customer.birth = ary3[index];
    //        [ary addObject:customer];
    //    }
    return productAry;
}

+ (BOOL)isProduct:(ProductModel *)product haveAttribString:(NSString *)string{
    BOOL isHaveAttrStr = NO;
    NSArray *proAttrsAry = [NSArray arrayWithAttrString:product.attrib];
    if (proAttrsAry.count>0) {
        for (int i=0; i<proAttrsAry.count; i++) {
            NSString *proAttrStr = [proAttrsAry objectAtIndex:i];
            if ([proAttrStr isEqualToString:string]) {
                isHaveAttrStr = YES;
                break;
            }
        }
    }
    return isHaveAttrStr;
}

@end
