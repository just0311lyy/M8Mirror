//
//  M8MProductViewController.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/5.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "M8MProductViewController.h"
#import "FSCustomButton.h"
//#import "M8ProductEditViewController.h"
#import "M8MProductEditViewController.h"
#import "FSCustomButton.h"
#import "UIImage+category.h"
#import "ProductKindView.h"
#import "ProductModel.h"
#import "ProductViewCell.h"

@interface M8MProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ProductViewCellDelegate>

@property (nonatomic, strong) FSCustomButton * titleBtn;
@property (assign, nonatomic) NSInteger selectTypeIndex;/*选择的产品种类的索引*/
@property (nonatomic, strong) NSArray *productTypeArray;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *productShowArray; //显示的产品
@end

@implementation M8MProductViewController

-(void)dealloc{
    // 移除当前所有通知
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadProductList" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知，监听客户列表刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflushProductListView) name:@"reloadProductList" object:nil];
}

-(void)initNavBar{
    [super initNavBar];
    _leftNavBarBtn.hidden = YES;
    //导航栏右按钮
    [_rightNavBarBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_add.png"] toSize:CGSizeMake(GetLogicPixelX(20), GetLogicPixelX(20))] forState:UIControlStateNormal];
    
    [_rightNavBarBtn setTitle:nil forState:UIControlStateNormal];
    
    _titleBtn = [FSCustomButton buttonWithType:UIButtonTypeCustom];
    _titleBtn.frame = CGRectMake(20, 20, 100, 40);
    _titleBtn.buttonImagePosition = FSCustomButtonImagePositionRight;
    _titleBtn.adjustsImageTintColorAutomatically = YES;
    _titleBtn.adjustsTitleTintColorAutomatically = YES;
    [_titleBtn setTintColor:[UIColor whiteColor]];
    [_titleBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"nav_down.png"] toSize:CGSizeMake(14, 8)] forState:UIControlStateNormal];
    [_titleBtn setTitle:[self.productTypeArray objectAtIndex:0] forState:UIControlStateNormal];
    [_titleBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [_titleBtn addTarget:self action:@selector(showAllKindsAction) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.navigationItem.titleView = _titleBtn;
}

-(void)initData{
    [super initData];
    //默认显示全部产品
    [self.productShowArray addObjectsFromArray:_globalProductsAry];
    
}

-(void)initView{
    [super initView];
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //cell的尺寸
    CGFloat space = 5;
    CGSize cellSize = CGSizeMake((SCREEN_W - 3*space)/2, (SCREEN_H - 64 - 49 - 3 * space)/2);
    //该方法也可以设置itemSize
    layout.itemSize = cellSize;
    //2.初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H - 64 - 49) collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    //    _mainCollectionView.alwaysBounceVertical = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;//取消滚动条
    //    _collectionView.pagingEnabled = YES;//分页效果
    _collectionView.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_collectionView registerClass:[ProductViewCell class] forCellWithReuseIdentifier:@"cellId"];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    //    [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //4.设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
}

#pragma mark -- ** collectionView 代理方法 **
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productShowArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductViewCell *cell = (ProductViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.delegate = self;
    ProductModel *productModel = _productShowArray[indexPath.row];
    if (productModel.imgDocumentPath) {
        cell.imgView.image = [[UIImage alloc] initWithContentsOfFile:productModel.imgDocumentPath];
    }
    cell.titleLabel.text = productModel.name;
    cell.detailLabel.text = productModel.useMethod;
    cell.oldPriceLb.text = productModel.price;
    NSString *currentStr = productModel.price;
    if (productModel.discount != 0 && ![productModel.discount isEqualToString:@""]) {
        NSInteger oldPriceInt = [productModel.price integerValue];
        NSInteger discountInt = [productModel.discount integerValue];
        NSInteger currentInt = oldPriceInt * discountInt / 100;
        currentStr = [NSString stringWithFormat:@"%ld",currentInt];
    }
    cell.currentPriceLb.text = currentStr;
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
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
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
    //    ProductModel *productModel = _globalProductsAry[indexPath.row];
    //    M8ProductEditViewController *pevc = [[M8ProductEditViewController alloc] init];
    //    pevc.delegate = self;
    //    pevc.currentProduct = productModel;
    //    pevc.title = @"编辑";
    //    [self setHidesBottomBarWhenPushed:YES];
    //    [self.navigationController pushViewController:pevc animated:YES];
    //    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark -- ** ProductViewCellDelegate **
-(void)deleteButtonClick:(UIButton *)sender{
    // 获取'删除按钮'所在的cell
    UICollectionViewCell *cell = (UICollectionViewCell *)[sender superview];
    // 获取cell的indexPath
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    ProductModel *productModel = _globalProductsAry[indexPath.row];
    //从全局数组中删除该数据
    [_globalProductsAry removeObject:productModel];
    //产品源数组中移除该数据
    [_productShowArray removeObject:productModel];
    //从数据库删除该数据
    [self deleteProductObject:productModel];
    [self.collectionView reloadData];
}

-(void)editButtonClick:(UIButton *)sender{
    // 获取'edit按钮'所在的cell
    UICollectionViewCell *cell = (UICollectionViewCell *)[sender superview];
    // 获取cell的indexPath
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    
    ProductModel *productModel = _globalProductsAry[indexPath.row];
    M8MProductEditViewController *pevc = [[M8MProductEditViewController alloc] init];
    pevc.currentProduct = productModel;
    pevc.controllerType = ProductEditTypeEdit;
    __weak typeof(self) weakSelf = self;
    pevc.productEditBlock = ^(ProductModel * _Nonnull editProduct, ProductEditType editType) {
        [weakSelf.productShowArray replaceObjectAtIndex:indexPath.row withObject:editProduct];
        [weakSelf.collectionView reloadData];
    };
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:pevc animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark -- ** buttonAction **
//产品种类选择
-(void)showAllKindsAction{
    _titleBtn.enabled = NO;
    __weak typeof(self) weakSelf = self;
    ProductKindView *kindView = [[ProductKindView alloc] initKindViewWithArr:self.productTypeArray current:_selectTypeIndex];
    kindView.kindSelectIndex = ^(NSInteger index) {
        NSLog(@"当前选中语言%@",_productTypeArray[index]);
        weakSelf.selectTypeIndex = index;
        weakSelf.titleBtn.enabled = YES;
        [_titleBtn setTitle:_productTypeArray[index] forState:UIControlStateNormal];
        //对显示的数据进行筛选
        [self showProductsWithSelectedIndex:index];
    };
    
    kindView.kindViewFadeOut = ^{
        weakSelf.titleBtn.enabled = YES;
    };
    
    [kindView show:self.view];
}

-(void)showProductsWithSelectedIndex:(NSInteger)index{
    //选中的属性
    NSString *selectedIndexStr;
    if (index == 0) {
        selectedIndexStr = @"07";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_productShowArray removeAllObjects];
            [_productShowArray addObjectsFromArray:_globalProductsAry];
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [_collectionView reloadData];
            });
        });
    }else{
        selectedIndexStr = [NSString stringWithFormat:@"0%ld",index-1];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            NSMutableArray *productsAry = [[NSMutableArray alloc] initWithCapacity:10];
            if (_globalProductsAry.count>0) {
                for (int i=0;i < _globalProductsAry.count; i++) {
                    ProductModel *model = [_globalProductsAry objectAtIndex:i];
                    //如果产品含有此属性则筛选出此产品
                    if (![model.attrib isEqualToString:@""] && model.attrib != nil) {
                        NSArray *attAry = [model.attrib componentsSeparatedByString:@","];
                        //                        NSMutableArray *newArr = [[NSMutableArray alloc] initWithCapacity:7];
                        for (int j =0;j<attAry.count; j++) {
                            NSString *attFlag = [attAry objectAtIndex:j];
                            if ([attFlag isEqualToString:selectedIndexStr]) {
                                [productsAry addObject:model];
                            }
                        }
                    }
                }
            }
            [_productShowArray removeAllObjects];
            [_productShowArray addObjectsFromArray:productsAry];
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [_collectionView reloadData];
            });
        });
    }
}

//#pragma mark -- base64String 转换为图片
//-(UIImage *)imageWithBase64String:(NSString *)string{
//    // 将base64字符串转为NSData
//    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:string options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
//    // 将NSData转为UIImage
//    UIImage *decodedImage = [UIImage imageWithData: decodeData];
//    return decodedImage;
//}

//#pragma mark -- M8ProductEditViewControllerDelegate
//- (void)savedEditProduct:(ProductModel *)product withTitle:(NSString *)title{
//    //    if ([title isEqualToString:@"新建"]) {
//    //
//    //    }
//    //    [_titleBtn setTitle:_kindArr[0] forState:UIControlStateNormal];
//    //    [_showProductAry removeAllObjects];
//    //    [self initWithProductData];
//    //    [_collectionView reloadData];
//    [self reflushProductListView];
//}




- (void)rightNavBarButtonClick{
    M8MProductEditViewController *pevc = [[M8MProductEditViewController alloc] init];
    pevc.controllerType = ProductEditTypeNewCreat;
    __weak typeof(self) weakSelf = self;
    pevc.productEditBlock = ^(ProductModel * _Nonnull editProduct, ProductEditType editType) {
        [weakSelf.productShowArray insertObject:editProduct atIndex:0];
        [weakSelf.collectionView reloadData];
    };
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:pevc animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

//刷新
-(void)reflushProductListView{
    [_titleBtn setTitle:_productTypeArray[0] forState:UIControlStateNormal];
    [_productShowArray removeAllObjects];
    [_productShowArray addObjectsFromArray:_globalProductsAry];
    [_collectionView reloadData];
}

#pragma mark -- ** 数据库 **
//从数据库删除产品
-(void)deleteProductObject:(ProductModel *)model{
    LYSQLDataOperation *db = [LYSQLDataOperation sharedDataInstance];
    [db openDatabase];
    [db deleteProductByProductID:model.productId];
}

#pragma mark -- ** 懒加载 **
-(NSArray *)productTypeArray{
    if (!_productTypeArray) {
        _productTypeArray = [[NSArray alloc] initWithObjects:@"全部",@"补水",@"淡斑",@"清洁",@"嫩肤",@"抗衰",@"修复",@"保养", nil];
    }
    return _productTypeArray;
}

-(NSMutableArray *)productShowArray{
    if (!_productShowArray) {
        _productShowArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _productShowArray;
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
