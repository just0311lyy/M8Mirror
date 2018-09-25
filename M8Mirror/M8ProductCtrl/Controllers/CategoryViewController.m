//
//  CategoryViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/4.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "CategoryViewController.h"
#import "TypeSelectedCell.h"
@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource,TypeSelectedCellDelegate>
@property (nonatomic , strong) NSArray *tableArr;  //数据数组
@property (nonatomic , strong) UITableView *tableView;
//@property (nonatomic , strong) NSMutableArray *selectedIndexArr;  //被选中的row
@property (nonatomic , assign) NSInteger selectedIndex; //被选中的下标
@property (nonatomic , strong) NSIndexPath *selectedIndexPath;
//@property (nonatomic , strong) NSMutableArray *saveArr;  //新保存的属性


@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavBar];
    [self initWithTypeData];
    [self initWithTable];
}

-(void)initWithNavBar{
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
    //    [leftBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_back.png"] toSize:CGSizeMake(36/3, 66/3)]  forState:UIControlStateNormal];
    [leftBarBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.frame = CGRectMake(0, 0, 50, 25);
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

-(void)initWithTypeData{
    _tableArr = [[NSArray alloc] initWithObjects:@"基础",@"中级",@"高级",nil];
    //给数据添加标记
//    if (!_selectedIndexArr) {
//        _selectedIndexArr = [[NSMutableArray alloc]init];
//    }
//    //存储新勾选的属性
//    if (!_saveArr) {
//        _saveArr = [[NSMutableArray alloc] init];
//    }
//    if (_selectedArr.count>0) {
//        [_saveArr addObjectsFromArray:_selectedArr];
//    }
    //已勾选的类型
    if (_selectCategoryStr) {
        for (int j=0; j<[_tableArr count]; j++) {
            NSString *tableStr = [_tableArr objectAtIndex:j];
            if ([tableStr isEqualToString:_selectCategoryStr]) {
                _selectedIndex = j;
            }
        }
    }else{
        _selectedIndex = -1;
    }

}

-(void)initWithTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H - 64) style:UITableViewStyleGrouped];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [_tableView registerClass:[TypeSelectedCell class] forCellReuseIdentifier:@"CategoryViewCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"CategoryViewCell";
    TypeSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TypeSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    if (_selectedIndex >= 0) {
        if (_selectedIndex == indexPath.row) {
            cell.selectionButton.selected = YES;
            cell.typeLb.textColor = UIColorFromRGB(0x43a8d0);
            cell.isSelected = YES;
            _selectedIndexPath = indexPath;  //记录当前选中的cell
        }else{
            cell.selectionButton.selected = NO;
            cell.isSelected = NO;
        }
    }
    
    //    cell.isSelected = NO;
//    cell.indexPathRow = indexPath.row;
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
    //之前选中的，取消选择
    //取消之前的选择
    TypeSelectedCell *celled = [_tableView cellForRowAtIndexPath:_selectedIndexPath];
    celled.typeLb.textColor = [UIColor blackColor];
    celled.selectionButton.selected = NO;
    celled.isSelected = NO;
    
    if (isSelected == YES) {
        _selectCategoryStr = stockCode;
        _selectedIndex = indexPathRow;
    }
    
    if ([self.delegate respondsToSelector:@selector(saveSelectedCategory:)]) {
        [self.delegate saveSelectedCategory:_selectCategoryStr];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - Button Action
//返回按钮
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//保存按钮
- (void)rightButtonClick {
//    if (_saveArr.count>0) {
//        for (int i=0; i<_saveArr.count; i++) {
//            NSLog(@"saveArr[%d]:%@",i,_saveArr[i]);
//        }
//    }
    //    NSLog(@"保存的属性：%@",_saveArr);
    
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
