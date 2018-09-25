//
//  M8PagesViewController.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/5.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8PagesViewController.h"

@interface M8PagesViewController ()<UIScrollViewDelegate,UIPageViewControllerDelegate>
@property(nonatomic, strong) UIScrollView *mainView;
@property(nonatomic, strong) UIPageControl *pageControl;
@end

@implementation M8PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LOGO_COLOR;
    [self initMainView];
}

-(void)initMainView{
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
//    _mainView.backgroundColor = LOGO_COLOR;
    _mainView.contentSize = CGSizeMake(SCREEN_W*3,SCREEN_H);
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.clipsToBounds = NO; //将其子视图超出的部分显现出来
    _mainView.pagingEnabled = YES; //是否分页效果
    _mainView.showsHorizontalScrollIndicator = NO; //是否显示水平滚动条
    _mainView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainView];
    
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W * i, 0, SCREEN_W, SCREEN_H)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg0%d.jpg",i+1]];
        [_mainView addSubview:imageView];
        if (i == 2) {
            UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W * i + SCREEN_W/3,SCREEN_H - 100,SCREEN_W/3, 40)];
            
            enterBtn.backgroundColor = UIColorFromRGB(0x8B3A3A);
            [enterBtn setTitle:[LYLocalizeConfig localizedString:@"Next Step"] forState:UIControlStateNormal];
            [enterBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
            [enterBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
            [_mainView addSubview:enterBtn];
        }
        
        
        
    }
}

-(void)start:(id)sender{
    if (self.enterBlock != nil) {
        self.enterBlock();
        NSLog(@"1点击进入按钮");
    }
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
