//
//  M8RootViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/19.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8RootViewController.h"
#import "M8MainViewController.h"
#import "M8MClientListViewController.h"
#import "M8InfomationViewController.h"
#import "M8ProductViewController.h"
#import "M8ManageViewController.h"
#import "UIImage+category.h"
@interface M8RootViewController ()

@end

@implementation M8RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize tabbar_size = CGSizeMake(26, 26);
    //主页
    M8MainViewController *mainVC = [[M8MainViewController alloc] init];
    mainVC.title = @"主页";
    UINavigationController *mainNavc = [[UINavigationController alloc]initWithRootViewController:mainVC];
    mainNavc.tabBarItem.title = @"主页";
    UIImage *homeImage = [[UIImage imageNamed:@"tabbar_main_unselected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    homeImage = [UIImage scaleImage:homeImage toSize:tabbar_size];
    mainNavc.tabBarItem.image = homeImage;
    UIImage *homeSelectedImage = [[UIImage imageNamed:@"tabbar_main_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    homeSelectedImage = [UIImage scaleImage:homeSelectedImage toSize:tabbar_size];
    mainNavc.tabBarItem.selectedImage = homeSelectedImage;

    // 客户档案
    M8MClientListViewController *listVC = [[M8MClientListViewController alloc]init];
    listVC.title = @"客户列表";
    UINavigationController *listNavc = [[UINavigationController alloc]initWithRootViewController:listVC];
    listNavc.tabBarItem.title = @"客户";
    UIImage *listImage = [[UIImage imageNamed:@"tabbar_file_unselected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    listImage = [UIImage scaleImage:listImage toSize:tabbar_size];
    listNavc.tabBarItem.image = listImage;
    UIImage *listSelectedImage = [[UIImage imageNamed:@"tabbar_file_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    listSelectedImage = [UIImage scaleImage:listSelectedImage toSize:tabbar_size];
    listNavc.tabBarItem.selectedImage = listSelectedImage;

    // 信息中心
    M8InfomationViewController *infoVC = [[M8InfomationViewController alloc]init];
    infoVC.title = @"信息中心";
    UINavigationController *infoNavc = [[UINavigationController alloc]initWithRootViewController:infoVC];
    infoNavc.tabBarItem.title = @"信息";
    UIImage *infoImage = [[UIImage imageNamed:@"tabbar_info_unselected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    infoImage = [UIImage scaleImage:infoImage toSize:tabbar_size];
    infoNavc.tabBarItem.image = infoImage;
    UIImage *infoSelectedImage = [[UIImage imageNamed:@"tabbar_info_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    infoSelectedImage = [UIImage scaleImage:infoSelectedImage toSize:tabbar_size];
    infoNavc.tabBarItem.selectedImage = infoSelectedImage;
    
    // 产品中心
    M8ProductViewController *productVC = [[M8ProductViewController alloc]init];
    productVC.title = @"产品列表";
    UINavigationController *productNavc = [[UINavigationController alloc]initWithRootViewController:productVC];
    productNavc.tabBarItem.title = @"产品";
    UIImage *productImage = [[UIImage imageNamed:@"tabbar_product_unselected.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    productImage = [UIImage scaleImage:productImage toSize:tabbar_size];
    productNavc.tabBarItem.image = productImage;
    UIImage *productSelectedImage = [[UIImage imageNamed:@"tabbar_product_selected.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    productSelectedImage = [UIImage scaleImage:productSelectedImage toSize:tabbar_size];
    productNavc.tabBarItem.selectedImage = productSelectedImage;

    // 我的
    M8ManageViewController *myVC = [[M8ManageViewController alloc] init];
//    myVC.title = @"我的";
    UINavigationController *myNavc = [[UINavigationController alloc]initWithRootViewController:myVC];
    myNavc.tabBarItem.title = @"我的";
    UIImage *myImage = [[UIImage imageNamed:@"tabbar_my_unselected.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    myImage = [UIImage scaleImage:myImage toSize:tabbar_size];
    myNavc.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [[UIImage imageNamed:@"tabbar_my_selected.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    mySelectedImage = [UIImage scaleImage:mySelectedImage toSize:tabbar_size];
    myNavc.tabBarItem.selectedImage = mySelectedImage;

    //tabbar选中的颜色
//    [[UITabBar appearance] setBackgroundColor:LOGO_COLOR];
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBar_bg"]];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] } forState:UIControlStateNormal];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = LOGO_COLOR;
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] } forState:UIControlStateSelected];
    //---
//    [UITabBar appearance].translucent = YES; //半透明
//    [UITabBar appearance].clipsToBounds = YES; //显示出多余的
    
//    self.viewControllers = @[mainVC,listVC,infoVC,productVC,myVC];
    self.viewControllers = @[mainNavc,listNavc,infoNavc,productNavc,myNavc];
}

//设置tabbar的高度
//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    CGRect frame = self.tabBar.frame;
//    frame.size.height = 140;
//    frame.origin.y = self.view.frame.size.height - frame.size.height;
//    self.tabBar.frame = frame;
//    self.tabBar.backgroundColor = [UIColor whiteColor];
////    self.tabBar.barStyle = UIBarStyleBlackOpaque;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
