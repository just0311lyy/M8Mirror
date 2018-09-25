//
//  CategoryViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/4.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CategoryViewControllerDelegate <NSObject>
@optional
- (void)saveSelectedCategory:(NSString *)string;
@end
@interface CategoryViewController : UIViewController
@property (nonatomic, weak) id<CategoryViewControllerDelegate> delegate;
@property (nonatomic , strong) NSString *selectCategoryStr; //已经被选中的
@end
