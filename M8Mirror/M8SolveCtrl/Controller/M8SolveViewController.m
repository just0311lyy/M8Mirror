//
//  M8SolveViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/8.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8SolveViewController.h"
#import "SliderContentViewController.h"
#import "M8TopView.h"
#import "YJSliderView.h"
@interface M8SolveViewController ()<M8TopViewDelegate,YJSliderViewDelegate>
@property (nonatomic, strong) YJSliderView *sliderView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation M8SolveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat topView_H = SCREEN_H/18;
    M8TopView *topView = [[M8TopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, topView_H) andTitleName:@"解决方案" andRightName:@"新增"];
    topView.backgroundColor = UIColorFromRGB(0x40E0D0);
    topView.delegate = self;
    [self.view addSubview:topView];
    
    //需要将UIView的自动调整ScrollViewInset关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"Slider";
    self.titleArray = @[@"淡斑", @"补水", @"清洁", @"嫩肤", @"抗衰", @"修复", @"保养"];
    self.sliderView = [[YJSliderView alloc] initWithFrame:CGRectMake(0, topView_H, SCREEN_W, SCREEN_H - topView_H)];
//    _sliderView.currentIndex = 0;
    self.sliderView.delegate = self;
    
    [self.view addSubview:self.sliderView];
    self.contentArray = [NSMutableArray new];
    for (NSInteger index = 0; index < self.titleArray.count + 1; index ++) {
        SliderContentViewController *vc = [[SliderContentViewController alloc] init];
        [self.contentArray addObject:vc];
    }
}

#pragma mark - M8MainTitleViewDelegate
-(void)leftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - YJSliderViewDelegate
- (NSInteger)numberOfItemsInYJSliderView:(YJSliderView *)sliderView {
    return self.titleArray.count;
}

- (UIView *)yj_SliderView:(YJSliderView *)sliderView viewForItemAtIndex:(NSInteger)index {
    //因为没有写重用的逻辑，建议在控制器中定义view的数组，在此处取出展示(注意在此处定义控制器传入它的view，view中的子视图最好使用约束进行布局)
    SliderContentViewController *vc = self.contentArray[index];
    if (index == 0) {
        vc.view.backgroundColor = UIColorFromRGB(0xFF4500);
    } else if (index == 1) {
        vc.view.backgroundColor = UIColorFromRGB(0xFF7F00);
    } else if (index == 2) {
        vc.view.backgroundColor = UIColorFromRGB(0xFFFF00);
    } else if (index == 3) {
        vc.view.backgroundColor = UIColorFromRGB(0xC0FF3E);
    } else if (index == 4) {
        vc.view.backgroundColor = UIColorFromRGB(0x4876FF);
    } else if (index == 5) {
        vc.view.backgroundColor = UIColorFromRGB(0x7A7A7A);
    } else {
        vc.view.backgroundColor = UIColorFromRGB(0x46228B);
    }
    return vc.view;
}

- (NSString *)yj_SliderView:(YJSliderView *)sliderView titleForItemAtIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (NSInteger)initialzeIndexForYJSliderView:(YJSliderView *)sliderView {
    return 0;
}

- (NSInteger)yj_SliderView:(YJSliderView *)sliderView redDotNumForItemAtIndex:(NSInteger)index {
    return 0;
}

- (void)switchedToIndex:(NSInteger)index {
    NSLog(@"切换到位置%ld", index);
    
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
