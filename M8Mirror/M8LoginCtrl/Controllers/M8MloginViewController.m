//
//  M8MloginViewController.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/1/2.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "M8MloginViewController.h"
//#import "M8MainViewController.h"
#import "M8RootViewController.h"

//#import "DeviceSingle.h"
#import "UIImage+category.h"
#import "HWPopTool.h"
#import "FSCustomButton.h"
#import "LanguageView.h"
#import "CountryModel.h"

#define Line_Gray_Color UIColorFromRGB(0xe5e8eb)
@interface M8MloginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic)UITextField *accountText;
@property (strong, nonatomic)UITextField *passwordText;
@property (strong, nonatomic)UIView *backgroundView; //内容视图，键盘弹起时上移，键盘回落时回移
//@property (strong, nonatomic)UIView *inputView; //内容视图，键盘弹起时上移，键盘回落时回移
@property (strong, nonatomic)FSCustomButton *languageBtn;
@property (assign, nonatomic)NSInteger selectIndex;/*选择的语言cell索引*/

@end

@implementation M8MloginViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)initView{
    [super initView];
    self.view.backgroundColor = BACKGROUND_GREY_COLOR;

    _backgroundView = [[UIView alloc] init];
    [self.view addSubview:_backgroundView];
    CGFloat backBg_H = SCREEN_H * 4 / 5;
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(backBg_H));
    }];
    
    CGFloat blueBg_H = backBg_H/2;
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"login_background.png"];
    [_backgroundView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundView);
        make.left.equalTo(_backgroundView);
        make.right.equalTo(_backgroundView);
        make.height.equalTo(@(blueBg_H));
    }];
    
    //用户头像 120x120
    UIImageView *userImgView = [[UIImageView alloc] init];
    [userImgView setImage:[UIImage imageNamed:@"cus_woman.png"]];
    [bgImageView addSubview:userImgView];
//    [bgImageView setUserInteractionEnabled:YES];
    [userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.centerY.equalTo(bgImageView);
        make.width.equalTo(@(GetLogicPixelX(240)));
        make.height.equalTo(@(GetLogicPixelX(240)));
    }];
    userImgView.layer.cornerRadius = GetLogicPixelX(240)/2;
    userImgView.layer.borderWidth = 10;
    userImgView.layer.borderColor = UIColorFromRGB(0x4ab5d6).CGColor;
    [userImgView.layer setMasksToBounds:YES];
    //账号
    CGFloat img_H = GetLogicPixelX(50);
    _accountText = [[UITextField alloc] init];
    [_accountText setDelegate:self];
    [_accountText setPlaceholder:[LYLocalizeConfig localizedString:@"Account"]];
    _accountText.clearButtonMode = UITextFieldViewModeWhileEditing; //一键删除
    _accountText.autocapitalizationType = UITextAutocapitalizationTypeNone; //不自动大写
    //    _accountText.textAlignment = UITextAlignmentLeft;
    [_backgroundView addSubview:_accountText];
    [_accountText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backgroundView);
        make.top.equalTo(bgImageView.mas_bottom).with.offset(GetLogicPixelX(60));
        make.width.equalTo(@(SCREEN_W * 3/5));
        make.height.equalTo(@(GetLogicPixelX(80)));
    }];
    
    UIImageView *accountImgView = [[UIImageView alloc] init];
    UIImage *accountImg = [[UIImage imageNamed:@"login_account.png"] imageWithTintColor:LOGO_COLOR];
    [accountImgView setImage:accountImg];
    [_backgroundView addSubview:accountImgView];
    [accountImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_accountText);
        make.right.equalTo(_accountText.mas_left).with.offset(-GetLogicPixelX(20));
        make.width.equalTo(@(img_H));
        make.height.equalTo(@(img_H));
    }];
    //账号分割线
    UIView *lineOneView = [[UIView alloc] init];
    lineOneView.backgroundColor = Line_Gray_Color;
    [_backgroundView addSubview:lineOneView];
    [lineOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountText.mas_bottom);
        make.left.right.equalTo(_accountText);
        make.height.equalTo(@(GetLogicPixelX(2)));
    }];
    
    //密码
    _passwordText = [[UITextField alloc] init];
    [_passwordText setDelegate:self];
    [_passwordText setPlaceholder:[LYLocalizeConfig localizedString:@"Password"]];
    _passwordText.secureTextEntry = YES;
    _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing; //一键删除
    _passwordText.autocapitalizationType = UITextAutocapitalizationTypeNone; //不自动大写
    //    _accountText.textAlignment = UITextAlignmentLeft;
    [_backgroundView addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountText.mas_bottom).with.offset(GetLogicPixelX(40));
        make.centerX.width.height.equalTo(_accountText);
    }];

    UIImageView *passwordImgView = [[UIImageView alloc] init];
    UIImage *passwordImg = [[UIImage imageNamed:@"login_password.png"] imageWithTintColor:LOGO_COLOR];
    [passwordImgView setImage:passwordImg];
    [_backgroundView addSubview:passwordImgView];
    [passwordImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_passwordText);
        make.left.equalTo(accountImgView);
        make.width.equalTo(@(img_H));
        make.height.equalTo(@(img_H));
    }];

    //密码分割线
    UIView *lineTwoView = [[UIView alloc] init];
    lineTwoView.backgroundColor = Line_Gray_Color;
    [_backgroundView addSubview:lineTwoView];
    [lineTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordText.mas_bottom);
        make.left.right.equalTo(_accountText);
        make.height.equalTo(@(GetLogicPixelX(2)));
    }];
    
    //登录
//    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/2, CGRectGetHeight(_backgroundView.frame) - btn_h, width,btn_h)];
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordText.mas_bottom).with.offset(GetLogicPixelX(80));
        make.centerX.equalTo(_backgroundView);
        make.width.equalTo(@(GetLogicPixelX(380)));
        make.height.equalTo(@(GetLogicPixelX(88)));
    }];
    [loginBtn setTitle:[LYLocalizeConfig localizedString:@"Login"] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:LOGO_COLOR];
    [loginBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:GetLogicFont(18)]];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = GetLogicPixelX(88)/2;
    [loginBtn.layer setMasksToBounds:YES];
    [loginBtn addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self languageSelectedView];  //语言选择视图
}

-(void)languageSelectedView{
    //默认为当前计算机选中的语言
    _languageBtn = [FSCustomButton buttonWithType:UIButtonTypeCustom];
//    _languageBtn.frame = CGRectMake((SCREEN_W - 200)/2, CGRectGetMaxY(_backgroundView.frame) + (SCREEN_H/5 - 50)/2, 200,50);
    [self.view addSubview:_languageBtn];
    [_languageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroundView.mas_bottom).with.offset(GetLogicPixelX(20));
        make.centerX.equalTo(_backgroundView);
        make.width.equalTo(@(GetLogicPixelX(400)));
        make.height.equalTo(@(GetLogicPixelX(100)));
    }];
    
    _languageBtn.buttonImagePosition = FSCustomButtonImagePositionLeft;
    _languageBtn.adjustsTitleTintColorAutomatically = YES;
    [_languageBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:GetLogicFont(18)]];
    [_languageBtn addTarget:self action:@selector(languagePopViewShow:) forControlEvents:UIControlEventTouchUpInside];
    _languageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,GetLogicPixelX(10));
    
    //获取当前设备语言
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *systemName = [appLanguages objectAtIndex:0];
    NSLog(@"language:%@",systemName);
    //40x26
    UIImage *countryImage =[UIImage scaleImage:[UIImage imageNamed:@"country_China.png"]  toSize:CGSizeMake(GetLogicPixelX(50),GetLogicPixelX(32.5))];
    NSString *countryString = @"简体中文";
    if ([systemName isEqualToString:@"zh-Hans-US"]) {  //简体中文
        _selectIndex = 0;
        countryString = @"简体中文";
        countryImage =[UIImage scaleImage:[UIImage imageNamed:@"country_China.png"]  toSize:CGSizeMake(GetLogicPixelX(50),GetLogicPixelX(32.5))];
    }else if([systemName isEqualToString:@"en"]){  //英文
        _selectIndex = 1;
        countryString = @"English";
        countryImage =[UIImage scaleImage:[UIImage imageNamed:@"country_English.png"]  toSize:CGSizeMake(GetLogicPixelX(50),GetLogicPixelX(32.5))];
    }
    [_languageBtn setImage:countryImage forState:UIControlStateNormal];
    [_languageBtn setTitle:countryString forState:UIControlStateNormal];
}

#pragma mark -- 键盘
- (void)keyboardWillShow:(NSNotification *)note{
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

- (void)keyboardWillHidden:(NSNotification *)note{
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

//数据初始化
-(void)initWithLoginData{
    if(![[LYUserDefault loadAccountCache] isEqualToString:@""] && [LYUserDefault loadAccountCache] != nil) _accountText.text = [LYUserDefault loadAccountCache];
    if(![[LYUserDefault loadUserPasswardCache] isEqualToString:@""] && [LYUserDefault loadUserPasswardCache] != nil) _passwordText.text = [LYUserDefault loadUserPasswardCache];
}

#pragma mark - 按钮点击
//登录
-(void)loginButtonClick{
    [self loginSuccess];
//    if ([_accountText.text isEqualToString:@""] || _accountText.text == nil) {
//        [self showAlertViewWithText:@"账号不能为空"];
//    }
//    if ([_passwordText.text isEqualToString:@""] || _passwordText.text == nil) {
//        [self showAlertViewWithText:@"密码不能为空"];
//    }
//    if ([_accountText.text isEqualToString:@"admin"] && [_passwordText.text isEqualToString:@"000000"]) {
//        [LYUserDefault saveAccountCache:_accountText.text];
//        [LYUserDefault saveUserPasswardCache:_passwordText.text];
//        [self loginSuccess];
//    }else{
//        [self showAlertViewWithText:@"账号或密码错误"];
//    }
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
    __weak M8MloginViewController *weakSelf = self;
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
#pragma mark -- 懒加载


- (void)updateViewConstraintsForKeyboardHeight:(CGFloat)keyboardHeight{
    //    DDLogDebug(@"keyboardHeight = %lf",keyboardHeight);
    [self.view layoutIfNeeded];
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
