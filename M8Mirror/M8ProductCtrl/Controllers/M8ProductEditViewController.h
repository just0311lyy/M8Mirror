//
//  M8ProductEditViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/10.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@protocol M8ProductEditViewControllerDelegate <NSObject>
@optional
- (void)savedEditProduct:(ProductModel *)product withTitle:(NSString *)title;
@end
@interface M8ProductEditViewController : UIViewController
@property (nonatomic, weak) id<M8ProductEditViewControllerDelegate> delegate;
//@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) ProductModel *currentProduct;
@end
