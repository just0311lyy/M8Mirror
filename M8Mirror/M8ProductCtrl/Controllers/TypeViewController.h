//
//  TypeViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/24.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TypeViewControllerDelegate <NSObject>
@optional
- (void)saveSelectedAttribArray:(NSArray *)array andSelectedIndex:(NSInteger)selectedIndex;
@end
@interface TypeViewController : UIViewController
@property (nonatomic, weak) id<TypeViewControllerDelegate> delegate;
@property (nonatomic , strong) NSArray *selectedArr; //已经被选中的
@property (nonatomic , assign) NSInteger selectedIndex;
@end
