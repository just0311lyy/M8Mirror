//
//  M8ManageViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/8.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8ManageViewController.h"
#import "M8SettingViewController.h"
#import "M8AdminViewController.h"
#import "PasswordViewController.h"
#import "M8TopView.h"
#import "ManageTopView.h"
#import "ManageViewCell.h"
#import "UIImage+category.h"

#define head_H 240
@interface M8ManageViewController ()</*M8TopViewDelegate,*/UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *manages;
@end

@implementation M8ManageViewController

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
    
    [self initWithNavBar];
    [self initWithData];
    [self initWithTableView];
}

-(void)initWithNavBar{
    self.navigationController.navigationBar.barTintColor = LOGO_COLOR;
//    self.navigationController.navigationBar.titleTextAttributes=
//    @{NSForegroundColorAttributeName:[UIColor whiteColor],
//      NSFontAttributeName:[UIFont systemFontOfSize:22]};
    //导航栏左按钮
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setTitle:@"设置" forState:UIControlStateNormal];
    [leftBarBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithData{
    NSArray *dataArray = @[
                           @{@"titleName":@"个人信息",@"imageName":@"my_infomation.png",@"message":@"admin"},
                           @{@"titleName":@"修改密码",@"imageName":@"my_password.png",@"message":@""},
                           @{@"titleName":@"查看其他账户",@"imageName":@"my_accounts.png",@"message":@""},
                           @{@"titleName":@"添加新账户",@"imageName":@"my_add.png",@"message":@""},
                           @{@"titleName":@"内存剩余量",@"imageName":@"my_memary.png",@"message":@"剩余12G/总空间60G"},
                           @{@"titleName":@"系统缓存",@"imageName":@"my_cache.png",@"message":@"463M"},
                           @{@"titleName":@"版本信息",@"imageName":@"my_version.png",@"message":@"V2.1.2"}];
    _manages = [[NSMutableArray alloc] init];
    [_manages addObjectsFromArray:dataArray];
}

-(void)initWithTableView{
    CGFloat table_H = SCREEN_H - 49;
    ManageTopView *manageView = [[ManageTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, head_H) andAdmin:[LYUserDefault loadAccountCache] andAdminImage:[UIImage imageNamed:@"login_bg01.jpg"]];
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, table_H) style:UITableViewStyleGrouped];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableHeaderView:manageView];
        [_tableView registerClass:[ManageViewCell class] forCellReuseIdentifier:@"manageCell"];
    }
}

#pragma mark - M8MainTitleViewDelegate
-(void)leftButtonClick{
    M8SettingViewController *svc = [[M8SettingViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:svc animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else{
        return 3;
    }
//    return _manages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"manageCell";
    ManageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ManageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        cell.titleLb.text = [[_manages objectAtIndex:indexPath.row] objectForKey:@"titleName"];
        cell.imgView.image = [UIImage imageNamed:[[_manages objectAtIndex:indexPath.row] objectForKey:@"imageName"]];
        cell.detailLb.text = [[_manages objectAtIndex:indexPath.row] objectForKey:@"message"];
    }else{
        cell.titleLb.text = [[_manages objectAtIndex:(indexPath.row + 4)] objectForKey:@"titleName"];
        cell.imgView.image = [UIImage imageNamed:[[_manages objectAtIndex:(indexPath.row + 4)] objectForKey:@"imageName"]];
        cell.detailLb.text = [[_manages objectAtIndex:(indexPath.row + 4)] objectForKey:@"message"];
    }
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            M8AdminViewController *avc = [[M8AdminViewController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:avc animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }else if (indexPath.row == 1){
            PasswordViewController *pvc = [[PasswordViewController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:pvc animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return head_H;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return CGFLOAT_MIN;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
