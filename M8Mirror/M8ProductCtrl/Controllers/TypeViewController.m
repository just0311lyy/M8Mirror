//
//  TypeViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/24.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "TypeViewController.h"
#import "TypeSelectedCell.h"
@interface TypeViewController ()<UITableViewDelegate,UITableViewDataSource,TypeSelectedCellDelegate>
@property (nonatomic , strong) NSArray *tableArr;  //数据数组
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *selectedIndexArr;  //被选中的row
@property (nonatomic , strong) NSMutableArray *saveArr;  //新保存的属性

@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    [self initWithTypeData];
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

-(void)initWithTypeData{
    _tableArr = [[NSArray alloc] initWithObjects:@"补水类",@"淡斑类",@"清洁类",@"嫩肤类",@"抗衰老",@"修复类",@"保养类", nil];
    //给数据添加标记
    if (!_selectedIndexArr) {
        _selectedIndexArr = [[NSMutableArray alloc]init];
    }
    //存储新勾选的属性
    if (!_saveArr) {
        _saveArr = [[NSMutableArray alloc] init];
    }
    if (_selectedArr.count>0) {
        [_saveArr addObjectsFromArray:_selectedArr];
    }
    //已勾选的属性
    NSMutableArray *indexArr = [NSMutableArray arrayWithCapacity:10];
    if (_selectedArr.count>0) {
        for (int i=0; i<_selectedArr.count; i++) {
            NSString *selectedStr = [_selectedArr objectAtIndex:i];
            //遍历所有的分组
            for (int j=0; j<[_tableArr count]; j++) {
                NSString *tableStr = [_tableArr objectAtIndex:j];
                if ([tableStr isEqualToString:selectedStr]) {
                    [indexArr addObject:@(j)];
                }
            }
        }
    }
    //对勾选的index去重
    NSSet *set = [NSSet setWithArray:indexArr];
    _selectedIndexArr = [NSMutableArray arrayWithArray:[set allObjects]];
//    //存储新勾选的属性
//    if (!_saveArr) {
//        _saveArr = [[NSMutableArray alloc] init];
//    }
}

-(void)initWithTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H - 64) style:UITableViewStyleGrouped];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"typeSelectedCell";
    TypeSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TypeSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
//    cell.typeLb.text = _tableArr[indexPath.row];
//    cell.selectionButton.selected = NO;
//    if ([self.selectedIndexArr containsObject:@(indexPath.row)]) {
////        cell.selectionButton.selected = YES;
//        cell.typeLb.textColor = UIColorFromRGB(0x43a8d0);
//        cell.selectionImgView.image = [UIImage imageNamed:@"btn_selected.png"];
//    }
    if ([self.selectedIndexArr indexOfObject:@(indexPath.row)] != NSNotFound) {
        cell.selectionButton.selected = YES;
        cell.typeLb.textColor = UIColorFromRGB(0x43a8d0);
        cell.isSelected = YES;
    }else{
        cell.selectionButton.selected = NO;
        cell.isSelected = NO;
    }
//    cell.isSelected = NO;
    cell.indexPathRow = indexPath.row;
    cell.typeLb.text = _tableArr[indexPath.row];
    cell.typeString = cell.typeLb.text;
    cell.delegate = self;
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TypeSelectedCell getCellHeight];
}

#pragma mark - TypeSelectedCellDelegate
-(void)selectedButton:(UIButton *)button andStock_code:(NSString *)stockCode andIsSelected:(BOOL)isSelected andIndexPathRow:(NSInteger)indexPathRow{
    if (isSelected == YES) {
        [self.saveArr addObject:stockCode];
        [self.selectedIndexArr addObject:@(indexPathRow)];
    }else{
        [self.saveArr removeObject:stockCode];
        [self.selectedIndexArr removeObject:@(indexPathRow)];
    }
    NSLog(@"saveArr:%@",_saveArr);
//    self.selectCountLabel.text = [NSString stringWithFormat:@"已选择%lu个",(unsigned long)[self.addStockCodeArray count]];
}

#pragma mark - Button Action
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存按钮
- (void)rightButtonClick {
    //移除数组里面为空的元素
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] init];
    for(int i =0 ; i < _saveArr.count ; i++){
        NSString *str = _saveArr[i];
        NSLog(@"saveArr[%d]:%@",i,_saveArr[i]);
        if([str isEqualToString:@""]){
            [set addIndex:i];
        }
    }
    [_saveArr removeObjectsAtIndexes:set];
    
    if ([self.delegate respondsToSelector:@selector(saveSelectedAttribArray:andSelectedIndex:)]) {
        [self.delegate saveSelectedAttribArray:_saveArr andSelectedIndex:_selectedIndex];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
