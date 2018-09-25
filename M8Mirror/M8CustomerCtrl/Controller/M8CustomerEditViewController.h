//
//  M8CustomerEditViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/12.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customerModel.h"
@protocol M8CustomerEditViewControllerDelegate <NSObject>
@optional
- (void)savedEditCustomer:(customerModel *)customer withTitle:(NSString *)title;
@end
@interface M8CustomerEditViewController : UIViewController
@property (nonatomic, weak) id<M8CustomerEditViewControllerDelegate> delegate;
//@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) customerModel *currentCustomer;
@end
