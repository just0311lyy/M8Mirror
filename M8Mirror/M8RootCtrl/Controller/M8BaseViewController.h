//
//  M8BaseViewController.h
//  M8Mirror
//
//  Created by YangyangLi on 2019/1/2.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M8BaseViewController : UIViewController{
    float B_ScreenWidth;
    float B_ScreenHeight;
    float B_NavBarHeight;
    float B_NavBarOrginY;
    float B_TabBarHeight;
    
    UIButton *_leftNavBarBtn;
    UIButton *_rightNavBarBtn;
}
//初始化导航栏按钮
-(void)initNavBar;

-(void)initData;

-(void)initView;
@end
