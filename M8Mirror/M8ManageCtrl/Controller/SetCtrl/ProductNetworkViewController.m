//
//  ProductNetworkViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ProductNetworkViewController.h"
#import "TypeViewController.h"
#import "ProductNetModel.h"
#import "ProductNetCell.h"
#import "NSString+Wrapper.h"
@interface ProductNetworkViewController ()<UITableViewDelegate,UITableViewDataSource,TypeViewControllerDelegate,ProductNetCellDelegate>
@property (nonatomic , strong) NSMutableArray *tableArr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ProductNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    [self initWithProductNetData];
    [self initWithTable];
}

-(void)initWithNavBar{
    //导航栏右按钮
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithProductNetData{
//    _tableArr = [[NSArray alloc] init];
    NSArray *dbArray = [self getAllProductNetObjects];
    if (dbArray.count>0) {
        _tableArr = [NSMutableArray arrayWithArray:dbArray];
        ProductNetModel *m = _tableArr[0];
        NSLog(@"maxPercent:%ld",m.maxPercent);
    }else{
        _tableArr = [NSMutableArray arrayWithArray:[ProductNetModel getProductNetModelData]];
    }
}

-(void)initWithTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [_tableView registerClass:[ProductNetCell class] forCellReuseIdentifier:@"proNetCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"proNetCell";
//    NSString *identifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    ProductNetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    ProductNetCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    ProductNetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"proNetCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ProductNetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
//    else{  //当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
//        while ([cell.contentView.subviews lastObject] != nil) {
//             [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
    ProductNetModel *proModel = [_tableArr objectAtIndex:indexPath.row];
    NSString *typeStr = [proModel.typeName stringByAppendingString:@" %"];
    cell.typeLb.text = typeStr;
    cell.sliderView.selectedMinimum = proModel.minPercent;
    cell.sliderView.selectedMaximum = proModel.maxPercent;
    NSString *detailStr = @"";
    if (proModel.productTypeArr.count > 0) {
        for (int i = 0; i < proModel.productTypeArr.count; i++) {
            detailStr = [detailStr stringByAppendingFormat:@"   %@",proModel.productTypeArr[i]];
        }
    }
    cell.detailLb.text = detailStr;
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ProductNetModel *proModel = [_tableArr objectAtIndex:indexPath.row];
    TypeViewController *tvc = [[TypeViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    tvc.title = proModel.typeName;
    tvc.selectedIndex = indexPath.section;
    tvc.delegate = self;
    tvc.selectedArr = proModel.productTypeArr;
    [self.navigationController pushViewController:tvc animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ProductNetCell getCellHeight];
}

#pragma mark - Button Action
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存按钮
- (void)rightButtonClick {
    //保存网络设置到数据库
    if (_tableArr.count>0) {
        [self saveProductNetObjects:_tableArr];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- TypeViewControllerDelegate
-(void)saveSelectedAttribArray:(NSArray *)array andSelectedIndex:(NSInteger)selectedIndex{
    //返回的对象类型属性
    ProductNetModel *selectedModel = [_tableArr objectAtIndex:selectedIndex];
    selectedModel.productTypeArr = array;
    [_tableView reloadData];
}
#pragma mark -- ProductNetCellDelegate
-(void)rangSlide:(TTRangeSlider *)sender andMinimum:(CGFloat)minimum andMaximum:(CGFloat)maximum{
//    NSLog(@"minimum: %.0f  maximum: %.0f",minimum,maximum);
    ProductNetCell *cell = (ProductNetCell *)[sender superview];
    // 获取cell的indexPath
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
//    NSLog(@"点击的是第%zd行",indexPath.section + 1);
    ProductNetModel *selectedModel = [_tableArr objectAtIndex:indexPath.row];
    selectedModel.minPercent = [[NSString stringWithFormat:@"%.0f",minimum] integerValue];
    selectedModel.maxPercent = [[NSString stringWithFormat:@"%.0f",maximum] integerValue];
//    [_tableArr replaceObjectAtIndex:indexPath.section withObject:selectedModel];
//    [_tableView reloadData];
}

#pragma mark -- 数据库操作
-(void)saveProductNetObjects:(NSArray *)array{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    NSArray *dbArray = [db getAllProductNets];
    if (dbArray.count>0) { //数据库有存储，则做更新操作
        for (int i = 0; i<array.count; i++) {
            ProductNetModel *model = [array objectAtIndex:i];
            [db updateProductNetData:model];
        }
    }else{ //数据库未存储，做存储操作（即第一次保存）
        for (int i = 0; i<array.count; i++) {
            ProductNetModel *model = [array objectAtIndex:i];
            NSLog(@"model:%d id:%d",i,model.productNetId);
            [db saveProductNetData:model];
        }
    }
}

-(NSArray *)getAllProductNetObjects{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    NSArray *dbArray = [db getAllProductNets];
    return dbArray;
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
