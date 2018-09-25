//
//  M8LoginViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/5.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8LoginViewController.h"
#import "M8MainViewController.h"
#import "M8RootViewController.h"

#import "DeviceSingle.h"
#import "UIImage+category.h"
#import "HWPopTool.h"
#import "FSCustomButton.h"
#import "LanguageView.h"
#import "CountryModel.h"

@interface M8LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic)UITextField *accountText;
@property (strong, nonatomic)UITextField *passwordText;
@property (strong, nonatomic)UIView *backgroundView;
@property (strong, nonatomic)FSCustomButton *languageBtn;
//@property (strong, nonatomic)UIButton *languageBtn;
@property (assign, nonatomic)NSInteger selectIndex;/*选择的语言cell索引*/
//@property (strong, nonatomic)UITableView *selTable;
//@property (strong, nonatomic)NSArray *selArray;
@end

@implementation M8LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    //    设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    //    如果不想让其他页面的导航栏变为透明 需要重置
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)keyboardWillShow:(NSNotification *)note{
    NSDictionary *userInfo = [note userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = value.CGRectValue.size.height;
    //输入框升高的高度
    CGFloat h = SCREEN_H/5>keyboardHeight?0:(keyboardHeight-SCREEN_H/5);
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]; //动画的轨迹：如先快后慢……
    
    [UIView animateWithDuration:[duration floatValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES]; //使用当前正在运行的状态开始下一段动画
        [UIView setAnimationCurve:[curve intValue]];
        [self updateViewConstraintsForKeyboardHeight:keyboardHeight];
        [_backgroundView setFrame:CGRectMake(0, -h, SCREEN_W, SCREEN_H*4/5)];
    }];
}

-(void)keyboardWillHidden:(NSNotification *)note{
    NSDictionary *userInfo = [note userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:[duration floatValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        [self updateViewConstraintsForKeyboardHeight:0];
        [_backgroundView setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H*4/5)];
    }];
}

-(void)updateViewConstraintsForKeyboardHeight:(CGFloat)keyboardHeight{
//    DDLogDebug(@"keyboardHeight = %lf",keyboardHeight);
    [self.view layoutIfNeeded];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xedf0f3);
    [self initWithView];
    [self initWithLoginData];
}

-(void)initWithView{
    [self normalInterfaceSize];
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H *4 / 5)];
    [self.view addSubview:_backgroundView];
    
    CGFloat blueView_h = SCREEN_H*2/5 ;
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, blueView_h)];
    bgImageView.image = [UIImage imageNamed:@"login_background.png"];
    [_backgroundView addSubview:bgImageView];
    
    //用户头像
    CGFloat userImg_w = blueView_h/2;
    UIImageView *userImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_W - userImg_w)/2, (blueView_h - userImg_w)/2, userImg_w, userImg_w)];
    [userImgView setImage:[UIImage imageNamed:@"cus_woman.png"]];
    userImgView.layer.cornerRadius = userImg_w/2;
    userImgView.layer.borderWidth = 10;
    userImgView.layer.borderColor = UIColorFromRGB(0x4ab5d6).CGColor;
    [userImgView.layer setMasksToBounds:YES];
    [_backgroundView addSubview:userImgView];
    //登录输入框
    [self initWithInputView];
    [self initLanguageView];
}

-(void)normalInterfaceSize{
    [DeviceSingle shareInstance].sWidth = [UIScreen mainScreen].bounds.size.width;
    [DeviceSingle shareInstance].sHeight = [UIScreen mainScreen].bounds.size.height;
}

-(void)initWithInputView{
    
    CGFloat width = CGRectGetWidth(_backgroundView.frame)/2;
    CGFloat height = 40;
    CGFloat x = width/2;
    CGFloat y = CGRectGetHeight(_backgroundView.frame)*13/20;
    CGFloat space = 20;
//    CGFloat inputView_x = label_w;
    //账号
    CGFloat img_H = height - 5;
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x,y,img_H, img_H)];
    UIImage *accountImg = [[UIImage imageNamed:@"login_account.png"] imageWithTintColor:LOGO_COLOR];
    [accountImgView setImage:accountImg];
    [_backgroundView addSubview:accountImgView];
    
    CGFloat account_X = CGRectGetMaxX(accountImgView.frame) + space;
    _accountText = [[UITextField alloc] initWithFrame:CGRectMake(account_X, CGRectGetMinY(accountImgView.frame), width - CGRectGetWidth(accountImgView.frame) - space, CGRectGetHeight(accountImgView.frame))];
    [_accountText setDelegate:self];
    [_accountText setPlaceholder:[LYLocalizeConfig localizedString:@"Account"]];
    _accountText.clearButtonMode = UITextFieldViewModeWhileEditing; //一键删除
    _accountText.autocapitalizationType = UITextAutocapitalizationTypeNone; //不自动大写
//    _accountText.textAlignment = UITextAlignmentLeft;
    [_backgroundView addSubview:_accountText];
    
    //下划线
    UIView *lineOneView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(accountImgView.frame), CGRectGetMaxY(_accountText.frame) + space, CGRectGetMaxX(_accountText.frame) - CGRectGetMinX(accountImgView.frame) , 1)];
    lineOneView.backgroundColor = UIColorFromRGB(0xe5e8eb);
    [_backgroundView addSubview:lineOneView];

    //密码
    UIImageView *passwordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(accountImgView.frame), CGRectGetMaxY(accountImgView.frame) + 2*space,CGRectGetWidth(accountImgView.frame), CGRectGetHeight(accountImgView.frame))];
    UIImage *passwordImg = [[UIImage imageNamed:@"login_password.png"] imageWithTintColor:LOGO_COLOR];
    [passwordImgView setImage:passwordImg];
    [_backgroundView addSubview:passwordImgView];
    
//    CGFloat account_X = CGRectGetMaxX(accountImgView.frame) + 10;
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_accountText.frame), CGRectGetMinY(passwordImgView.frame),CGRectGetWidth(_accountText.frame), CGRectGetHeight(_accountText.frame))];
    [_passwordText setDelegate:self];
    [_passwordText setPlaceholder:[LYLocalizeConfig localizedString:@"Password"]];
    _passwordText.secureTextEntry = YES;
    _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing; //一键删除
    _passwordText.autocapitalizationType = UITextAutocapitalizationTypeNone; //不自动大写
    //    _accountText.textAlignment = UITextAlignmentLeft;
    [_backgroundView addSubview:_passwordText];
    //下划线
    UIView *lineTwoView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(accountImgView.frame), CGRectGetMaxY(_passwordText.frame) + space, CGRectGetWidth(lineOneView.frame) , 1)];
    lineTwoView.backgroundColor = UIColorFromRGB(0xe5e8eb);
    [_backgroundView addSubview:lineTwoView];
    //登录
    CGFloat btn_h = 50;
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/2, CGRectGetHeight(_backgroundView.frame) - btn_h, width,btn_h)];
    [_backgroundView addSubview:loginBtn];
    [loginBtn setTitle:[LYLocalizeConfig localizedString:@"Login"] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:LOGO_COLOR];
    [loginBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = CGRectGetHeight(loginBtn.frame)/2;
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initLanguageView{
    //默认为当前计算机选中的语言
    _languageBtn =[FSCustomButton buttonWithType:UIButtonTypeCustom];
    _languageBtn.frame=CGRectMake((SCREEN_W - 200)/2, CGRectGetMaxY(_backgroundView.frame) + (SCREEN_H/5 - 50)/2, 200,50);
    [self.view addSubview:_languageBtn];
    _languageBtn.buttonImagePosition = FSCustomButtonImagePositionLeft;
    _languageBtn.adjustsTitleTintColorAutomatically = YES;
    [_languageBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22]];
    [_languageBtn addTarget:self action:@selector(languagePopViewShow:) forControlEvents:UIControlEventTouchUpInside];
    _languageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,15);

    //获取当前设备语言
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *systemName = [appLanguages objectAtIndex:0];
    NSLog(@"language:%@",systemName);
    UIImage *countryImage =[UIImage scaleImage:[UIImage imageNamed:@"country_China.png"]  toSize:CGSizeMake(40, 26)];
    NSString *countryString = @"简体中文";
    if ([systemName isEqualToString:@"zh-Hans-US"]) {  //简体中文
        _selectIndex = 0;
        countryString = @"简体中文";
        countryImage =[UIImage scaleImage:[UIImage imageNamed:@"country_China.png"]  toSize:CGSizeMake(40, 26)];
    }else if([systemName isEqualToString:@"en"]){  //英文
        _selectIndex = 1;
        countryString = @"English";
        countryImage =[UIImage scaleImage:[UIImage imageNamed:@"country_English.png"]  toSize:CGSizeMake(40, 26)];
    }
    [_languageBtn setImage:countryImage forState:UIControlStateNormal];
    [_languageBtn setTitle:countryString forState:UIControlStateNormal];
}

//数据初始化
-(void)initWithLoginData{
    if(![[LYUserDefault loadAccountCache] isEqualToString:@""] && [LYUserDefault loadAccountCache] != nil) _accountText.text = [LYUserDefault loadAccountCache];
    if(![[LYUserDefault loadUserPasswardCache] isEqualToString:@""] && [LYUserDefault loadUserPasswardCache] != nil) _passwordText.text = [LYUserDefault loadUserPasswardCache];
}

#pragma mark - 按钮点击
//登录
-(void)loginButtonClick{
    if ([_accountText.text isEqualToString:@""] || _accountText.text == nil) {
        [self showAlertViewWithText:@"账号不能为空"];
    }
    if ([_passwordText.text isEqualToString:@""] || _passwordText.text == nil) {
        [self showAlertViewWithText:@"密码不能为空"];
    }
    if ([_accountText.text isEqualToString:@"admin"] && [_passwordText.text isEqualToString:@"000000"]) {
        [LYUserDefault saveAccountCache:_accountText.text];
        [LYUserDefault saveUserPasswardCache:_passwordText.text];
        [self loginSuccess];
    }else{
        [self showAlertViewWithText:@"账号或密码错误"];
    }
}

-(void)loginSuccess{
    M8RootViewController *rootVC = [[M8RootViewController alloc] init];
    //    M8MainViewController *mainVC = [[M8MainViewController alloc] init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.4;
    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentModalViewController:rootVC animated:nil];
}

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

//语言设置页面
-(void)languagePopViewShow:(UIButton *)sender{
    __weak M8LoginViewController *weakSelf = self;
    NSArray *languageArr = [CountryModel getCountryModelData];
    LanguageView *languageView = [[LanguageView alloc] initLanguageViewWithArr:languageArr current:_selectIndex];
    languageView.languageSelectIndex = ^(NSInteger index) {
        weakSelf.selectIndex = index;
        CountryModel *model = languageArr[index];
        [_languageBtn setTitle:model.countryName forState:UIControlStateNormal];
        [_languageBtn setImage:[UIImage scaleImage:[UIImage imageNamed:model.imageName]  toSize:CGSizeMake(40, 26)] forState:UIControlStateNormal];
    };
    [languageView show:self.view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
