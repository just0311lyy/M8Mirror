//
//  MainTabbarView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCustomButton.h"
@protocol MainTabbarViewDelegate <NSObject>
-(void)mainTabbarButtonClickWithTag:(NSInteger)btnTag;
@end
@interface MainTabbarView : UIView
@property (assign, nonatomic)id<MainTabbarViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number;
@property (strong , nonatomic) FSCustomButton *homeBtn;
@property (strong , nonatomic) FSCustomButton *customerBtn;
@property (strong , nonatomic) FSCustomButton *infoBtn;
@property (strong , nonatomic) FSCustomButton *productBtn;
@property (strong , nonatomic) FSCustomButton *myBtn;
@end
