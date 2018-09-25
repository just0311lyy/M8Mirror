//
//  M8CustomerEditViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/12.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8CustomerEditViewController.h"
#import "M8ContentEditViewController.h"
#import "EditCellView.h"
#import "EditSelectView.h"
#import "customerModel.h"
#import "NSString+Wrapper.h"
#import "CGXPickerView.h"

@interface M8CustomerEditViewController ()<EditSelectViewDelegate,M8ContentEditViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) UIImageView *headImgView;  //产品图片
@property (nonatomic ,strong) EditCellView *nameView;
@property (nonatomic ,strong) EditSelectView *sexView;
@property (nonatomic ,strong) EditCellView *dateView;
@property (nonatomic ,strong) EditCellView *phoneView;
@property (nonatomic ,strong) EditCellView *emailView;
@property (nonatomic ,strong) EditCellView *addressView;
@property (nonatomic ,strong) EditCellView *professionView;
@property (nonatomic ,strong) EditCellView *hobbyView;
@property (nonatomic ,strong) EditSelectView *beautifulView;
@property (nonatomic ,strong) EditCellView *productView;
//@property (nonatomic ,strong) customerModel *aNewCustomer;
@property (nonatomic ,assign) NSInteger sixTag;
@property (nonatomic ,assign) NSInteger beautifulTag;
@end

@implementation M8CustomerEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    [self initWithView];
    [self initWithCustomerData];
    if (!_currentCustomer) {
        _currentCustomer = [[customerModel alloc] init];
    }
}

-(void)initWithNavBar{
//    self.navigationController.navigationBar.barTintColor = LOGO_COLOR;
    
    //导航栏右按钮
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithView{
    self.view.backgroundColor = UIColorFromRGB(0xefeff4);
    CGFloat space = 20 ;
    CGFloat view_h = 50;
    //头像
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,64 + space, SCREEN_W, 2*view_h)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *headLl = [[UILabel alloc] initWithFrame:CGRectMake(space, (CGRectGetHeight(headView.frame) - view_h)/2, 2*view_h, view_h)];
    [headLl setFont:[UIFont systemFontOfSize:20]];
    [headLl setText:@"头像"];
    [headLl setTextAlignment:NSTextAlignmentLeft];
    [headLl setNumberOfLines:0];
    [headLl setLineBreakMode:NSLineBreakByWordWrapping];
    [headView addSubview:headLl];
    //箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - space/2 - 23/2, (CGRectGetHeight(headView.frame) - 42/2)/2, 23/2, 42/2)];
    arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
    [headView addSubview:arrowImgView];
    //头像
    CGFloat head_w = 80;
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - 3*space/2 - CGRectGetWidth(arrowImgView.frame) - head_w, (CGRectGetHeight(headView.frame) - head_w)/2, head_w, head_w)];
    _headImgView.layer.cornerRadius = head_w/2;
    [_headImgView.layer setMasksToBounds:YES];
    _headImgView.image = [UIImage imageNamed:@"default_head.png"];
    [headView addSubview:_headImgView];
    //添加按钮
    UIButton *headButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headView.frame), CGRectGetHeight(headView.frame))];
    headButton.backgroundColor = [UIColor clearColor];
    [headButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    headButton.tag = 10;
    [headView addSubview:headButton];
    /*姓名*/
    _nameView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame) + space, SCREEN_W, view_h) andTitle:@"姓名" andDetailTitle:nil];
    [self.view addSubview:_nameView];
    //添加按钮
    UIButton *nameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_nameView.frame), CGRectGetHeight(_nameView.frame))];
    nameButton.backgroundColor = [UIColor clearColor];
    [nameButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    nameButton.tag = 11;
    [_nameView addSubview:nameButton];
    //性别
    _sexView = [[EditSelectView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameView.frame), SCREEN_W, view_h) andTitle:@"性别" andLeftBtnTitle:@"男" andRightBtnTitle:@"女"];
    _sexView.delegate = self;
    if ([_currentCustomer.sexStr isEqualToString:@"man"]) {
        _sexView.leftBtn.selected = YES;
        _sexView.rightBtn.selected = NO;
    }
    [self.view addSubview:_sexView];
    //出生日期
    _dateView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_sexView.frame), SCREEN_W, view_h) andTitle:@"出生日期" andDetailTitle:@"请选择"];
    [self.view addSubview:_dateView];
    
    UIButton *dateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_dateView.frame), CGRectGetHeight(_dateView.frame))];
    dateButton.backgroundColor = [UIColor clearColor];
    [dateButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    dateButton.tag = 13;
    [_dateView addSubview:dateButton];
    //联系电话
    _phoneView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateView.frame), SCREEN_W, view_h) andTitle:@"联系电话" andDetailTitle:nil];
    [self.view addSubview:_phoneView];
    
    UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_phoneView.frame), CGRectGetHeight(_phoneView.frame))];
    phoneButton.backgroundColor = [UIColor clearColor];
    [phoneButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    phoneButton.tag = 14;
    [_phoneView addSubview:phoneButton];
    /*常用邮箱*/
    _emailView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_phoneView.frame) + space, SCREEN_W, view_h) andTitle:@"常用邮箱" andDetailTitle:nil];
    [self.view addSubview:_emailView];
    
    UIButton *emailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_emailView.frame), CGRectGetHeight(_emailView.frame))];
    emailButton.backgroundColor = [UIColor clearColor];
    [emailButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    emailButton.tag = 15;
    [_emailView addSubview:emailButton];
    //现居地址
    _addressView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_emailView.frame), SCREEN_W, view_h) andTitle:@"现居住地址" andDetailTitle:@"请选择"];
    [self.view addSubview:_addressView];
    
    UIButton *addressButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_addressView.frame), CGRectGetHeight(_addressView.frame))];
    addressButton.backgroundColor = [UIColor clearColor];
    [addressButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    addressButton.tag = 16;
    [_addressView addSubview:addressButton];
    /*从事职业*/
    _professionView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_addressView.frame) + space, SCREEN_W, view_h) andTitle:@"从事职业" andDetailTitle:nil];
    [self.view addSubview:_professionView];
    
    UIButton *professionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_professionView.frame), CGRectGetHeight(_professionView.frame))];
    professionButton.backgroundColor = [UIColor clearColor];
    [professionButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    professionButton.tag = 17;
    [_professionView addSubview:professionButton];
    //业余爱好
    _hobbyView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_professionView.frame), SCREEN_W, view_h) andTitle:@"业余爱好" andDetailTitle:nil];
    [self.view addSubview:_hobbyView];
    
    UIButton *hobbyButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_hobbyView.frame), CGRectGetHeight(_hobbyView.frame))];
    hobbyButton.backgroundColor = [UIColor clearColor];
    [hobbyButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    hobbyButton.tag = 18;
    [_hobbyView addSubview:hobbyButton];
    /*是否做过医美*/
    _beautifulView = [[EditSelectView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_hobbyView.frame) + space, SCREEN_W, view_h) andTitle:@"是否做过医美" andLeftBtnTitle:@"是" andRightBtnTitle:@"否"];
    _beautifulView.delegate = self;
    if (_currentCustomer.isOrNo) {
        _sexView.leftBtn.selected = YES;
        _sexView.rightBtn.selected = NO;
    }
    [self.view addSubview:_beautifulView];
    //现用护肤品
    _productView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_beautifulView.frame), SCREEN_W, view_h) andTitle:@"现用护肤品" andDetailTitle:nil];
    [self.view addSubview:_productView];
    
    UIButton *productButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_productView.frame), CGRectGetHeight(_productView.frame))];
    productButton.backgroundColor = [UIColor clearColor];
    [productButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    productButton.tag = 20;
    [_productView addSubview:productButton];
}

-(void)initWithCustomerData{
    if (_currentCustomer) {
        _headImgView.image = [UIImage imageWithBase64String:_currentCustomer.headImgOfBase64String];
        _nameView.detailLb.text = _currentCustomer.name;
        if ([_currentCustomer.sexStr isEqualToString:@"man"]) {
            _sexView.leftBtn.selected  = YES;
            _sexView.rightBtn.selected = NO;
        }else{
            _sexView.leftBtn.selected  = NO;
            _sexView.rightBtn.selected = YES;
        }
        _dateView.detailLb.text = _currentCustomer.birthday;
        _phoneView.detailLb.text = _currentCustomer.phoneNumber;
        _emailView.detailLb.text = _currentCustomer.email;
        _addressView.detailLb.text = _currentCustomer.address;
        _professionView.detailLb.text = _currentCustomer.profession;
        _hobbyView.detailLb.text = _currentCustomer.hobby;
        if (_currentCustomer.isOrNo) {
            _beautifulView.leftBtn.selected = YES;
            _beautifulView.rightBtn.selected = NO;
        }else{
            _beautifulView.leftBtn.selected = NO;
            _beautifulView.rightBtn.selected = YES;
        }
        _productView.detailLb.text = _currentCustomer.products;
    }
}

#pragma mark - Button Action
//取消按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存按钮
- (void)rightButtonClick {
    //先判断客户姓名是否为空
    if ([_currentCustomer.name length]<1) {
        [self showAlertViewWithText:@"姓名不能为空"];
    }else if ([_currentCustomer.birthday length]<1){
        [self showAlertViewWithText:@"出生日期不能为空"];
    }else if ([_currentCustomer.phoneNumber length]<1){
        [self showAlertViewWithText:@"联系电话不能为空"];
    }else{
        if ([self.title isEqualToString:@"编辑"]) {
            //更新客户对象到数据库
            [self updateCustomerObject:_currentCustomer];
            //更新产品到全局数组
            for (int i=0; i<_globalCustAry.count; i++) {
                customerModel *globalCustomer = [_globalCustAry objectAtIndex:i];
                if (globalCustomer.customerId == _currentCustomer.customerId) {
                    [_globalCustAry replaceObjectAtIndex:i withObject:_currentCustomer];
                }
            }
        }else{ //新建产品
            //用创建的时间来作为唯一标识
            NSInteger timeId = [self currentDateInteger];
            _currentCustomer.customerId = timeId;
            //默认创建男
            if (!_sixTag) {
                _currentCustomer.sexStr = @"man";
            }
            //默认做过医美
            if (!_beautifulTag) {
                _currentCustomer.isOrNo = YES;
            }
            
            //保存客户对象到数据库
            [self saveCustomerObject:_currentCustomer];
            //新建客户，添加到全局数组
            //新建
            [_globalCustAry addObject:_currentCustomer];
            //发送通知，通知首页刷新列表
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustomerList" object:nil];
        }
        
        //协议数据回调
        if ([self.delegate respondsToSelector:@selector(savedEditCustomer:withTitle:)]) {
            [self.delegate savedEditCustomer:_currentCustomer  withTitle:self.title];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustomerList" object:nil];
    }
}

-(void)typeButtonClick:(UIButton*)button{
    switch (button.tag) {
        case 10:
        {
//            [self openCamera];
            [self openCameraOrPhotoLibrary];
        }
            break;
        case 11:
        {
            [self pushToDetailVCWithTitle:@"姓名" andContentText:_currentCustomer.name andButtonTag:button.tag];
        }
            break;
        case 13:
        {
//            [self pushToDetailVCWithTitle:@"出生日期" andContentText:_currentCustomer.birthday andButtonTag:button.tag];
            [self showDatePicker];
        }
            break;
        case 14:
        {
            [self pushToDetailVCWithTitle:@"联系电话" andContentText:_currentCustomer.phoneNumber andButtonTag:button.tag];
        }
            break;
        case 15:
        {
            [self pushToDetailVCWithTitle:@"常用邮箱" andContentText:_currentCustomer.email andButtonTag:button.tag];
        }
            break;
        case 16:
        {
            [self pushToDetailVCWithTitle:@"现居地址" andContentText:_currentCustomer.address andButtonTag:button.tag];
        }
            break;
        case 17:
        {
            [self pushToDetailVCWithTitle:@"从事职业" andContentText:_currentCustomer.profession andButtonTag:button.tag];
        }
            break;
        case 18:
        {
            [self pushToDetailVCWithTitle:@"业余爱好" andContentText:_currentCustomer.hobby andButtonTag:button.tag];
        }
            break;
        case 20:
        {
            [self pushToDetailVCWithTitle:@"现用护肤品" andContentText:_currentCustomer.products andButtonTag:button.tag];
        }
            break;
        default:
            break;
    }
    NSLog(@"点击的第%ld行",button.tag - 9);
}

-(void)pushToDetailVCWithTitle:(NSString *)title  andContentText:(NSString *)text andButtonTag:(NSUInteger)tag{
    M8ContentEditViewController *M8EVC = [[M8ContentEditViewController alloc] init];
    M8EVC.delegate = self;
    M8EVC.title = title;
    M8EVC.buttonTag = tag;
    M8EVC.contentString = text;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:M8EVC animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

-(void)editSelectClick:(UIButton *)button withTitle:(NSString *)title{
    if ([title isEqualToString:@"性别"]) {
        _sixTag = button.tag;
        //man.png  woman.png
        if (button.tag == 100) {
            NSLog(@"选择的：男");
            _currentCustomer.sexStr = @"man";
        }
        if (button.tag == 101) {
            NSLog(@"选择的：女");
            _currentCustomer.sexStr = @"woman";
        }
    }else if([title isEqualToString:@"是否做过医美"]){
        _beautifulTag = button.tag;
        if (button.tag == 100) {
            NSLog(@"选择的：是");
            _currentCustomer.isOrNo = YES;
        }
        if (button.tag == 101) {
            NSLog(@"选择的：否");
            _currentCustomer.isOrNo = NO;
        }
    }
}

#pragma mark - M8ProductDetailViewControllerDelegate
-(void)importWithString:(NSString *)detailTextStr andButtonTag:(NSUInteger)buttonTag{
    switch (buttonTag) {
        case 11:
        {
            _nameView.detailLb.text = detailTextStr;
            _currentCustomer.name = detailTextStr;
        }
            break;
//        case 13:
//        {
//            _dateView.detailLb.text = detailTextStr;
//            _currentCustomer.birthday = detailTextStr;
//        }
//            break;
        case 14:
        {
            _phoneView.detailLb.text = detailTextStr;
            _currentCustomer.phoneNumber = detailTextStr;
        }
            break;
        case 15:
        {
            _emailView.detailLb.text = detailTextStr;
            _currentCustomer.email = detailTextStr;
        }
            break;
        case 16:
        {
            _addressView.detailLb.text = detailTextStr;
            _currentCustomer.address = detailTextStr;
        }
            break;
        case 17:
        {
            _professionView.detailLb.text = detailTextStr;
            _currentCustomer.profession = detailTextStr;
        }
            break;
        case 18:
        {
            _hobbyView.detailLb.text = detailTextStr;
            _currentCustomer.hobby = detailTextStr;
        }
            break;
        case 20:
        {
            _productView.detailLb.text = detailTextStr;
            _currentCustomer.products = detailTextStr;
        }
            break;
        default:
            break;
    }
}

#pragma mark -- 调用相机
-(void)openCameraOrPhotoLibrary{
    // 创建UIImagePickerController实例
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    // 设置代理
    imagePickerController.delegate = self;
    // 是否允许编辑（默认为NO）
    imagePickerController.allowsEditing = YES;
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 设置警告响应事件
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 设置照片来源为相机
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        // 展示选取照片控制器
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 添加警告按钮
        [alert addAction:cameraAction];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [alert addAction:photosAction];
    }
    [alert addAction:cancelAction];
    // 展示警告控制器
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    NSLog(@"finish..");
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    _headImgView.image = image;
    _currentCustomer.headImgOfBase64String = [NSString base64StringWithImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 保存图片后到相册后，回调的相关方法，查看是否保存成功
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", error);
    }
}

#pragma mark -- FMDB
-(void)updateCustomerObject:(customerModel *)model{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db updateCustomerData:model withID:_currentCustomer.customerId];
}

-(void)saveCustomerObject:(customerModel *)model{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db saveCustomerData:model];
}

#pragma mark -- 获取当前时间作为创建的用户ID
//获取当前时间
- (NSInteger)currentDateInteger{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"hhmmss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
//    dateString = [dateString substringWithRange:NSMakeRange(2, 12)];
    int dateInt = [dateString intValue];
    return dateInt;
}

-(void)showDatePicker{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowStr = [fmt stringFromDate:now];
//    __weak typeof(self) weakSelf = self;
    [CGXPickerView showDatePickerWithTitle:@"出生年月" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:@"1900-01-01 00:00:00" MaxDateStr:nowStr IsAutoSelect:YES Manager:nil ResultBlock:^(NSString *selectValue) {
        NSLog(@"%@",selectValue);
//        weakSelf.navigationItem.title = selectValue;;
        _dateView.detailLb.text = selectValue;
        _currentCustomer.birthday = selectValue;
    }];
}

//弹出提示框
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
