//
//  M8MClientListViewController.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/1/9.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "M8MClientListViewController.h"
//#import "M8CustomerDetailViewController.h"
#import "M8MClientDetailViewController.h"
#import "M8CustomerEditViewController.h"
#import "customerListCell.h"
#import "customerModel.h"
#import "HCSortString.h"
#import "ZYPinYinSearch.h"
#import <objc/runtime.h>
#import "M8GlobalData.h"
#import "UIImage+category.h"
@interface M8MClientListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,M8CustomerEditViewControllerDelegate>
@property(nonatomic,strong) UITableView *tableView;

@property (strong, nonatomic) customerModel *customerModel;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *ary;
//@property (strong, nonatomic) NSMutableArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSMutableDictionary *allDataDic;/**<排序后的整个数据源*/
//@property (strong, nonatomic) NSMutableArray *allSortDataAry;/**<排序后的整个数据源数组*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (strong, nonatomic) NSMutableArray *indexDataSource;/**<索引数据源*/

@end

@implementation M8MClientListViewController

-(void)dealloc{
    // 移除当前所有通知
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadCustomerList" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知，监听客户列表刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCustomerList) name:@"reloadCustomerList" object:nil];
}

-(void)initNavBar{
    [super initNavBar];
    _leftNavBarBtn.hidden = YES;
    //导航栏右按钮
    [_rightNavBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_add.png"] toSize:CGSizeMake(GetLogicPixelX(20), GetLogicPixelX(20))] forState:UIControlStateNormal];
    
    [_rightNavBarBtn setTitle:nil forState:UIControlStateNormal];
}

-(void)initView{
    [super initView];
    [self.view addSubview:self.tableView];

}

//#pragma mark - M8MainTitleViewDelegate
//-(void)leftButtonClick{
//    [self dismissViewControllerAnimated:nil completion:nil];
//}
#pragma mark -- buttonAction
- (void)rightNavBarButtonClick{
    M8CustomerEditViewController *editVC = [[M8CustomerEditViewController alloc] init];
    editVC.title = @"新增客户";
    editVC.delegate = self;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:editVC animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)initData {
    _allDataDic = [HCSortString sortAndGroupForArray:_globalCustAry PropertyName:@"name"]; //排序后的整个数据源 字典类型
    //    _allSortDataAry = [NSMutableArray arrayWithArray:[_allDataDic allValues]];
    //    NSLog(@"数组:%@",_allSortDataAry);
    _indexDataSource = [HCSortString sortForStringAry:[_allDataDic allKeys]];   //索引数据源  A B C ... X Y Z
    _searchDataSource = [NSMutableArray new];  //搜索结果
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"搜索";
        [_searchController.searchBar sizeToFit];
        [_searchController.searchBar setBackgroundImage:[UIImage new]];
    }
    return _searchController;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource.count;
    }else { //点击搜索后
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        NSArray *value = [_allDataDic objectForKey:_indexDataSource[section]];
        return value.count;
    }else { //点击搜索后
        return _searchDataSource.count;
    }
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return _indexDataSource[section];
    }else {  //点击搜索后
        return nil;
    }
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    customerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ModelCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (!self.searchController.active) {
        NSArray *value = [_allDataDic objectForKey:_indexDataSource[indexPath.section]];
        _customerModel = value[indexPath.row];
    }else{
        _customerModel = _searchDataSource[indexPath.row];
    }
    //    [cell initCellWithModel:_customerModel];
    if (_customerModel.headImgOfBase64String) {
        cell.headImgView.image = [UIImage imageWithBase64String:_customerModel.headImgOfBase64String];
    }
    cell.sexImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_customerModel.sexStr]];
    cell.nameLb.text = _customerModel.name;
    cell.birthView.numberLb.text = _customerModel.birthday;
    cell.phoneView.numberLb.text = _customerModel.phoneNumber;
    return cell;
}
//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.searchController.active) {
        NSArray *value = [_allDataDic objectForKey:_indexDataSource[indexPath.section]];
        _customerModel = value[indexPath.row];
    }else{
        _customerModel = _searchDataSource[indexPath.row];
    }
    //    self.block(_customerModel.name);
    self.searchController.active = NO;
    //    [self.navigationController popViewControllerAnimated:YES];
//    M8CustomerDetailViewController *cdvc = [[M8CustomerDetailViewController alloc] init];
    M8MClientDetailViewController *cdvc = [[M8MClientDetailViewController alloc] init];
    cdvc.detailModel = _customerModel;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cdvc animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

//左滑删除可编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL list = YES;
    if (!self.searchController.active){
        list = YES;
    }else{
        list = NO;
    }
    return list;
}
//左滑出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//删除所做的动作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 从数据源中删除
        NSArray *value = [_allDataDic objectForKey:_indexDataSource[indexPath.section]];
        customerModel *deleteCust = value[indexPath.row];
        [_globalCustAry removeObject:deleteCust];
        // 从数据库中删除
        [self deleteCustomerObjectByCustomerID:deleteCust.customerId];
        //更新删除后的字典列表
        [self initData];
        // 从列表中删除
        if (value.count == 1) { // 要根据情况直接删除section或者仅仅删除row
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        //发送通知给主页刷新列表
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCustomerList" object:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return GetLogicPixelX(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_H/14;
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_searchDataSource removeAllObjects];
    NSArray *ary = [NSArray new];
    //对排序好的数据进行搜索
    ary = [HCSortString getAllValuesFromDict:_allDataDic];
    
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:ary];
    }else {
        ary = [ZYPinYinSearch searchWithOriginalArray:ary andSearchText:searchController.searchBar.text andSearchByPropertyName:@"name"];
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.tableView reloadData];
}

//#pragma mark - block
//- (void)didSelectedItem:(SelectedItem)block {
//    self.block = block;
//}
#pragma mark -- M8CustomerEditViewControllerDelegate
-(void)savedEditCustomer:(customerModel *)customer  withTitle:(NSString *)title{
    if ([title isEqualToString:@"新增客户"]) {
        [_allDataDic removeAllObjects];
        [_indexDataSource removeAllObjects];
        [_searchDataSource removeAllObjects];
        [self initData];
    }
    [self reloadCustomerList];
}

#pragma mark -- 通知
//监听客户列表刷新
-(void)reloadCustomerList{
    [_tableView reloadData];
}

#pragma mark -- FMDB
-(void)deleteCustomerObjectByCustomerID:(NSInteger)customerId{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db deleteCustomerByCustomerID:customerId];
}

#pragma mark -- 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,B_NavBarHeight, SCREEN_W, SCREEN_H - B_NavBarHeight - B_TabBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromRGB(0xeceff2);
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableHeaderView:self.searchController.searchBar];
        [_tableView registerClass:[customerListCell class] forCellReuseIdentifier:@"ModelCell"];
    }
    return _tableView;
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
