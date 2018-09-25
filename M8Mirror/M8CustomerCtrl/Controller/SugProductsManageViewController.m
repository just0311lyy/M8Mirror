//
//  SugProductsManageViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/22.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "SugProductsManageViewController.h"

@interface SugProductsManageViewController ()

@end

@implementation SugProductsManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    [self initWithProductsShowData];
//    [self initWithProductsShowTable];
}

-(void)initWithNavBar{
    self.title = @"管理";
    //导航栏右按钮
//    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBarBtn setTitle:@"管理" forState:UIControlStateNormal];
//    [rightBarBtn addTarget:self action:@selector(pushToProductsShowManageView) forControlEvents:UIControlEventTouchUpInside];
//    rightBarBtn.frame = CGRectMake(0, 0, 50, 25);
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithProductsShowData{}

#pragma mark - Button Action
//取消按钮
-(void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

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
