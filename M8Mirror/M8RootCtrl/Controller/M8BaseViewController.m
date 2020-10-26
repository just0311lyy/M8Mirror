//
//  M8BaseViewController.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/1/2.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "M8BaseViewController.h"

@interface M8BaseViewController ()

@end

@implementation M8BaseViewController

- (void)viewDidLoad {
    [self initNavBar];
    [self initData];
    [super viewDidLoad];
    [self initView];
}

#pragma mark -- ***  init ***
-(void)initNavBar{

    self.navigationController.navigationBar.barTintColor = LOGO_COLOR;
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:GetLogicFont(10)]};
    //导航栏左边返回按钮
    _leftNavBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    //36x66
    [_leftNavBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(GetLogicPixelX(20)*36/66, GetLogicPixelX(20))]  forState:UIControlStateNormal];
    [_leftNavBarBtn addTarget:self action:@selector(leftNavBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _leftNavBarBtn.frame = CGRectMake(0, 0,GetLogicPixelX(20),GetLogicPixelX(20));
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:_leftNavBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    //导航栏右边编辑按钮 图片按钮frame：36x36
    _rightNavBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightNavBarBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightNavBarBtn.titleLabel setFont:[UIFont systemFontOfSize:GetLogicFont(10)]];
    [_rightNavBarBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [_rightNavBarBtn addTarget:self action:@selector(rightNavBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _rightNavBarBtn.frame = CGRectMake(0, 0,GetLogicPixelX(36),GetLogicPixelX(36));
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:_rightNavBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

-(void)initData{
    B_ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    B_ScreenHeight = [UIScreen mainScreen].bounds.size.height;
    B_NavBarHeight = 64;
    B_NavBarOrginY = NavBarOrginY;
    B_TabBarHeight = 49;
    if (Device_Is_iPhoneX) {
        B_NavBarHeight = B_NavBarHeight + 24;
        B_TabBarHeight = B_TabBarHeight + 34;
    }
}

-(void)initView{
    
}

#pragma mark -- ***  buttonAction ***
//返回按钮
-(void)leftNavBarButtonClick{
    NSLog(@"点击了左导航按钮");
    [self.navigationController popViewControllerAnimated:YES];
}
//编辑按钮
- (void)rightNavBarButtonClick {
    NSLog(@"点击了右导航按钮");
}

#pragma mark -- *** 弹出提示框 ***
-(void)showAlertViewWithText:(NSString *)txt{
    UIAlertController *alertView =
    [UIAlertController alertControllerWithTitle:@"提示"
                                        message:txt
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alertView addAction:action];
    [self presentViewController:alertView animated:YES completion:nil];
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
