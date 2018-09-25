//
//  M8CustomerDetailViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/10.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8CustomerDetailViewController.h"
#import "M8CustomerEditViewController.h"
#import "M8ReportViewController.h"
#import "MOCameraViewController.h"

#import "MOCompareViewController.h"

#import "UIImage+category.h"
#import "CustomerDetailCell.h"
#import "ImageWithStringView.h"
#import "ReportModel.h"



#define DELETE_TAG 100
@interface M8CustomerDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CustomerDetailCellDelegate,M8CustomerEditViewControllerDelegate>
@property (nonatomic ,strong) UIImageView *headImgView;  //头像
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) ImageWithStringView *birthView;
@property (nonatomic ,strong) ImageWithStringView *phoneView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *recordsArr;

@end

@implementation M8CustomerDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去除导航栏下方的横线
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.barTintColor = LOGO_COLOR;
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户档案";
    [self initWithNavBar];
    [self initWithData];
    [self initWithDetailView];
    
}

-(void)initWithNavBar{
    //导航栏右按钮
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarBtn setTitle:@"编辑" forState:UIControlStateNormal];
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

-(void)initWithData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        NSArray *dataArray = [ReportModel getReportModelData];
#warning 真实数据
//        NSArray *dataArray = [self getAllReportObjectsFrom:_detailModel.customerId];
        NSMutableArray *custReportAry = [[NSMutableArray alloc] initWithCapacity:10];
        if (dataArray.count>0) {
            for (int i=0;i < dataArray.count; i++) {
                ReportModel *model = [dataArray objectAtIndex:i];
                if (model.customerId == _detailModel.customerId) {
                    [custReportAry addObject:model];
                }
            }
        }
        NSArray *arr = [self arraySortDesArray:custReportAry];
        //    for (int j=0; j<arr.count; j++) {
        //        ReportModel *currentReport = [arr objectAtIndex:j];
        //        NSLog(@"arr[%d]:日期:%@",j,currentReport.reportDate);
        //    }
        _recordsArr = [[NSMutableArray alloc] init];
        [_recordsArr addObjectsFromArray:arr];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [_tableView reloadData];
        });
    });
}

-(void)initWithDetailView{
    CGFloat head_H = SCREEN_H/2;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, head_H-20)];
    headView.backgroundColor =UIColorFromRGB(0xedf0f3);
    [self.view addSubview:headView];
    //头部蓝色背景
    CGFloat bg_h = head_H/4;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, bg_h)];
    bgView.backgroundColor = LOGO_COLOR;
    [headView addSubview:bgView];
    //头像
    CGFloat img_h = 2 * head_H / 5;
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_W - img_h)/2,10, img_h, img_h)];
    _headImgView.image = [UIImage imageWithBase64String:_detailModel.headImgOfBase64String];
    _headImgView.layer.cornerRadius = img_h/2;
    _headImgView.layer.borderWidth = 5;
    _headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headImgView.layer setMasksToBounds:YES];
    [headView addSubview:_headImgView];
    //客户姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_W - CGRectGetWidth(_headImgView.frame))/2,CGRectGetMaxY(_headImgView.frame) + 10, CGRectGetWidth(_headImgView.frame),50)];
    _nameLabel.font = [UIFont systemFontOfSize:28];
    _nameLabel.text = _detailModel.name;
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nameLabel setNumberOfLines:0];
    [_nameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [headView addSubview:_nameLabel];
    //客户生日
    CGFloat number_w = 180;
    _birthView =[[ImageWithStringView alloc] initWithFrame:CGRectMake(SCREEN_W/2 - number_w, CGRectGetMaxY(_nameLabel.frame) + 5,number_w, CGRectGetHeight(_nameLabel.frame)) andImage:[UIImage imageNamed:@"birthday.png"]];
    _birthView.numberLb.text = _detailModel.birthday;
    [headView addSubview:_birthView];
    //客户电话
    _phoneView =[[ImageWithStringView alloc] initWithFrame:CGRectMake(SCREEN_W/2+10, CGRectGetMinY(_birthView.frame), number_w, CGRectGetHeight(_birthView.frame)) andImage:[UIImage imageNamed:@"phone.png"]];
    _phoneView.numberLb.text = _detailModel.phoneNumber;
    [headView addSubview:_phoneView];
    //新检测按钮
    UIButton *instrumentBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_W - img_h)/2, CGRectGetMaxY(_phoneView.frame) + 10,img_h,50)];
    [headView addSubview:instrumentBtn];
    [instrumentBtn setTitle:@"新检测" forState:UIControlStateNormal];
    [instrumentBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [instrumentBtn setBackgroundColor:LOGO_COLOR];
    [instrumentBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]];
    [instrumentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    instrumentBtn.layer.cornerRadius = 25;
    [instrumentBtn.layer setMasksToBounds:YES];
    [instrumentBtn addTarget:self action:@selector(instrumentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //检测记录标题
    CGFloat record_h = 60;
    UIView *recordView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetHeight(headView.frame) - record_h - 1, SCREEN_W, record_h)];
    recordView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:recordView];
    UILabel *recordLb = [[UILabel alloc] initWithFrame:CGRectMake(20,0,SCREEN_W - 10, record_h)];
    recordLb.text = @"检测记录";
    recordLb.font = [UIFont systemFontOfSize:24];
    [recordLb setTextAlignment:NSTextAlignmentLeft];
    [recordLb setNumberOfLines:0];
    [recordLb setLineBreakMode:NSLineBreakByWordWrapping];
    [recordView addSubview:recordLb];
    //检测记录表
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), SCREEN_W, head_H - 64 + 20) style:UITableViewStylePlain];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CustomerDetailCell class] forCellReuseIdentifier:@"detailCell"];
        [self.view addSubview:_tableView];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recordsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"detailCell";
    CustomerDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomerDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    ReportModel *model = [_recordsArr objectAtIndex:indexPath.row];
    cell.timeLb.text = [model.reportDate substringWithRange:NSMakeRange(0,10)];
    if (model.oneImgPathStr) {
        cell.WLImgView.image = [[UIImage alloc] initWithContentsOfFile:model.oneImgPathStr];    
    }
    if (model.twoImgPathStr) {
        cell.PFLHImgView.image = [[UIImage alloc] initWithContentsOfFile:model.twoImgPathStr];
    }
    if (model.threeImgPathStr) {
        cell.HSQImgView.image = [[UIImage alloc] initWithContentsOfFile:model.threeImgPathStr];
    }
    if (model.fourImgPathStr) {
        cell.ZSQImgView.image = [[UIImage alloc] initWithContentsOfFile:model.fourImgPathStr];
    }
    if (model.fiveImgPathStr) {
        cell.ZWXBImgView.image = [[UIImage alloc] initWithContentsOfFile:model.fiveImgPathStr];
    }
    if (model.sixImgPathStr) {
        cell.SIXImgView.image = [[UIImage alloc] initWithContentsOfFile:model.sixImgPathStr];
    }
    if (model.sevenImgPathStr) {
        cell.SEVENImgView.image = [[UIImage alloc] initWithContentsOfFile:model.sevenImgPathStr];
    }
    if (model.eightImgPathStr) {
        cell.EIGHTImgView.image = [[UIImage alloc] initWithContentsOfFile:model.eightImgPathStr];
    }
    if (model.nineImgPathStr) {
        cell.NINEImgView.image = [[UIImage alloc] initWithContentsOfFile:model.nineImgPathStr];
    }

    cell.delegate = self;
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //
//    M8ReportViewController *reportvc = [[M8ReportViewController alloc] init];
//    reportvc.dateStr = @"客户报告";
//    reportvc.currentCustomer = _detailModel;
//    [self presentViewController:reportvc animated:nil completion:nil];
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 从数据源中删除
////    [_data removeObjectAtIndex:indexPath.row];
//    // 从列表中删除
////    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_recordsArr removeObjectAtIndex:indexPath.row];
//        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//    [self.tableView reloadData];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CustomerDetailCell getCellHeight];
}

#pragma mark - buttonAction
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//编辑按钮
- (void)rightButtonClick {
    M8CustomerEditViewController *editVC = [[M8CustomerEditViewController alloc] init];
    editVC.currentCustomer = _detailModel;
    editVC.title = @"编辑";
    editVC.delegate = self;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:editVC animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

//新检测按钮
-(void)instrumentButtonClick{
    NSLog(@"调用相机拍照");
    //检测是否连接摄像头wifi
    [self showAlertViewWithText:@"请确定网络已经切换到摄像头wifi下"];
    //推出拍照页
    [self pushToTakePhotoView];
    
//    MOCompareViewController *comparevc = [[MOCompareViewController alloc] init];
//    //    reportvc.title = @"客户报告";
////    comparevc.currentCompareCust = _detailModel;
////    comparevc.currentCompareReport = model;
//    [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:comparevc animated:YES];
//    [self setHidesBottomBarWhenPushed:YES];
}

-(void)pushToTakePhotoView{
    MOCameraViewController *cameraVC = [[MOCameraViewController alloc] init];
    cameraVC.currentCust = _detailModel;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cameraVC animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

-(void)pushToCameraWifiSet{
    NSString * urlString = @"App-Prefs:root=WIFI";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]){
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
}

//提示框
-(void)showAlertViewWithText:(NSString *)txt{
    UIAlertController *alertView =
    [UIAlertController alertControllerWithTitle:@"提示"
                                        message:txt
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"是的,我确定"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       //推出拍照页
                                                       [self pushToTakePhotoView];
                                                   }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"没有,现在设置"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [self pushToCameraWifiSet];
                                                   }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil];
    [alertView addAction:sureAction];
    [alertView addAction:setAction];
    [alertView addAction:cancelAction];
    [self presentViewController:alertView animated:YES completion:nil];
}

#pragma mark -- 数组排序方法（降序）
- (NSArray *)arraySortDesArray:(NSArray *)array{
    NSComparator cmptr = ^(ReportModel *obj1, ReportModel *obj2){
        if ([[obj1.reportDate stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue] > [[obj2.reportDate stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([[obj1.reportDate stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue] < [[obj2.reportDate stringByReplacingOccurrencesOfString:@"-" withString:@""] integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    NSArray *sorArray = [array sortedArrayUsingComparator:cmptr];
    return sorArray;
}

#pragma mark -- CustomerDetailCellDelegate
-(void)deleteButtonClick:(UIButton *)button{
    // 获取'删除按钮'所在的cell
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    // 获取cell的indexPath
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    ReportModel *model = [_recordsArr objectAtIndex:indexPath.row];
    //3.先删除数据，再删除本行cell
    [_recordsArr removeObject:model];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //4.从数据库删除此数据
    [self deleteReportObjectByCustomerID:_detailModel.customerId andReportDate:model.reportDate];
    [self.tableView reloadData];
}

-(void)reportViewButtonClick:(UIButton *)button{
    M8ReportViewController *reportvc = [[M8ReportViewController alloc] init];
    // 获取'edit按钮'所在的cell
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    // 获取cell的indexPath
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
//    NSLog(@"点击的是第%zd行",indexPath.row + 1);
    ReportModel *model = [_recordsArr objectAtIndex:indexPath.row];
    reportvc.title = @"客户报告";
    reportvc.isFromInstrument = NO;
    reportvc.currentCustomer = _detailModel;
    reportvc.currentReport = model;
    // 跳转
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:reportvc animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

-(void)openMLCamera{
    
    
    
}

#pragma mark -- M8CustomerEditViewControllerDelegate
-(void)savedEditCustomer:(customerModel *)customer withTitle:(NSString *)title{
    _headImgView.image = [UIImage imageWithBase64String:customer.headImgOfBase64String];
    _nameLabel.text = customer.name;
    _birthView.numberLb.text = customer.birthday;
    _phoneView.numberLb.text = customer.phoneNumber;
    
    //发送通知，通知客户列表页和首页刷新列表
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustomerList" object:nil];
}

#pragma mark -- FMDB
-(NSArray *)getAllReportObjectsFrom:(NSInteger)customerId{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    NSArray *array = [db getAllReportsOfCustomerID:customerId];
    return array;
}

-(void)deleteReportObjectByCustomerID:(NSInteger)customerId andReportDate:(NSString *)reportDate{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db deleteReportByCustomerID:customerId andReportDate:reportDate];
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
