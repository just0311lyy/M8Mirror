//
//  M8MProductEditViewController.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/5.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "M8MProductEditViewController.h"
#import "M8ProductDetailViewController.h"
#import "TypeViewController.h"
#import "CategoryViewController.h"
//#import "EditCellView.h"
#import "NSString+Wrapper.h"
#import "ProductInfoModel.h"
#import "ProductEditInfoCell.h"
#import "YylPathManager.h"
#import "NSDate+YylCategory.h"
#import "SQLProductDataOperation.h"

@interface M8MProductEditViewController ()<UITableViewDataSource,UITableViewDelegate,M8ProductDetailViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TypeViewControllerDelegate,CategoryViewControllerDelegate>
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UITableView *pInfoTableView;
@property (nonatomic, strong) NSMutableArray *pInfoShowArray;



@property (nonatomic ,strong) UIImageView *headImgView;  //产品图片
//@property (nonatomic ,strong) EditCellView *nameView; //产品名称
//@property (nonatomic ,strong) EditCellView *priceView; //原价
//@property (nonatomic ,strong) EditCellView *discountView; //折扣
//@property (nonatomic ,strong) EditCellView *currentPriceView; //折扣价
//@property (nonatomic ,strong) EditCellView *attributeView;  //产品属性
//@property (nonatomic ,strong) EditCellView *classView;   //产品类别
//@property (nonatomic ,strong) EditCellView *useView; //使用方法
@end

@implementation M8MProductEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initNavBar{
    [super initNavBar];
    [_rightNavBarBtn setTitle:@"保存" forState:UIControlStateNormal];
}

-(void)initData{
    [super initData];
}

-(void)initView{
    [super initView];
    [self.view addSubview:self.pInfoTableView];
    _pInfoTableView.tableHeaderView = self.tableHeaderView;

    
}

#pragma mark -- **** 列表 TableViewDataSource *****
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pInfoShowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"FaceImproveInfoCell";
    ProductEditInfoCell *cell = (ProductEditInfoCell *)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ProductEditInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    ProductInfoModel *infoModel = nil;
    if (self.pInfoShowArray.count>0) {
        infoModel = [self.pInfoShowArray objectAtIndex:indexPath.row];
    }
    [cell setPICellModel:infoModel];
    return  cell;
}

#pragma mark -- **** 列表点击 UITableViewDelegate ****
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITextField *nameTextField = nil;
    UITextField *originalPriceTextField = nil;
    UITextField *discountTextField = nil;
    UITextField *discountPriceTextField = nil;
    UITextField *attributeTextField = nil;
    UITextField *classTextField = nil;
    UITextField *useMethodTextField = nil;
    for (int i = 0; i < self.pInfoShowArray.count; i++) {
        ProductInfoModel *model = self.pInfoShowArray[i];
        switch (model.productInfoType) {
            case ProductInfoTypeName:
                nameTextField = model.contentTextField;
                break;
            case ProductInfoTypeOriginalPrice:
                originalPriceTextField = model.contentTextField;
                break;
            case ProductInfoTypeDiscount:
                discountTextField = model.contentTextField;
                break;
            case ProductInfoTypeDiscountPrice:
                discountPriceTextField = model.contentTextField;
                break;
            case ProductInfoTypeAttribute:
                attributeTextField = model.contentTextField;
                break;
            case ProductInfoTypeClass:
                classTextField = model.contentTextField;
                break;
            case ProductInfoTypeUseMethod:
                useMethodTextField = model.contentTextField;
                break;
            default:
                break;
        }
    }
    
    [nameTextField resignFirstResponder];
    [originalPriceTextField resignFirstResponder];
    [discountTextField resignFirstResponder];
    [discountPriceTextField resignFirstResponder];
    [attributeTextField resignFirstResponder];
    [classTextField resignFirstResponder];
    [useMethodTextField resignFirstResponder];
    
    if (indexPath.row == 6){
        //产品类别
//        NSArray * arr = @[@"身份证",@"女"];
//        [ActionSheetStringPicker showPickerWithTitle:@"选择证件类型" rows:arr initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//
//            FaceImproveInfoModel * model = self.improveInfoArray[1];
//            model.contentLabel.text = selectedValue;
//
//        } cancelBlock:nil origin:self.view ];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ProductEditInfoCell getProductEditInfoCellHeight];
}

#pragma mark - buttonAction
//返回按钮
-(void)leftNavBarButtonClick{
    NSLog(@"点击了左导航按钮");
    [self.navigationController popViewControllerAnimated:YES];
}
//编辑按钮
- (void)rightNavBarButtonClick {
    NSLog(@"点击了右导航按钮");
    UITextField *nameTextField = nil;
    UITextField *originalPriceTextField = nil;
    UITextField *discountTextField = nil;
    UITextField *discountPriceTextField = nil;
    UITextField *attributeTextField = nil;
    UITextField *classTextField = nil;
    UITextField *useMethodTextField = nil;
    for (int i = 0; i < self.pInfoShowArray.count; i++) {
        ProductInfoModel *model = self.pInfoShowArray[i];
        if (model.productInfoType == ProductInfoTypeName) {
            nameTextField = model.contentTextField;
        }
        if (model.productInfoType == ProductInfoTypeOriginalPrice) {
            originalPriceTextField = model.contentTextField;
        }
        if (model.productInfoType == ProductInfoTypeDiscount) {
            discountTextField = model.contentTextField;
            
        }
        if (model.productInfoType == ProductInfoTypeDiscountPrice) {
            discountPriceTextField = model.contentTextField;
        }
        if (model.productInfoType == ProductInfoTypeAttribute) {
            attributeTextField = model.contentTextField;
        }
        if (model.productInfoType == ProductInfoTypeClass) {
            classTextField = model.contentTextField;
        }
        if (model.productInfoType == ProductInfoTypeUseMethod) {
            useMethodTextField = model.contentTextField;
        }
    }
    //判断合法性
    BOOL isNameFilled = (nameTextField.text.length > 0 )?YES:NO;
    BOOL isOriginalPriceFilled = (originalPriceTextField.text.length > 0 )?YES:NO;
    BOOL isDiscountFilled = (discountTextField.text.length > 0 )?YES:NO;
    BOOL isDiscountPriceFilled = (discountPriceTextField.text.length > 0 )?YES:NO;
    BOOL isAttributeFilled = (attributeTextField.text.length > 0 )?YES:NO;
    BOOL isClassFilled = (classTextField.text.length > 0 )?YES:NO;
    BOOL isUseMethodFilled = (useMethodTextField.text.length > 0 )?YES:NO;
    if (!isNameFilled) {
        [YylToast showWithText:@"产品名不能为空" duration:3];
    }else if ([_currentProduct.imgDocumentPath isEqualToString:@""] || _currentProduct.imgDocumentPath == nil){
        [YylToast showWithText:@"产品图片不能为空" duration:3];
    }else if (!isUseMethodFilled){
        [YylToast showWithText:@"产品使用方法不能为空" duration:3];
    }else{
        if (self.controllerType == ProductEditTypeNewCreat) {
            //用创建的时间来作为唯一标识
            int timeId = [self currentDateInteger] ;
            _currentProduct.productId = timeId;
        }
        //更新产品对象到数据库
        [self updateProductObject:_currentProduct];
        if (self.productEditBlock) {
            self.productEditBlock(self.currentProduct,self.controllerType);
            
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)tableHeaderViewClick{
    [self openCameraOrPhotoLibrary];
}

//按钮点击事件
-(void)typeButtonClick:(UIButton*)button{
    
    switch (button.tag) {
        case 100:
        {
            //            [self openCamera];
            [self openCameraOrPhotoLibrary];
        }
            break;
        case 105:
        {
//            TypeViewController *tvc = [[TypeViewController alloc] init];
//            tvc.delegate = self;
//            NSArray *selectedArr = [self arrayWithAttribString:_currentProduct.attrib];
//            tvc.title = @"产品属性";
//            tvc.selectedArr = selectedArr;
//            [self setHidesBottomBarWhenPushed:YES];
//            [self.navigationController pushViewController:tvc animated:YES];
//            [self setHidesBottomBarWhenPushed:YES];
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
//            [self pushToDetailVCWithTitle:@"使用方法" andContentText:_currentProduct.useMethod andButtonTag:button.tag];
        }
            break;
        default:
            break;
    }
    NSLog(@"点击的第%ld行",button.tag - 9);
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
    //将图片压缩处理
    UIImage *finalIamge = [[[UIImage alloc] init] newSizeImage:CGSizeMake(60, 60*image.size.height/image.size.width) image:image];
    //保存压缩后的图片到沙盒目录
    NSString *documentPathStr = [[YylPathManager shareYylPathManager] getDocumentPath];
    //获取当前时间字符串作为图片名
    NSString *timeOfImgStr = [[NSDate date] yyl_yyyyMMddHHmmssString];
    documentPathStr = [documentPathStr stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",timeOfImgStr]];
    //保存文件的名称
    BOOL imageSaveResult = [UIImageJPEGRepresentation(finalIamge, 1) writeToFile:documentPathStr atomically:YES];
    
    _headImgView.image = finalIamge;
//    _currentProduct.base64ImgStr = [NSString base64StringWithImage:image];
    if(imageSaveResult){
        _currentProduct.imgDocumentPath = documentPathStr;
    }else{
        [YylToast showWithText:@"产品图片存储到内存失败" duration:2];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- **** 懒加载 ****
-(UITableView *)pInfoTableView{
    CGRect pInfoTableRect = CGRectMake(0,B_NavBarHeight, SCREEN_W,SCREEN_H - B_NavBarHeight);
    if (!_pInfoTableView) {
        _pInfoTableView = [[UITableView alloc] initWithFrame:pInfoTableRect style:UITableViewStylePlain];
        [_pInfoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _pInfoTableView.backgroundColor = UIColorFromRGB(0xF3F3F3);
        _pInfoTableView.delegate = self;
        _pInfoTableView.dataSource = self;
        _pInfoTableView.tableHeaderView = [UIView new];
    }
    return _pInfoTableView;
}

-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        //头像
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,B_NavBarHeight + GetLogicPixelX(20), SCREEN_W,GetLogicPixelX(14) + GetLogicPixelX(100) + GetLogicPixelX(20))];
        _tableHeaderView.backgroundColor = UIColorFromRGB(0xefeff4);
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, GetLogicPixelX(14), CGRectGetWidth(_tableHeaderView.frame), GetLogicPixelX(100))];
        whiteView.backgroundColor = [UIColor whiteColor];
        [_tableHeaderView addSubview:whiteView];
        
        UILabel *headLb = [[UILabel alloc] initWithFrame:CGRectMake(GetLogicPixelX(30), (CGRectGetHeight(_tableHeaderView.frame) - GetLogicPixelX(40))/2, GetLogicPixelX(100),GetLogicPixelX(40))];
        [headLb setFont:[UIFont systemFontOfSize:GetLogicFont(11)]];
        [headLb setText:@"产品图片"];
        [headLb setTextAlignment:NSTextAlignmentLeft];
        [headLb setNumberOfLines:0];
        [headLb setLineBreakMode:NSLineBreakByWordWrapping];
        [_tableHeaderView addSubview:headLb];
        //箭头23x42
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - GetLogicPixelX(30) - GetLogicPixelX(24)*23/42, (CGRectGetHeight(_tableHeaderView.frame) - GetLogicPixelX(24))/2, GetLogicPixelX(24)*23/42,GetLogicPixelX(24))];
        arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
        [_tableHeaderView addSubview:arrowImgView];
        //产品图片
        CGFloat head_w = 80;
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - GetLogicPixelX(30) - CGRectGetWidth(arrowImgView.frame) - head_w, (CGRectGetHeight(_tableHeaderView.frame) - GetLogicPixelX(70))/2,GetLogicPixelX(70), GetLogicPixelX(70))];
        _headImgView.image = [UIImage imageNamed:@"default_head.png"]; //default_head.png
        [_tableHeaderView addSubview:_headImgView];
        //添加按钮
        UITapGestureRecognizer *tableHeaderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCameraOrPhotoLibrary)];
        tableHeaderTap.cancelsTouchesInView = NO; //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        [_tableHeaderView addGestureRecognizer:tableHeaderTap];
    }
    return _tableHeaderView;
}

-(NSMutableArray *)pInfoShowArray{
    if (!_pInfoShowArray) {
        _pInfoShowArray = [NSMutableArray arrayWithCapacity:10];
        [_pInfoShowArray addObjectsFromArray:[ProductInfoModel arrayWithProductInfoModels]];
    }
    return _pInfoShowArray;
}

#pragma mark -- *** 数据库 ***
//更新产品
-(void)updateProductObject:(ProductModel *)model{
    SQLProductDataOperation *db = [SQLProductDataOperation shareSQLProductDataOperation];
    if ([db openDatabase]) {
        ProductModel *model = [db updateSourceData:model];
        NSLog(@"更新的产品id:%d",model.productId);
    }
}

#pragma mark -- *** 获取当前时间作为创建的产品ID ***
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
