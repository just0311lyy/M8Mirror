//
//  SugProductsShowViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/22.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "SugProductsShowViewController.h"
#import "ProductNetModel.h"
#import "ProductModel.h"
#import "SugProductViewCell.h"
#import "ReportProductsView.h"
#import "NSString+Wrapper.h"
#import "SugProductsManageViewController.h"

@interface SugProductsShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSMutableArray *tableArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat productSuggest_h;
@end

@implementation SugProductsShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    [self initWithProductsShowData];
    [self initWithProductsShowTable];
}

-(void)initWithNavBar{
    self.title = @"产品推荐";
    //导航栏右按钮
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarBtn setTitle:@"管理" forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(pushToProductsShowManageView) forControlEvents:UIControlEventTouchUpInside];
    rightBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithProductsShowData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //根据产品网络关系获取属性
        _tableArr = [[NSMutableArray alloc] initWithCapacity:10];
        ProductNetModel *netModel = [self getProductNetObjectById:_productNetId];
        if (netModel.productTypeArr.count>0) {
            for (int i = 0; i<netModel.productTypeArr.count; i++) {
                NSString *attrStr = [netModel.productTypeArr objectAtIndex:i];
                //所有产品中，筛选出包含此属性的产品
                for (int j = 0; j<_globalProductsAry.count; j++) {
                    ProductModel *proModel = [_globalProductsAry objectAtIndex:j];
                    if ([ProductModel isProduct:proModel haveAttribString:attrStr]) {
                        if ([proModel.grade isEqualToString:_productGrade]) {
                            //去除重复对象
                            if (![self checkObject:proModel inProductArray:_tableArr]) {
                                [_tableArr addObject:proModel];
                            }
                        }
                    }
                }
            }
        }
        NSLog(@"showArray:%@",_tableArr);
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [_tableView reloadData];
        });
    });
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

-(void)initWithProductsShowTable{
    //产品推荐 推荐个数 x 12*space + 每个的内容高度
    CGFloat space = 10;
    CGFloat font = 20;
    NSString *suggestion = @"         由于皮脂腺活跃，皮脂分泌旺盛，毛囊皮脂腺导管角化异常，面部出油、粉刺、青春痘等问题会一直伴随着你。建议护肤时注意面部清洁和防晒，生活中注意作息规律，饮食清淡。";
    NSString *suggestTitle = @"痘痘/痘印8个";
    NSInteger problemNumber = 53;
    if (_productNetId == 111) {
        suggestion = @"         建议使用温和控油的洁面产品，早晚两次定期清理洁面部尤其是T区的油脂，缓解油脂氧化形成黑头的速度。U区则推荐使用温和滋润型的洁面产品。";
        suggestTitle = @"毛孔1028个";
        problemNumber = 65;
    }
    CGFloat suggestion_h = [NSString calculateRowHeightWithString:suggestion andWidth:(SCREEN_W-2*space) fontSize:font];
    _productSuggest_h = 13*space + suggestion_h;
    
    ReportProductsView *seggestView = [[ReportProductsView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W,_productSuggest_h) withNumber:nil andContentHeight:suggestion_h andContentFont:font];
    seggestView.titleLb.text = suggestTitle;
    seggestView.percentLb.text = [NSString stringWithFormat:@"%ld\u7684的人都有相同的困扰",problemNumber];
    seggestView.detailLb.text = suggestion;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[SugProductViewCell class] forCellReuseIdentifier:@"sugProShowCell"];
    [_tableView setTableHeaderView:seggestView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"sugProShowCell";
    SugProductViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    ProductModel *model = [_tableArr objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.name;
    cell.detailLabel.text = model.useMethod;
    cell.priceLabel.text = model.price;
//    if (model.base64ImgStr) {
//        cell.imgView.image = [self imageWithBase64String:model.base64ImgStr];
//    }
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    ProductNetModel *proModel = [_tableArr objectAtIndex:indexPath.section];
//    TypeViewController *tvc = [[TypeViewController alloc] init];
//    [self setHidesBottomBarWhenPushed:YES];
//    tvc.title = proModel.typeName;
//    tvc.selectedIndex = indexPath.section;
//    tvc.delegate = self;
//    tvc.selectedArr = proModel.productTypeArr;
//    [self.navigationController pushViewController:tvc animated:YES];
//    [self setHidesBottomBarWhenPushed:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _productSuggest_h;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return CGFLOAT_MIN;
//}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SugProductViewCell getCellHeight];
}

#pragma mark - Button Action
//取消按钮
-(void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存按钮
- (void)pushToProductsShowManageView{
    SugProductsManageViewController *spmvc = [[SugProductsManageViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:spmvc animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

#pragma mark -- 数据库相关
-(ProductNetModel *)getProductNetObjectById:(NSInteger)productNetId{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    ProductNetModel *model = [db getProductNetDataByProductNetId:productNetId];
    return model;
}

//将属性00,01……等转换为中文数组
//-(NSArray *)arrayWithAttrString:(NSString *)string{
//    NSArray *array = [string componentsSeparatedByString:@","];
//    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:8];
//    if (array.count>0) {
//        for (int i=0; i<array.count; i++) {
//            NSString *oldFlag = [array objectAtIndex:i];
//            if ([oldFlag isEqualToString:@"00"]) {
//                [newArray addObject:@"补水类"];
//            }
//            if ([oldFlag isEqualToString:@"01"]) {
//                [newArray addObject:@"淡斑类"];
//            }
//            if ([oldFlag isEqualToString:@"02"]) {
//                [newArray addObject:@"清洁类"];
//            }
//            if ([oldFlag isEqualToString:@"03"]) {
//                [newArray addObject:@"嫩肤类"];
//            }
//            if ([oldFlag isEqualToString:@"04"]) {
//                [newArray addObject:@"抗衰老"];
//            }
//            if ([oldFlag isEqualToString:@"05"]) {
//                [newArray addObject:@"修复类"];
//            }
//            if ([oldFlag isEqualToString:@"06"]) {
//                [newArray addObject:@"保养类"];
//            }
//        }
//    }
//    return newArray;
//
//}

#pragma mark -- base64String 转换为图片
-(UIImage *)imageWithBase64String:(NSString *)string{
    // 将base64字符串转为NSData
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:string options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    // 将NSData转为UIImage
    UIImage *decodedImage = [UIImage imageWithData: decodeData];
    return decodedImage;
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
