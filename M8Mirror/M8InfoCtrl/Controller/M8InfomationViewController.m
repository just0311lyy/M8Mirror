//
//  M8InfomationViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/8.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8InfomationViewController.h"
#import "CaseViewCell.h"
@interface M8InfomationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UISegmentedControl *segmentedController;
@property (nonatomic,strong) UITableView *caseTable;
@property (nonatomic,strong) NSMutableArray *caseAry;
@end

@implementation M8InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = LOGO_COLOR;
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:22]};
    [self initWithNav];
    [self initWithData];
    [self initWithSuccessCaseView];
}

-(void)initWithNav{
    NSArray *array = [NSArray arrayWithObjects:@"成功案例",@"最新信息", nil];
    _segmentedController = [[UISegmentedControl alloc] initWithItems:array];
//    _segmentedController.segmentedControlStyle = UISegmentedControlSegmentCenter;
    [_segmentedController setTintColor:[UIColor whiteColor]];
    [_segmentedController setSelectedSegmentIndex:0];
    [_segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedController;
}

-(void)segmentAction:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex==0) {
//        self.myAduroTask.taskConditionDeviceAction  = 0x01;
//        _taskConditionDeviceAction = 0x01  + HEXADECIMAL_DATA_OFFSET;
    }
    if (segment.selectedSegmentIndex==1) {
//        self.myAduroTask.taskConditionDeviceAction  = 0x00;
//        _taskConditionDeviceAction = 0x00  + HEXADECIMAL_DATA_OFFSET;
    }
}

-(void)initWithData{
    NSArray *dataArray = @[
                           @{@"title":@"关于智能魔镜软件更详细说明",@"imageName":@"case_01.png",@"message":@"基于安卓平板电脑设计，适应多国语言文字",@"date":@"2018-03-12 10:16"},
                           @{@"title":@"解析第五光谱的测量重要性",@"imageName":@"case_02.png",@"message":@"光谱仪工作原理光谱分析方法作为一种重要的分...",@"date":@"2018-03-09 16:23"},
                           @{@"title":@"怎样通过无光谱查看皮肤问题",@"imageName":@"case_03.png",@"message":@"转业的五光谱皮肤检测仪让顾客一目了然的了解...",@"date":@"2017-10-19 10:36"},
                           @{@"title":@"通过对比看皮肤问题",@"imageName":@"case_04.png",@"message":@"仔细看看这对比图，红点处就是远红外负离子...",@"date":@"2017-03-19 20:36"}];
    _caseAry = [[NSMutableArray alloc] init];
    [_caseAry addObjectsFromArray:dataArray];
}

-(void)initWithSuccessCaseView{    
    CGFloat table_Y = 64;
    CGFloat table_H = SCREEN_H - 49;
    if (!_caseTable) {
        _caseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, table_Y, SCREEN_W, table_H) style:UITableViewStylePlain];
        [_caseTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:_caseTable];
        _caseTable.delegate = self;
        _caseTable.dataSource = self;
        [_caseTable registerClass:[CaseViewCell class] forCellReuseIdentifier:@"CaseCell"];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _caseAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"CaseCell";
    CaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CaseViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imgView.image = [UIImage imageNamed:[[_caseAry objectAtIndex:indexPath.row] objectForKey:@"imageName"]];
    cell.titleLabel.text = [[_caseAry objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailLabel.text = [[_caseAry objectAtIndex:indexPath.row] objectForKey:@"message"];
    cell.timeLabel.text = [[_caseAry objectAtIndex:indexPath.row] objectForKey:@"date"];
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    M8CustomerDetailViewController *cdvc = [[M8CustomerDetailViewController alloc] init];
    //    cdvc.detailModel = _customerModel;
    //    [self presentViewController:cdvc animated:nil completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
