//
//  M8PagesViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/5.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^M8PagesViewEnterBlock)();
@interface M8PagesViewController : UIViewController
@property (nonatomic,copy)M8PagesViewEnterBlock enterBlock;
@end
