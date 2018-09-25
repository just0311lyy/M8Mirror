//
//  DownloadViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/27.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "DownloadViewController.h"
#import "ImagesSelectedViewController.h"
#import "DownViewCell.h"
//#import "LYXMLElement.h"
#import "XmlImgDownloadModel.h"
#import "ProductModel.h"
@interface DownloadViewController ()<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
@property (nonatomic, strong) NSArray *oneArr;
@property (nonatomic, strong) NSArray *twoArr;
@property (nonatomic, strong) NSArray *treeArr;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *xmlImgsResult; //存储图片请求解析的数组
//@property (nonatomic,assign) BOOL flag;
@property (nonatomic,strong) NSString *currentElement;
@property (nonatomic,strong) NSString *contentStr;
@property (nonatomic,strong) XmlImgDownloadModel *imgModel;

@property (nonatomic,strong) NSString *flagString; //区分图片请求还是产品请求解析
@property (nonatomic,strong) NSMutableArray *xmlProductsResult; //存储产品请求解析的数组
@property (nonatomic,strong) ProductModel *productModel;
@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    [self initWithProductNetData];
    [self initWithTable];
}

-(void)initWithNavBar{
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithProductNetData{
    _oneArr = [[NSArray alloc] initWithObjects:@"广告图下载",@"成功案例下载",@"最新消息下载", nil];
    _twoArr = [[NSArray alloc] initWithObjects:@"会议报告文档下载",@"产品建议文档下载", nil];
    _treeArr = [[NSArray alloc] initWithObjects:@"客户列表下载",@"产品列表下载", nil];
}

-(void)initWithTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H - 64) style:UITableViewStyleGrouped];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[DownViewCell class] forCellReuseIdentifier:@"downCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _oneArr.count;
    }else if(section == 1){
        return _twoArr.count;
    }else{
        return _treeArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"downCell";
    DownViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DownViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0) {
        cell.titleLb.text = [_oneArr objectAtIndex:indexPath.row];
    }else if(indexPath.section == 1){
        cell.titleLb.text = [_twoArr objectAtIndex:indexPath.row];
    }else{
        cell.titleLb.text = [_treeArr objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSArray *titles = @[@"广告图下载",@"广告图选择"];
            [self chooseAlertViewWithMessage:nil andActionTitles:titles];
        }
    }else if (indexPath.section == 1){
        
    }else{
        if (indexPath.row == 0) {
            //客户列表下载
            [self customersDownload];
        }else if(indexPath.row == 1){
            //产品列表下载
            [self productsDownload];
        }
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DownViewCell getCellHeight];
}

#pragma mark -- 请求--数据下载
//广告图下载
-(void)imagesDownloadWithUsername:(NSString *)username{
    NSDictionary *parameter = @{@"Username":username};
    [self startMBProgressHUDWithText:@"正在下载图片,请稍后..."];
    [[LYHTTPSManager sharedInstance] requestWithURLString:URL_IMAGES_DOWNLOAD parameters:parameter type:HttpRequestTypePost success:^(id data) {
        [self stopMBProgressHUD];
        NSString *downloadReturn = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"downloadReturn: %@", downloadReturn);
        NSData *dataDownReturn = [downloadReturn dataUsingEncoding:NSUTF8StringEncoding];
        [self XMLParserWithData:dataDownReturn andFlag:@"image"];
        if (_xmlImgsResult.count>0) {
            [self saveImageObjects:_xmlImgsResult];  //保存到广告图数据表
            [self showAlertViewWithText:@"下载完成"]; 
        }
    } failure:^(NSError *error) {
        [self stopMBProgressHUD];
        NSLog(@"Error: %@", error);
    }];
}
//服务器中根据属性请求回的产品列表
-(void)downloadProductByAttrib:(NSString *)attribStr withUsername:(NSString *)username{
    NSDictionary *parameter = @{@"Username":username,@"Cpsx":attribStr};
    [self startMBProgressHUDWithText:@"正在下载产品,请稍后..."];
    [[LYHTTPSManager sharedInstance] requestWithURLString:URL_PRODUCTS_ATTRIB_DOWNLOAD parameters:parameter type:HttpRequestTypePost success:^(id data) {
        [self stopMBProgressHUD];
        NSString *downloadReturn = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"downloadReturn: %@", downloadReturn);
        NSData *dataDownReturn = [downloadReturn dataUsingEncoding:NSUTF8StringEncoding];
        [self XMLParserWithData:dataDownReturn andFlag:@"product"];
        if (_xmlProductsResult.count>0) {
//            [self saveImageObjects:_xmlResult];
            //保存产品到全局数组
            [_globalProductsAry addObjectsFromArray:[self newGlobalWithProductObjects:_xmlProductsResult]];
            //发送产品列表刷新的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadProductList" object:nil];
            //保存到产品数据表
            [self saveProductObjects:_xmlProductsResult];
            [self showAlertViewWithText:@"下载完成"];
        }
    } failure:^(NSError *error) {
        [self stopMBProgressHUD];
        NSLog(@"Error: %@", error);
    }];
}

//客户列表
-(void)customersDownload{
    
}

//产品列表
-(void)productsDownload{
    [self chooseAttributeOfProductToDownload];
}

#pragma mark -- XMLParser解析
-(void)XMLParserWithData:(NSData *)data andFlag:(NSString *)flag{
    _flagString = flag;
    //1.创建NSXMLParser
    NSXMLParser *XMLParser = [[NSXMLParser alloc] initWithData:data];
    //2.设置代理
    [XMLParser setDelegate:self];
    //3.开始解析
    [XMLParser parse];
}
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    if ([_flagString isEqualToString:@"image"]) {
        self.xmlImgsResult = [[NSMutableArray alloc] initWithCapacity:10];
    }else if ([_flagString isEqualToString:@"product"]){
        self.xmlProductsResult = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
}

//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    // elementName是正在解析的元素的名字
    _currentElement = elementName;
    /**** 方法一：存对象 ****/
    if ([_flagString isEqualToString:@"image"]) {
        if ([self.currentElement isEqualToString:@"Table"]){
            _imgModel = [[XmlImgDownloadModel alloc] init];
            if (![[LYUserDefault loadUserNameCache] isEqualToString:@""]) {
                [_imgModel setUsername:[LYUserDefault loadUserNameCache]];
            }
        }
    }else if ([_flagString isEqualToString:@"product"]){
        if ([self.currentElement isEqualToString:@"Table"]){
            _productModel = [[ProductModel alloc] init];
            if (![[LYUserDefault loadUserNameCache] isEqualToString:@""]) {
                [_productModel setUserid:[LYUserDefault loadUserNameCache]];
            }
        }
    }
    
    
    /**** 方法二：存字典 ****/
    // 如果元素名字为Note，取出它的属性id
//    if ([_currentElement isEqualToString:@"Table"]) {
//        // 属性在attributeDict参数中传递过来，它是一个字典类型，其中的键的名字就是属性的名字，值是属性的值
//        NSString *_id = [attributeDict objectForKey:@"diffgr:id"];
//        NSMutableDictionary *dict = [NSMutableDictionary new];
//        [dict setObject:_id forKey:@"tableId"];
//        [_xmlResult addObject:dict];
//    }
}

// 解析文本,会多次解析，每次只解析1000个字符，如果多月1000个就会多次进入这个方法
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    // 剔除回车和空格
    // stringByTrimmingCharactersInSet：方法是剔除字符方法
    // [NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSLog(@"string:%@" , string);
    if ([string isEqualToString:@""]) {
        return;
    }
    
    /**** 方法一：存对象 ****/
    if ([_flagString isEqualToString:@"image"]) {
        if ([_currentElement isEqualToString:@"id"]) {
            [_imgModel setImageId:[string intValue]];
        }else if ([_currentElement isEqualToString:@"ggmc"]){
            [_imgModel setName:string];
        }else if ([_currentElement isEqualToString:@"putdate"]){
            [_imgModel setPutdate:string];
        }else if ([_currentElement isEqualToString:@"deptid"]){
            [_imgModel setDeptId:[string intValue]];
        }else if ([_currentElement isEqualToString:@"parlorid"]){
            [_imgModel setParlorId:[string intValue]];
        }
        //    else if ([_currentElement isEqualToString:@"userid"]){
        //        [_imgModel setDeptId:[string intValue]];
        //    }
        else if ([_currentElement isEqualToString:@"img"]){
            [_imgModel setImgOfBase64Str:string];
        }
    }else if ([_flagString isEqualToString:@"product"]){
        if ([_currentElement isEqualToString:@"id"]) {
            [_productModel setProductId:[string intValue]];
        }else if ([_currentElement isEqualToString:@"cpmc"]){
            [_productModel setName:string];
        }else if ([_currentElement isEqualToString:@"cpsx"]){
            [_productModel setAttrib:string];
        }else if ([_currentElement isEqualToString:@"cplb"]){
            [_productModel setGrade:string];
        }else if ([_currentElement isEqualToString:@"cpjg"]){
            [_productModel setPrice:string];
        }else if ([_currentElement isEqualToString:@"syff"]){
            [_productModel setUseMethod:string];
        }else if ([_currentElement isEqualToString:@"cptx"]){
            [_productModel setBase64ImgStr:string];
        }else if ([_currentElement isEqualToString:@"putdate"]){
            [_productModel setPutdate:string];
        }else if ([_currentElement isEqualToString:@"deptid"]){
            [_productModel setDeptid:[string intValue]];
        }else if ([_currentElement isEqualToString:@"parlorid"]){
            [_productModel setParlorid:[string intValue]];
        }
        //    else if ([_currentElement isEqualToString:@"userid"]){
        //        [_productModel setDeptId:string];
        //    }
        
    }
    

    /**** 方法二：存字典 ****/
//    NSMutableDictionary *dict = [_xmlResult lastObject];
//    if ([_currentElement isEqualToString:@"id"] && dict) {
//        [dict setObject:string forKey:@"id"];
//    }
//    if ([_currentElement isEqualToString:@"ggmc"] && dict) {
//        [dict setObject:string forKey:@"ggmc"];
//    }
//    if ([_currentElement isEqualToString:@"putdate"] && dict) {
//        [dict setObject:string forKey:@"putdate"];
//    }
//    if ([_currentElement isEqualToString:@"deptid"] && dict) {
//        [dict setObject:string forKey:@"deptid"];
//    }
//    if ([_currentElement isEqualToString:@"parlorid"] && dict) {
//        [dict setObject:string forKey:@"parlorid"];
//    }
//    if ([_currentElement isEqualToString:@"userid"] && dict) {
//        [dict setObject:string forKey:@"userid"];
//    }
//    if ([_currentElement isEqualToString:@"img"] && dict) {
//        [dict setObject:string forKey:@"img"];
//    }
}

////解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    // 清理刚才解析的元素的名字，以便于记录接下来解析的元素的名字
    if ([_flagString isEqualToString:@"image"]) {
        if ([elementName isEqualToString:@"Table"]) {
            [_xmlImgsResult addObject:_imgModel];
        }
    }else if ([_flagString isEqualToString:@"product"]){
        if ([elementName isEqualToString:@"Table"]) {
            [_xmlProductsResult addObject:_productModel];
        }
    }
    self.currentElement = nil;
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    _flagString = nil;
//    if (_xmlResult.count>0) {
//        for (int i=0; i<_xmlResult.count; i++) {
//            XmlImgDownloadModel *imgModel = [_xmlResult objectAtIndex:i];
//            NSLog(@"xmlResultCount:%lu,imgModle:%@",_xmlResult.count,imgModel);
//        }
//    }
}

#pragma mark - 进度条
//启动进度条
-(void)startMBProgressHUDWithText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
}
//关闭进度条
-(void)stopMBProgressHUD{
    [MBProgressHUD hideAllHUDsForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
}
#pragma mark - Button Action
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

//提示框
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
//广告图选择框
-(void)chooseAlertViewWithMessage:(NSString *)message andActionTitles:(NSArray *)titles{
    UIAlertController *alertView =
    [UIAlertController alertControllerWithTitle:message
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleAlert];
    if (titles.count>0) {
        for (int i=0; i<titles.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:[titles objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([[titles objectAtIndex:i] isEqualToString:@"广告图下载"]) {
                    //            NSString *username = [LYUserDefault loadUserNameCache];
                    NSString *username = @"skin02552";
                    if (![username isEqualToString:@""] && username != nil) {
                        [self imagesDownloadWithUsername:username];
                    }else{
                        [self showAlertViewWithText:@"未检测到有效用户名"];
                    }
                }else if ([[titles objectAtIndex:i] isEqualToString:@"广告图选择"]){
                    ImagesSelectedViewController *isvc = [[ImagesSelectedViewController alloc] init];
                    isvc.title = @"广告图选择";
                    [self setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:isvc animated:YES];
                    [self setHidesBottomBarWhenPushed:YES];
                }
            }];
            [alertView addAction:action];
        }
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [alertView addAction:cancelAction];
    [self presentViewController:alertView animated:YES completion:nil];
}
//产品属性选择框
-(void)chooseAttributeOfProductToDownload{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"属性" message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSArray *attribArr = @[@"补水类",@"淡斑类",@"清洁类",@"嫩肤类",@"抗衰老",@"修复类",@"保养类"];
    //  NSString *username = [LYUserDefault loadUserNameCache];
    NSString *username = @"skin02552";
    for (int i=0; i<attribArr.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[attribArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *attribStr;
            if ([[attribArr objectAtIndex:i] isEqualToString:@"补水类"]) {
                attribStr = @"00";
                [self downloadProductByAttrib:attribStr withUsername:username];
            }else if ([[attribArr objectAtIndex:i] isEqualToString:@"淡斑类"]){
                attribStr = @"01";
                [self downloadProductByAttrib:attribStr withUsername:username];
            }else if ([[attribArr objectAtIndex:i] isEqualToString:@"清洁类"]){
                attribStr = @"02";
                [self downloadProductByAttrib:attribStr withUsername:username];
            }else if ([[attribArr objectAtIndex:i] isEqualToString:@"嫩肤类"]){
                attribStr = @"03";
                [self downloadProductByAttrib:attribStr withUsername:username];
            }else if ([[attribArr objectAtIndex:i] isEqualToString:@"抗衰老"]){
                attribStr = @"04";
                [self downloadProductByAttrib:attribStr withUsername:username];
            }else if ([[attribArr objectAtIndex:i] isEqualToString:@"修复类"]){
                attribStr = @"05";
                [self downloadProductByAttrib:attribStr withUsername:username];
            }else if ([[attribArr objectAtIndex:i] isEqualToString:@"保养类"]){
                attribStr = @"06";
                [self downloadProductByAttrib:attribStr withUsername:username];
            }
        }];
        [alertView addAction:action];
        
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertView addAction:cancelAction];
    [self presentViewController:alertView animated:YES completion:nil];
}

//#pragma mark -- base64String 转换为图片
//-(UIImage *)imageWithBase64String:(NSString *)string{
//    // 将base64字符串转为NSData
//    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:string options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
//    // 将NSData转为UIImage
//    UIImage *decodedImage = [UIImage imageWithData: decodeData];
//    return decodedImage;
//}
#pragma mark - 保存产品到全局数组
-(NSArray *)newGlobalWithProductObjects:(NSArray *)array{
    NSMutableArray *newDownAry = [[NSMutableArray alloc] initWithCapacity:10];
    if (array.count>0) {
        for (int i = 0; i<array.count; i++) {
            ProductModel *newPro = [array objectAtIndex:i];
            //验证是否已经存在全局数组中
            if (![self checkObject:newPro inProductArray:_globalProductsAry]) {
                [newDownAry addObject:newPro];
            }
        }
    }
    return newDownAry;
}
        
//此产品是否已经存在于数组中
-(BOOL)checkObject:(ProductModel *)product inProductArray:(NSArray *)array{
    BOOL isCheck = NO;
    if (array.count>0) {
        for (int i=0; i<array.count; i++) {
            ProductModel *proModel = [array objectAtIndex:i];
            if (product.productId == proModel.productId) {
                isCheck = YES;
                break;
            }
        }
    }
    return isCheck;
}

#pragma mark -- 数据库
//保存图片
-(void)saveImageObjects:(NSArray *)array{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    for (int i = 0; i<[array count]; i++) {
        XmlImgDownloadModel *currentImgObject = [array objectAtIndex:i];
        [db saveAdvertImgData:currentImgObject];
    }
}
//保存产品
-(void)saveProductObjects:(NSArray *)array{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    for (int i = 0; i<[array count]; i++) {
        ProductModel *currentObject = [array objectAtIndex:i];
        [db saveProductData:currentObject];
    }
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
