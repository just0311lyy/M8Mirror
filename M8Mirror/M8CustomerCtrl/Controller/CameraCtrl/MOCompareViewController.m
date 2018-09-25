//
//  MOCompareViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/28.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "MOCompareViewController.h"
#import "BottomPhotoCompareView.h"
#import "CompareTimesViewCell.h"
#import "BottomThreeBtnView.h"

@interface MOCompareViewController ()<BottomPhotoCompareViewDelegate,UITableViewDelegate,UITableViewDataSource,BottomThreeBtnViewDelegate>
//@property (strong, nonatomic) UIImageView *leftImgView;
//@property (strong, nonatomic) UIImageView *rightImgView;
@property (assign, nonatomic) CGFloat original_x;   //中间线初始坐标
@property (assign, nonatomic) CGFloat original_y;
@property (strong, nonatomic) UIScrollView *leftImgScrollView;

//@property (strong, nonatomic) UIButton *rightBarBtn;
@property (strong, nonatomic) BottomThreeBtnView *bottomBtnView;
@property (strong, nonatomic) UIButton *currentTimeBtn;
@property (strong, nonatomic) UIButton *timeSelectedBtn;
@property (strong, nonatomic) BottomPhotoCompareView *bottomPhotoView;
@property (strong, nonatomic) UIImageView *leftImgView;
@property (strong, nonatomic) UIImageView *rightImgView;
@property (strong, nonatomic) NSMutableArray *timeAry;
@property(nonatomic,strong) UITableView *tableView;

@property (strong, nonatomic) ReportModel *selectedReport;
@end

@implementation MOCompareViewController
bool canLeft   = true;
bool canRight  = true;

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
    [self initWithData];
    [self initWithView];
}

-(void)initWithNavBar{
    //    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x151515);
    self.title = @"对照分析";
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
//        NSMutableArray *dataArray = [ReportModel getReportModelData]; //demo
#warning 真实数据
        NSArray *dataArray = [self getAllReportObjectsFrom:_currentCompareCust.customerId];
        NSMutableArray *custReportAry  = [[NSMutableArray alloc] initWithCapacity:10];
        if (dataArray.count>0) {
            for (int i=0;i < dataArray.count; i++) {
                ReportModel *model = [dataArray objectAtIndex:i];
                if (model.customerId == _currentCompareCust.customerId) {
                    [custReportAry addObject:model];
                }
            }
        }
        NSArray *arr = [self arraySortDesArray:custReportAry];
        _timeAry = [[NSMutableArray alloc] init];
        [_timeAry addObjectsFromArray:arr];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [_tableView reloadData];
        });
    });
    
}

-(void)initWithView{
    self.view.backgroundColor = UIColorFromRGB(0x151515);
    //底部图片 右
    _rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_W, SCREEN_H)];
//    _leftImgView.image = [UIImage imageNamed:@"login_bg02.jpg"];
    if (![_currentCompareReport.oneImgPathStr isEqualToString:@""] && _currentCompareReport.oneImgPathStr != nil) {
        _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.oneImgPathStr];
    }
    [self.view addSubview:_rightImgView];
    
    _original_x = SCREEN_W/2;
    _original_y = SCREEN_H/2;
    //上层图片 左
    _leftImgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,_original_x, SCREEN_H)];
    _leftImgScrollView.contentSize = CGSizeMake(SCREEN_W,SCREEN_H);
    _leftImgScrollView.bounces = NO;
    _leftImgScrollView.scrollEnabled = NO;
    [self.view addSubview:_leftImgScrollView];
    
    _leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H)];
    if (_timeAry.count > 0) {
        _selectedReport = [_timeAry objectAtIndex:0];
        _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.oneImgPathStr];
    }
    [_leftImgScrollView addSubview:_leftImgView];

    //创建一个平移的手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalPanView:)];
    [self.view addGestureRecognizer:pan];
    
    CGFloat time_w = 165;
    CGFloat time_h = 40;
    CGFloat spece = 20;
    //当前检测的照片时间 (底层照片的时间)
    _currentTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(_original_x + spece,64 + spece,time_w,time_h)];
    [_currentTimeBtn setTintColor:[UIColor whiteColor]];
    _currentTimeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    [_currentTimeBtn setTitle:[_currentCompareReport.reportDate substringWithRange:NSMakeRange(0, 10)] forState:UIControlStateNormal];
    [_currentTimeBtn setTitle:_currentCompareReport.reportDate forState:UIControlStateNormal];
//    [_currentTimeBtn addTarget:self action:@selector(timeSelectedButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_rightImgView addSubview:_currentTimeBtn];
    
    //被选中的照片时间 (上层照片的时间)
    _timeSelectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(spece,64 + spece,time_w,time_h)];
    [_timeSelectedBtn setTintColor:[UIColor whiteColor]];
    _timeSelectedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    [_timeSelectedBtn setTitle:[_currentCompareReport.reportDate substringWithRange:NSMakeRange(0, 10)] forState:UIControlStateNormal];
    [_timeSelectedBtn setTitle:_currentCompareReport.reportDate forState:UIControlStateNormal];
//    [_timeSelectedBtn addTarget:self action:@selector(timeSelectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _leftImgView.userInteractionEnabled = YES;
    [_leftImgView addSubview:_timeSelectedBtn];
    
    //左边时间选择
    CGFloat table_h = 250;
    CGFloat table_w = 165;
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(5,(SCREEN_H - table_h)/2, table_w, table_h) style:UITableViewStylePlain];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CompareTimesViewCell class] forCellReuseIdentifier:@"timeCell"];
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    
    //(640,480) //底部选中对比哪个类型的照片
    CGFloat imgView_w = 48;
    CGFloat imgView_h = 64;
    CGFloat space = 10;
    NSInteger photoNumber = 9;
    CGFloat bottomView_w = imgView_w*photoNumber+space*(photoNumber-1);
    _bottomPhotoView = [[BottomPhotoCompareView alloc] initWithFrame:CGRectMake((SCREEN_W - bottomView_w)/2,SCREEN_H - imgView_h - 2 * space,bottomView_w,imgView_h) andNumber:photoNumber];
    _bottomPhotoView.oneImgBtn.selected = YES;
    _bottomPhotoView.delegate = self;
    [_bottomPhotoView.oneImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.oneImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.twoImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.twoImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.threeImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.threeImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.fourImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.fourImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.fiveImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.fiveImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.sixImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.sixImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.sevenImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.sevenImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.eightImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.eightImgPathStr] forState:UIControlStateNormal];
    [_bottomPhotoView.nineImgBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:_currentCompareReport.nineImgPathStr] forState:UIControlStateNormal];
    [self.view addSubview:_bottomPhotoView];
    
    //(640,480) //底部选中对比哪个类型的照片
    CGFloat btnView_w = 60;
    CGFloat btnView_h = 40;
    CGFloat btn_space = 30;
    NSInteger btnNumber = 3;
    CGFloat bottomBtnView_w = btnView_w*btnNumber+btn_space*(btnNumber-1);
    _bottomBtnView = [[BottomThreeBtnView alloc] initWithFrame:CGRectMake((SCREEN_W - bottomBtnView_w)/2,SCREEN_H - imgView_h - 4 * space - btnView_h,bottomBtnView_w,btnView_h) andNumber:btnNumber];
    _bottomBtnView.delegate = self;
    _bottomBtnView.leftRightBtn.selected = YES;
    [self.view addSubview:_bottomBtnView];
}

#pragma mark - M8MainTitleViewDelegate
-(void)leftButtonClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];

}

//-(void)timeSelectedButtonAction:(UIButton *)sender{
//    NSLog(@"选择某次历史检测记录");
//
//}

//-(void)rightButtonClick{
//    CGFloat time_w = 165;
//    CGFloat time_h = 40;
//    CGFloat spece = 20;
//    if (!_rightBarBtn.selected) {
//        _rightBarBtn.selected = YES;  //上下
//        [_leftImgScrollView setFrame:CGRectMake(0,_original_y, SCREEN_W, SCREEN_H - _original_y)];
//        [_currentTimeBtn setFrame:CGRectMake(SCREEN_W - spece - time_w,64 + spece,time_w,time_h)];
//        [_timeSelectedBtn setFrame:CGRectMake(SCREEN_W - spece - time_w, spece,time_w,time_h)];
//    }else{
//        _rightBarBtn.selected = NO;  //左右
//        [_leftImgScrollView setFrame:CGRectMake(_original_x, 0,SCREEN_W - _original_x, SCREEN_H)];
//        [_currentTimeBtn setFrame:CGRectMake(spece,64 + spece,time_w,time_h)];
//        [_timeSelectedBtn setFrame:CGRectMake(spece,64 + spece,time_w,time_h)];
//    }
//}

// 处理拖拉手势
- (void)horizontalPanView:(UIPanGestureRecognizer *)recognizer{
    UIView *view = recognizer.view;
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint moviePoint = [recognizer translationInView:view];
        if (!_bottomBtnView.upDownBtn.selected) {
            if ((_original_x + moviePoint.x) < SCREEN_W && (_original_x + moviePoint.x) > 0) {
                [_leftImgScrollView setFrame:CGRectMake(0,0,(_original_x + moviePoint.x), SCREEN_H)];
                [_currentTimeBtn setFrame:CGRectMake(20 + (_original_x + moviePoint.x), 64+20, 165, 40)];
            }else if((_original_x + moviePoint.x) <= 0){
                [_leftImgScrollView setFrame:CGRectMake(0, 0,0, SCREEN_H)];
                [_currentTimeBtn setFrame:CGRectMake(20, 64+20, 165, 40)];
            }else if((_original_x + moviePoint.x) >= SCREEN_W){
                [_leftImgScrollView setFrame:CGRectMake(0,0,SCREEN_W, SCREEN_H)];
                [_currentTimeBtn setFrame:CGRectMake(20 + SCREEN_W, 64+20, 165, 40)];
            }
        }else{
            if ((_original_y + moviePoint.y) < SCREEN_H && (_original_y + moviePoint.y) > 0) {
                [_leftImgScrollView setFrame:CGRectMake(0,0,SCREEN_W, (_original_y + moviePoint.y))];
                [_currentTimeBtn setFrame:CGRectMake(SCREEN_W - 20 - 165,20 + 64 + _original_y + moviePoint.y,165,40)];
            }else if((_original_y + moviePoint.y) <= 0){
                [_leftImgScrollView setFrame:CGRectMake(0, 0,SCREEN_W,0)];
                [_currentTimeBtn setFrame:CGRectMake(SCREEN_W - 20 - 165,20 + 64,165,40)];
            }else if((_original_y + moviePoint.y) >= SCREEN_H){
                [_leftImgScrollView setFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H)];
                [_currentTimeBtn setFrame:CGRectMake(SCREEN_W - 20 - 165,20 + SCREEN_H,165,40)];
            }
        }
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        CGPoint moviePoint = [recognizer translationInView:view];
        
        if (!_bottomBtnView.upDownBtn.selected) {
            if ((_original_x + moviePoint.x) < SCREEN_W && (_original_x + moviePoint.x) > 0) {
                _original_x = _original_x + moviePoint.x;
            }else if((_original_x + moviePoint.x) <= 0){
                _original_x = 0;
            }else if ((_original_x + moviePoint.x) >= SCREEN_W){
                _original_x = SCREEN_W;
            }
            
        }else{
            if ((_original_y + moviePoint.y) < SCREEN_H && (_original_y + moviePoint.y) > 0) {
                _original_y = _original_y + moviePoint.y;
            }else if((_original_y + moviePoint.y) <= 0){
                _original_y = 0;
            }else if((_original_y + moviePoint.y) >= SCREEN_H){
                _original_y = SCREEN_H;
            }
        }
    }
}

#pragma mark - BottomPhotoCompareView
-(void)bottomPhotoCompareButtonClickWithTag:(NSInteger)btnTag{
    switch (btnTag) {
        case TAG_BOTTOM_TWO:
            if (![_currentCompareReport.twoImgPathStr isEqualToString:@""] && _currentCompareReport.twoImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.twoImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.twoImgPathStr];
            }
            break;
        case TAG_BOTTOM_THREE:
            if (![_currentCompareReport.threeImgPathStr isEqualToString:@""] && _currentCompareReport.threeImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.threeImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.threeImgPathStr];
            }
            break;
        case TAG_BOTTOM_FOUR:
            if (![_currentCompareReport.fourImgPathStr isEqualToString:@""] && _currentCompareReport.fourImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.fourImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.fourImgPathStr];
            }
            break;
        case TAG_BOTTOM_FIVE:
            if (![_currentCompareReport.fiveImgPathStr isEqualToString:@""] && _currentCompareReport.fiveImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.fiveImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.fiveImgPathStr];
            }
            break;
        case TAG_BOTTOM_SIX:
            if (![_currentCompareReport.sixImgPathStr isEqualToString:@""] && _currentCompareReport.sixImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.sixImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.sixImgPathStr];
            }
            break;
        case TAG_BOTTOM_SEVEN:
            if (![_currentCompareReport.sevenImgPathStr isEqualToString:@""] && _currentCompareReport.sevenImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.sevenImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.sevenImgPathStr];
            }
            break;
        case TAG_BOTTOM_EIGHT:
            if (![_currentCompareReport.eightImgPathStr isEqualToString:@""] && _currentCompareReport.eightImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.eightImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.eightImgPathStr];
            }
            break;
        case TAG_BOTTOM_NINE:
            if (![_currentCompareReport.nineImgPathStr isEqualToString:@""] && _currentCompareReport.nineImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.nineImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.nineImgPathStr];
            }
            break;
        default:
            if (![_currentCompareReport.oneImgPathStr isEqualToString:@""] && _currentCompareReport.oneImgPathStr != nil) {
                _rightImgView.image = [[UIImage alloc] initWithContentsOfFile:_currentCompareReport.oneImgPathStr];
                _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.oneImgPathStr];
            }
            break;
    }
}
#pragma mark - BottomThreeBtnViewDelegate
-(void)bottomThreeBtnClickWithTag:(NSInteger)btnTag{
    CGFloat time_w = 165;
    CGFloat time_h = 40;
    CGFloat spece = 20;
    switch (btnTag) {
        case TAG_COMPARE_CENTER:
        {
            [_leftImgScrollView setFrame:CGRectMake(0, 0,_original_x, SCREEN_H)];
//            [_currentTimeBtn setFrame:CGRectMake(spece,64 + spece,time_w,time_h)];
            [_timeSelectedBtn setFrame:CGRectMake(spece,64 + spece,time_w,time_h)];
        }
            break;
        case TAG_COMPARE_RIGHT:
        {
            [_leftImgScrollView setFrame:CGRectMake(0,0, SCREEN_W,_original_y)];
            [_currentTimeBtn setFrame:CGRectMake(SCREEN_W - spece - time_w,spece + _original_y + 64,time_w,time_h)];
            [_timeSelectedBtn setFrame:CGRectMake(SCREEN_W - spece - time_w, spece + 64,time_w,time_h)];
        }
            break;
        case TAG_COMPARE_LEFT:
            {
                NSLog(@"点击了全脸");
            }
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _timeAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"timeCell";
    CompareTimesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[CompareTimesViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ReportModel *model = _timeAry[indexPath.row];
//    cell.timeLb.text = [model.reportDate substringWithRange:NSMakeRange(0, 10)];
    cell.timeLb.text = model.reportDate;
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _selectedReport = [_timeAry objectAtIndex:indexPath.row];
    _leftImgView.image = [[UIImage alloc] initWithContentsOfFile:_selectedReport.oneImgPathStr];
//    [_timeSelectedBtn setTitle:[_selectedReport.reportDate substringWithRange:NSMakeRange(0, 10)] forState:UIControlStateNormal];
    [_timeSelectedBtn setTitle:_selectedReport.reportDate forState:UIControlStateNormal];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CompareTimesViewCell getCellHeight];
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

#pragma mark -- FMDB
-(NSArray *)getAllReportObjectsFrom:(NSInteger)customerId{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    NSArray *array = [db getAllReportsOfCustomerID:customerId];
    return array;
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
