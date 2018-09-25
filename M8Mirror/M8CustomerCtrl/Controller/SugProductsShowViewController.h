//
//  SugProductsShowViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/22.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SugProductsShowViewController : UIViewController
@property (strong , nonatomic) NSString *productAttrib; //产品属性，00-淡斑 01-补水 02--清洁 03--嫩肤 04--抗衰 05--修复 06--保养
@property (strong , nonatomic) NSString *productGrade;  //类别：低 中 高
@property (assign , nonatomic) NSInteger productNetId;  //产品网络关系id
@end
