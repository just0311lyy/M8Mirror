//
//  M8AdminViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M8AdminViewController : UIViewController
//照片选取失败回调
@property(nonatomic, strong)void (^errorHandle)(NSString *error);
@end
