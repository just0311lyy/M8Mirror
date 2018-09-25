//
//  PasswordViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "PasswordViewController.h"
#import "PasswordImportView.h"
@interface PasswordViewController ()
@property (nonatomic , strong) PasswordImportView *currentPassword;
@property (nonatomic , strong) PasswordImportView *aNewPassword;
@property (nonatomic , strong) PasswordImportView *confirmPassword;
@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self initWithNavBar];
    [self initWithView];
}

-(void)initWithNavBar{
    self.view.backgroundColor = UIColorFromRGB(0xedf0f3);
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:24]};
    //导航栏右按钮
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithView{
    //当前密码
    CGFloat y = 64 + 20;
    CGFloat h = 60;
    _currentPassword = [[PasswordImportView alloc] initWithFrame:CGRectMake(0, y, SCREEN_W, h) andTitle:@"当前密码" andPlaceholder:@"请输入"];
    [self.view addSubview:_currentPassword];
    //新密码
    _aNewPassword = [[PasswordImportView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_currentPassword.frame), SCREEN_W, h) andTitle:@"新密码" andPlaceholder:@"请输入"];
    [self.view addSubview:_aNewPassword];
    //确认新密
    _confirmPassword = [[PasswordImportView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_aNewPassword.frame), SCREEN_W, h) andTitle:@"确认新密码" andPlaceholder:@"请确认密码"];
    [self.view addSubview:_confirmPassword];
    
}

#pragma mark - Button Action
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存按钮
- (void)rightButtonClick {
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
