//
//  M8ProductEditViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/10.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8ProductEditViewController.h"
#import "M8ProductDetailViewController.h"
#import "TypeViewController.h"
#import "CategoryViewController.h"
#import "EditCellView.h"
#import "NSString+Wrapper.h"
@interface M8ProductEditViewController ()<M8ProductDetailViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TypeViewControllerDelegate,CategoryViewControllerDelegate>
@property (nonatomic ,strong)UIImageView *headImgView;  //产品图片
@property (nonatomic ,strong)EditCellView *nameView; //产品名称
@property (nonatomic ,strong)EditCellView *priceView; //原价
@property (nonatomic ,strong)EditCellView *discountView; //折扣
@property (nonatomic ,strong)EditCellView *currentPriceView; //折扣价
@property (nonatomic ,strong)EditCellView *attributeView;  //产品属性
@property (nonatomic ,strong)EditCellView *classView;   //产品类别
@property (nonatomic ,strong)EditCellView *useView; //使用方法
@end

@implementation M8ProductEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    [self initWithView];
    [self initWithData];
    if (!_currentProduct) {
        _currentProduct = [[ProductModel alloc] init];
    }
}

-(void)initWithNavBar{
    self.navigationController.navigationBar.barTintColor = LOGO_COLOR;
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:22]};
//    导航栏右按钮
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithView{
    self.view.backgroundColor = UIColorFromRGB(0xefeff4);
    CGFloat space = 20 ;
    CGFloat view_h = 60;
    //头像
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,64 + space, SCREEN_W, 2*view_h)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *headLl = [[UILabel alloc] initWithFrame:CGRectMake(space, (CGRectGetHeight(headView.frame) - view_h)/2, 2*view_h, view_h)];
    [headLl setFont:[UIFont systemFontOfSize:20]];
    [headLl setText:@"产品图片"];
    [headLl setTextAlignment:NSTextAlignmentLeft];
    [headLl setNumberOfLines:0];
    [headLl setLineBreakMode:NSLineBreakByWordWrapping];
    [headView addSubview:headLl];
    //箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - space/2 - 23/2, (CGRectGetHeight(headView.frame) - 42/2)/2, 23/2, 42/2)];
    arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
    [headView addSubview:arrowImgView];
    //产品图片
    CGFloat head_w = 80;
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - 3*space/2 - CGRectGetWidth(arrowImgView.frame) - head_w, (CGRectGetHeight(headView.frame) - head_w)/2, head_w, head_w)];
    _headImgView.image = [UIImage imageNamed:@"default_head.png"]; //default_head.png
    [headView addSubview:_headImgView];
    //添加按钮
    UIButton *headButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headView.frame), CGRectGetHeight(headView.frame))];
    headButton.backgroundColor = [UIColor clearColor];
    [headButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    headButton.tag = 100;
    [headView addSubview:headButton];
    //产品名称
    _nameView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame) + space, SCREEN_W, view_h) andTitle:@"产品名称" andDetailTitle:nil];
    [self.view addSubview:_nameView];
    //添加按钮
    UIButton *nameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_nameView.frame), CGRectGetHeight(_nameView.frame))];
    nameButton.backgroundColor = [UIColor clearColor];
    [nameButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    nameButton.tag = 101;
    [_nameView addSubview:nameButton];
    //原价
    _priceView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameView.frame), SCREEN_W, view_h) andTitle:@"原价" andDetailTitle:nil];
    [self.view addSubview:_priceView];
    //添加按钮
    UIButton *priceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_priceView.frame), CGRectGetHeight(_priceView.frame))];
    priceButton.backgroundColor = [UIColor clearColor];
    [priceButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    priceButton.tag = 102;
    [_priceView addSubview:priceButton];
    //折扣
    _discountView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_priceView.frame), SCREEN_W, view_h) andTitle:@"折扣" andDetailTitle:nil];
    [self.view addSubview:_discountView];
    //添加按钮
    UIButton *discountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_discountView.frame), CGRectGetHeight(_discountView.frame))];
    discountButton.backgroundColor = [UIColor clearColor];
    [discountButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    discountButton.tag = 103;
    [_discountView addSubview:discountButton];
    //折扣价
    _currentPriceView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_discountView.frame), SCREEN_W, view_h) andTitle:@"折扣价" andDetailTitle:nil];
    [self.view addSubview:_currentPriceView];
    //添加按钮
    UIButton *currentPriceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_currentPriceView.frame), CGRectGetHeight(_currentPriceView.frame))];
    currentPriceButton.backgroundColor = [UIColor clearColor];
    [currentPriceButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    currentPriceButton.tag = 104;
    [_currentPriceView addSubview:currentPriceButton];
    //产品属性
    _attributeView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_currentPriceView.frame)+space, SCREEN_W, view_h) andTitle:@"产品属性" andDetailTitle:nil];
    [self.view addSubview:_attributeView];
    //添加按钮
    UIButton *attributeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_attributeView.frame), CGRectGetHeight(_attributeView.frame))];
    attributeButton.backgroundColor = [UIColor clearColor];
    [attributeButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    attributeButton.tag = 105;
    [_attributeView addSubview:attributeButton];
    //产品类别
    _classView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_attributeView.frame), SCREEN_W, view_h) andTitle:@"产品类别" andDetailTitle:nil];
    [self.view addSubview:_classView];
    //添加按钮
    UIButton *classButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_classView.frame), CGRectGetHeight(_classView.frame))];
    classButton.backgroundColor = [UIColor clearColor];
    [classButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    classButton.tag = 106;
    [_classView addSubview:classButton];
    //使用方法
    _useView = [[EditCellView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_classView.frame)+space, SCREEN_W, view_h) andTitle:@"使用方法" andDetailTitle:nil];
    [self.view addSubview:_useView];
    //添加按钮
    UIButton *useButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_useView.frame), CGRectGetHeight(_useView.frame))];
    useButton.backgroundColor = [UIColor clearColor];
    [useButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    useButton.tag = 107;
    [_useView addSubview:useButton];
}

-(void)initWithData{
    if (_currentProduct) {
        //产品图
        UIImage *productImg = [self imageWithBase64String:_currentProduct.base64ImgStr];
        _headImgView.image = productImg;
        //产品名称
        _nameView.detailLb.text = _currentProduct.name;
        //原价
        _priceView.detailLb.text = _currentProduct.price;
        //折扣
        if (![_currentProduct.discount isEqualToString:@""]) {
            _discountView.detailLb.text = [NSString stringWithFormat:@"%@折",_currentProduct.discount];
        }
        //折扣价
        _currentPriceView.detailLb.text = [self stringWithOldPrice:_currentProduct.price andDiscount:_currentProduct.discount];
        //产品属性
        _attributeView.detailLb.text = [NSString changeWithOldName:_currentProduct.attrib];
        //产品类别
//        NSString *gradeString = [self changeGradeByOldString:_currentProduct.grade];
        _classView.detailLb.text = [NSString stringWithFormat:@"%@产品",_currentProduct.grade];
        //使用方法
        _useView.detailLb.text = _currentProduct.useMethod;
    }
}

#pragma mark -- buttonAction
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick{
    //先判断产品是否有名字
    if ([_currentProduct.name isEqualToString:@""] || _currentProduct.name == nil) {
        [self showAlertViewWithText:@"产品名不能为空"];
    }else if ([_currentProduct.base64ImgStr isEqualToString:@""] || _currentProduct.base64ImgStr == nil){
        [self showAlertViewWithText:@"产品图片不能为空"];
    }else if ([_currentProduct.useMethod isEqualToString:@""] || _currentProduct.useMethod == nil){
        [self showAlertViewWithText:@"产品使用方法不能为空"];
    }else{
        if ([self.title isEqualToString:@"编辑"]) {
            //更新产品对象到数据库
            [self updateProductObject:_currentProduct];
            //更新
            for (int i=0; i<_globalProductsAry.count; i++) {
                ProductModel *globalProduct = [_globalProductsAry objectAtIndex:i];
                if (globalProduct.productId == _currentProduct.productId) {
                    [_globalProductsAry replaceObjectAtIndex:i withObject:_currentProduct];
                }
            }
        }else{ //新建产品
#warning 本地新建的产品没有产品id，即没有产品唯一标识
            //用创建的时间来作为唯一标识
            int timeId = [self currentDateInteger] ;
            _currentProduct.productId = timeId;
            //保存产品对象到数据库
            [self saveProductObject:_currentProduct];
            //新建
            [_globalProductsAry addObject:_currentProduct];
        }
        
        //协议数据回调
        if ([self.delegate respondsToSelector:@selector(savedEditProduct:withTitle:)]) {
            [self.delegate savedEditProduct:_currentProduct withTitle:self.title];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)typeButtonClick:(UIButton*)button{
    
    switch (button.tag) {
        case 100:
        {
//            [self openCamera];
            [self openCameraOrPhotoLibrary];
        }
            break;
        case 101:
        {
            [self pushToDetailVCWithTitle:@"产品名称" andContentText:_currentProduct.name andButtonTag:button.tag];
        }
            break;
        case 102:
        {
            [self pushToDetailVCWithTitle:@"原价" andContentText:_currentProduct.price andButtonTag:button.tag];
        }
            break;
        case 103:
        {
            [self pushToDetailVCWithTitle:@"折扣" andContentText:@"95" andButtonTag:button.tag];
        }
            break;
        case 104:
        {
//            pdvc.title = @"折扣价";
//            pdvc.buttonTag = button.tag;
        }
            break;
        case 105:
        {
            TypeViewController *tvc = [[TypeViewController alloc] init];
            tvc.delegate = self;
            NSArray *selectedArr = [self arrayWithAttribString:_currentProduct.attrib];
            tvc.title = @"产品属性";
            tvc.selectedArr = selectedArr;
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:tvc animated:YES];
            [self setHidesBottomBarWhenPushed:YES];
        }
            break;
        case 106:
        {
            CategoryViewController *cvc = [[CategoryViewController alloc] init];
            cvc.delegate = self;
            NSString *selectedStr = _currentProduct.grade;
            cvc.title = @"产品类型";
            cvc.selectCategoryStr = selectedStr;
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:cvc animated:YES];
            [self setHidesBottomBarWhenPushed:YES];
        }
            break;
        case 107:
        {
            [self pushToDetailVCWithTitle:@"使用方法" andContentText:_currentProduct.useMethod andButtonTag:button.tag];
        }
            break;
        default:
            break;
    }
    NSLog(@"点击的第%ld行",button.tag - 9);
}

-(void)pushToDetailVCWithTitle:(NSString *)title  andContentText:(NSString *)text andButtonTag:(NSUInteger)tag{
    M8ProductDetailViewController *pdvc = [[M8ProductDetailViewController alloc] init];
    pdvc.delegate = self;
    pdvc.title = title;
    pdvc.contentString = text;
    pdvc.buttonTag = tag;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:pdvc animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

//属性字符串转换为数组
-(NSArray *)arrayWithAttribString:(NSString *)string{
    NSArray *array = [string componentsSeparatedByString:@","];
    NSMutableArray *newArr = [[NSMutableArray alloc] initWithCapacity:7];
    if (array.count>0) {
        for (int i=0; i<array.count; i++) {
            NSString *oldFlag = [array objectAtIndex:i];
            if ([oldFlag isEqualToString:@"00"]) {
                [newArr addObject:@"补水类"];
            }
            if ([oldFlag isEqualToString:@"01"]) {
                [newArr addObject:@"淡斑类"];
            }
            if ([oldFlag isEqualToString:@"02"]) {
                [newArr addObject:@"清洁类"];
            }
            if ([oldFlag isEqualToString:@"03"]) {
                [newArr addObject:@"嫩肤类"];
            }
            if ([oldFlag isEqualToString:@"04"]) {
                [newArr addObject:@"抗衰老"];
            }
            if ([oldFlag isEqualToString:@"05"]) {
                [newArr addObject:@"修复类"];
            }
            if ([oldFlag isEqualToString:@"06"]) {
                [newArr addObject:@"保养类"];
            }
            
        }
    }
    return newArr;
}

//属性数组还原为产品对象属性 即： 00,01,02 类的字符串
-(NSString *)stringWithAttribArray:(NSArray *)array{
//    NSArray *array = [string componentsSeparatedByString:@","];
    NSMutableString *newString = [[NSMutableString alloc] initWithString:@""];;
    if (array.count>0) {
        for (int i=0; i<array.count; i++) {
            NSString *oldFlag = [array objectAtIndex:i];
            if ([oldFlag isEqualToString:@"补水类"]) {
                [newString appendString:@"00,"];
            }
            if ([oldFlag isEqualToString:@"淡斑类"]) {
                [newString appendString:@"01,"];
            }
            if ([oldFlag isEqualToString:@"清洁类"]) {
                [newString appendString:@"02,"];
            }
            if ([oldFlag isEqualToString:@"嫩肤类"]) {
                [newString appendString:@"03,"];
            }
            if ([oldFlag isEqualToString:@"抗衰老"]) {
                [newString appendString:@"04,"];
            }
            if ([oldFlag isEqualToString:@"修复类"]) {
                [newString appendString:@"05,"];
            }
            if ([oldFlag isEqualToString:@"保养类"]) {
                [newString appendString:@"06,"];
            }
        }
    }
    if (newString.length>0) {
        NSString *last = [newString substringFromIndex:newString.length-1];
        if ([last isEqualToString:@","]) {
            [newString deleteCharactersInRange:NSMakeRange(newString.length-1, 1)]; // 如果字符串最后一位是“,”则删除点号
        }
    }
    return newString;
}

#pragma mark - M8ProductDetailViewControllerDelegate
-(void)importWithString:(NSString *)detailTextStr andButtonTag:(NSUInteger)buttonTag{
    switch (buttonTag) {
//        case 100:
//        {
//            //头像
//        }
//            break;
        case 101:
        {
            _nameView.detailLb.text = detailTextStr;
            _currentProduct.name = detailTextStr;
        }
            break;
        case 102:
        {
            _priceView.detailLb.text = detailTextStr;
            _currentProduct.price = detailTextStr;
        }
            break;
        case 103:
        {
            _discountView.detailLb.text = [NSString stringWithFormat:@"%@折",detailTextStr];
            _currentProduct.discount = detailTextStr;
            if (![_currentProduct.price isEqualToString:@""] && _currentProduct.price != 0) {
                _currentPriceView.detailLb.text = [self stringWithOldPrice:_currentProduct.price andDiscount:_currentProduct.discount];
            }
        }
            break;
//        case 104:
//        {
//            _currentPriceView.detailLb.text = detailTextStr;
//        }
//            break;
//        case 105:
//        {
////            pdvc.title = @"产品属性";
//        }
//            break;
//        case 106:
//        {
////            pdvc.title = @"产品类别";
//        }
//            break;
        case 107:
        {
            _useView.detailLb.text = detailTextStr;
            _currentProduct.useMethod = detailTextStr;
        }
            break;
        default:
            break;
    }
}

-(NSString *)stringWithOldPrice:(NSString *)oldPrice andDiscount:(NSString *)discount{
    CGFloat discountFloat = [discount floatValue];
    CGFloat oldPrcieFloat = [oldPrice floatValue];
    CGFloat newPriceFloat = oldPrcieFloat * discountFloat/100;
    NSString *newPriceString = [NSString stringWithFormat:@"%.0f",newPriceFloat];
    return newPriceString;
}
#pragma mark -- TypeViewControllerDelegate
-(void)saveSelectedAttribArray:(NSArray *)array andSelectedIndex:(NSInteger)selectedIndex{
    //返回的对象类型属性
    NSString *attribStr = [self stringWithAttribArray:array];
    _currentProduct.attrib = attribStr;
    //将对象类型属性转换为界面显示的字符串
    _attributeView.detailLb.text = [NSString changeWithOldName:attribStr];
}

#pragma mark -- CategoryViewControllerDelegate
-(void)saveSelectedCategory:(NSString *)string{
    //返回的对象类型属性
    _currentProduct.grade = string;
    //将对象类型属性转换为界面显示的字符串
    _classView.detailLb.text = [NSString stringWithFormat:@"%@产品",_currentProduct.grade];
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
    _currentProduct.base64ImgStr = [NSString base64StringWithImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- base64String 转换为图片
-(UIImage *)imageWithBase64String:(NSString *)string{
    // 将base64字符串转为NSData
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:string options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    // 将NSData转为UIImage
    UIImage *decodedImage = [UIImage imageWithData: decodeData];
    return decodedImage;
}

#pragma mark -- 产品类别转换
//0--基础产品 1--中端产品 2--高端产品
-(NSString *)changeGradeByOldString:(NSString *)oldGrade{
    NSString *newString = @"基础";
    if ([oldGrade isEqualToString:@"1"]) {
        newString = @"中端";
    }else if ([oldGrade isEqualToString:@"2"]){
        newString = @"高端";
    }
    return newString;
}

#pragma mark -- 数据库
//保存产品
-(void)saveProductObject:(ProductModel *)model{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db saveProductData:model];
}
//更新产品
-(void)updateProductObject:(ProductModel *)model{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db updateProductData:model withID:_currentProduct.productId];
}

#pragma mark -- 获取当前时间作为创建的产品ID
//获取当前时间
- (int)currentDateInteger{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"hhmmss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
//    dateString = [dateString substringWithRange:NSMakeRange(5,6)];
    int dateInt = [dateString intValue];
    return dateInt;
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
