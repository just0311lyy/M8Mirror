//
//  MOPhotoShowViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/27.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "MOPhotoShowViewController.h"
#import "BottomPhotoShowView.h"
#import "M8ReportViewController.h"
//#import "MOCompareViewController.h"
#import "UIImage+category.h"
#import "FSCustomButton.h"
@interface MOPhotoShowViewController ()<BottomPhotoShowViewDelegate>
@property (strong, nonatomic) BottomPhotoShowView *bottomPhotoView;
@property (strong, nonatomic) UIImageView *bgImgView;
@end

@implementation MOPhotoShowViewController

- (void)viewWillAppear:(BOOL)animated{
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    //    [self initWithData];
    [self initWithView];
}

-(void)initWithNavBar{
    //    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x151515);
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithView{
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H)];
    _bgImgView.backgroundColor = UIColorFromRGB(0x151515);
//    _bgImgView.image = [UIImage imageWithBase64String:_currentShowReport.WLOfBase64String];
    _bgImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentShowReport.oneImgPathStr];
    [self.view addSubview:_bgImgView];
    
    //(640,480)
    CGFloat imgView_w = 48*2;
    CGFloat imgView_h = 64*2;
    CGFloat space = 10;
    NSInteger photoNumber = 3;
    CGFloat bottomView_w = imgView_w*photoNumber+space*(photoNumber-1);
    _bottomPhotoView = [[BottomPhotoShowView alloc] initWithFrame:CGRectMake((SCREEN_W - bottomView_w)/2,SCREEN_H - imgView_h - 2 * space,bottomView_w,imgView_h) andNumber:photoNumber];
    _bottomPhotoView.leftImgBtn.selected = YES;
    _bottomPhotoView.delegate = self;
    [_bottomPhotoView.leftImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentShowReport.oneImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.middleImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentShowReport.twoImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.rightImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentShowReport.threeImgPathStr] forState:UIControlStateNormal];
    [self.view addSubview:_bottomPhotoView];
    
    //对照分析
    CGFloat leftRightBtn_w = 100;
    UIImage *selectImg = [[UIImage scaleImage:[UIImage imageNamed:@"takephoto.png"] toSize:CGSizeMake(50, 50)] imageWithTintColor:[UIColor whiteColor]];
    //查看报告
    FSCustomButton *reportBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(SCREEN_W - leftRightBtn_w - 2*space,SCREEN_H - 2*space - leftRightBtn_w,leftRightBtn_w,leftRightBtn_w)];
    reportBtn.adjustsTitleTintColorAutomatically = YES;
    [reportBtn setTintColor:[UIColor whiteColor]];
    reportBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [reportBtn setTitle:@"检测" forState:UIControlStateNormal];
    [reportBtn setImage:selectImg forState:UIControlStateNormal];
    reportBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
    reportBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
    [reportBtn addTarget:self action:@selector(reportButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reportBtn];
}

#pragma mark - M8MainTitleViewDelegate
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)compareButtonAction{
//    MOCompareViewController *comparevc = [[MOCompareViewController alloc] init];
////    reportvc.title = @"客户报告";
//    comparevc.currentCompareCust = _currentShowCust;
//    comparevc.currentCompareReport = _currentShowReport;
//    [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:comparevc animated:YES];
//    [self setHidesBottomBarWhenPushed:YES];
//}

//进行检测
-(void)reportButtonAction{
    //保存当前检测结果到数据库
    [self saveReportObject:_currentShowReport];

    M8ReportViewController *reportvc = [[M8ReportViewController alloc] init];
    reportvc.title = @"客户报告";
    reportvc.isFromInstrument = YES;
    reportvc.currentCustomer = _currentShowCust;
    reportvc.currentReport = _currentShowReport;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:reportvc animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

#pragma mark - BottomPhotoShowView
-(void)bottomPhotoButtonClickWithTag:(NSInteger)btnTag{
    switch (btnTag) {
        case TAG_BOTTOM_MIDDLE:
            if (![_currentShowReport.twoImgPathStr isEqualToString:@""]) {
                _bgImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentShowReport.twoImgPathStr];
            }
            break;
        case TAG_BOTTOM_RIGHT:
            if (![_currentShowReport.threeImgPathStr isEqualToString:@""]) {
                _bgImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentShowReport.threeImgPathStr];
            }
            break;
        default:
            if (![_currentShowReport.oneImgPathStr isEqualToString:@""]) {
                _bgImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentShowReport.oneImgPathStr];
            }
            break;
    }
}

#pragma mark -- FMDB
-(void)updateReportObject:(ReportModel *)model{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db updateReportData:model withCustomerID:model.customerId andReportDate:model.reportDate];
}

-(void)saveReportObject:(ReportModel *)model{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db saveReportData:model];
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
