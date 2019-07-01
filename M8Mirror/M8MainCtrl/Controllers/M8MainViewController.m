//
//  M8MainViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/6.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8MainViewController.h"
#import "M8CustomerListViewController.h"
#import "M8InfomationViewController.h"
#import "M8SolveViewController.h"
#import "M8ManageViewController.h"
#import "M8MClientDetailViewController.h"
#import "YHLoopScrollView.h"
//#import "M8MainTitleView.h"
//#import "M8SearchView.h"
//#import "M8HistoryView.h"
//#import "MainTabbarView.h"
//#import "FSCustomButton.h"
#import "CustomerViewCell.h"
#import "customerModel.h"
#import "UIImage+category.h"

//#define FIT_H(y) y*([[UIScreen mainScreen] bounds].size.height)/1024
#define space 20
@interface M8MainViewController ()<YHLoopScrollViewDelegate,/*M8MainTitleViewDelegate,MainTabbarViewDelegate,*/UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) YHLoopScrollView *loopScrollView;
//@property (nonatomic,strong) M8MainTitleView *topView;
@property (nonatomic,strong) UIView *searchBgView;
//@property (nonatomic,strong) M8SearchView *searchView;
@property (nonatomic,strong) UICollectionView *mainCollectionView;
@end

@implementation M8MainViewController

-(void)dealloc{
    // 移除当前所有通知
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadCustomerList" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = LOGO_COLOR;
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:22]};
    [self initWithScrollView];
//    [self initWithBottomView];
    [self initWithSearchView];
    
    //注册通知，监听客户列表刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCustomerList) name:@"reloadCustomerList" object:nil];
}

-(void)initWithScrollView{
    CGRect frame = CGRectMake(0,64, SCREEN_W, SCREEN_H/3);
    self.loopScrollView = [[YHLoopScrollView alloc] initWithLoopPageType:LoopPageType_Circle delegate:self frame:frame];
    NSArray *imgUrls = @[@"http://img14.gomein.net.cn/image/prodimg/promimg/topics/201511/20151102/1733jjj640_x.jpg",
                         
                         @"http://img4.gomein.net.cn/image/prodimg/promimg/topics/201510/20151030/1733kaimen280_x.jpg",
                         
                         @"http://img10.gomein.net.cn/image/prodimg/promimg/topics/201510/20151030/1733bx280_x.jpg",
                         
                         @"http://img3.gomein.net.cn/image/prodimg/promimg/topics/201510/20151030/1733qu280_x.jpg",
                         
                         @"http://img10.gomein.net.cn/image/prodimg/promimg/topics/201511/20151102/1733dn280_x.jpg",
                         
                         @"http://img1.gomein.net.cn/image/prodimg/promimg/topics/201510/20151030/1733cd280_x.jpg",
                         
                         @"http://img13.gomein.net.cn/image/prodimg/promimg/topics/201510/20151030/1733bh280_x.jpg"];
    
    self.loopScrollView.mArrayImageUrls = [imgUrls mutableCopy];
    [self.view addSubview:self.loopScrollView];
}

-(void)initWithSearchView{
    _searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_loopScrollView.frame), SCREEN_W, SCREEN_H - CGRectGetMaxY(_loopScrollView.frame) - 49)];
    _searchBgView.backgroundColor = GREY_COLOR;
    [self.view addSubview:_searchBgView];
//
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(space, space, CGRectGetWidth(_searchBgView.frame) - space * 2, space * 2)];
//    [searchBar setBarStyle:UIBarStyleDefault];
//    [searchBar setPlaceholder:@"请输入客户姓名"];
//    [searchBar setBackgroundImage:[UIImage new]];
//    [_searchBgView addSubview:searchBar];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
//    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //cell的尺寸
//    CGSize cellSize = CGSizeMake((SCREEN_W - 4*space)/3, (CGRectGetHeight(_searchBgView.frame)-CGRectGetMaxY(searchBar.frame) - 2 * space)/2);
    CGSize cellSize = CGSizeMake((SCREEN_W - 4*space)/3, (CGRectGetHeight(_searchBgView.frame) - 3 * space)/2);
    //该方法也可以设置itemSize
    layout.itemSize = cellSize;
    //2.初始化collectionView
//    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(searchBar.frame), SCREEN_W, CGRectGetHeight(_searchBgView.frame)-CGRectGetMaxY(searchBar.frame)) collectionViewLayout:layout];
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_W, CGRectGetHeight(_searchBgView.frame)) collectionViewLayout:layout];
    [_searchBgView addSubview:_mainCollectionView];
//    _mainCollectionView.alwaysBounceVertical = YES;
    _mainCollectionView.showsHorizontalScrollIndicator = NO;//取消滚动条
    _mainCollectionView.pagingEnabled = YES;//分页效果
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_mainCollectionView registerClass:[CustomerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
//    [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
  
}

#pragma mark - YHLoopScrollViewDelegate
- (void)requiredLoopScrollView:(YHLoopScrollView *)aScrollViewLoop
              didSelectedIndex:(NSUInteger)aUIntIndex
{
    /// 处理点击之后的跳转逻辑
    NSLog(@"轮播图点击的是第%@个",@(aUIntIndex+1));
}

//#pragma mark - M8MainTitleViewDelegate
//-(void)rightButtonClick{
//    [self dismissViewControllerAnimated:nil completion:nil];
//}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _globalCustAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerViewCell *cell = (CustomerViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
//    cell.i
//    cell. .text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
    customerModel* customerModel = _globalCustAry[indexPath.row];
    if (customerModel.headImgOfBase64String) {
        cell.imageView.image = [UIImage imageWithBase64String:customerModel.headImgOfBase64String];
    }
    cell.sexImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",customerModel.sexStr]];
    cell.nameLb.text = customerModel.name;
    cell.numberLb.text = customerModel.phoneNumber;
    cell.birthLb.text = customerModel.birthday;

    return cell;
}

//设置每个item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(90, 130);
//}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(space, space,space, space);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return space;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return space;
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
//    headerView.backgroundColor =[UIColor grayColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
//    label.text = @"这是collectionView的头部";
//    label.font = [UIFont systemFontOfSize:20];
//    [headerView addSubview:label];
//    return headerView;
//}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CustomerViewCell *cell = (CustomerViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    NSString *msg = cell.nameLb.text;
//    NSLog(@"%@",msg);
    customerModel* customerModel = _globalCustAry[indexPath.row];
    M8MClientDetailViewController *cdvc = [[M8MClientDetailViewController alloc] init];
    cdvc.detailModel = customerModel;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cdvc animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark -- 通知
//监听客户列表刷新
-(void)reloadCustomerList{
    NSLog(@"globalCustAry:%@",_globalCustAry);
    [_mainCollectionView reloadData];
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
