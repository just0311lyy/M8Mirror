//
//  M8TopView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/9.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8TopView.h"

@implementation M8TopView

-(instancetype)initWithFrame:(CGRect)frame andTitleName:(NSString *)title andRightName:(NSString *)rightName{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat titleLb_w = width/3;
        
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake((width - titleLb_w)/2, 20, titleLb_w, height - 20)];
        [titleLb setFont:[UIFont systemFontOfSize:28]];
        [titleLb setText:title];
        [titleLb setTextAlignment:NSTextAlignmentCenter];
        [titleLb setNumberOfLines:0];
        [titleLb setTextColor:[UIColor whiteColor]];
        [titleLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:titleLb];
        //左边按钮
        CGFloat btn_w = 80;
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,CGRectGetMinY(titleLb.frame), btn_w,CGRectGetHeight(titleLb.frame))];
        [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [leftBtn setBackgroundColor:[UIColor yellowColor]];
        [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        //右边按钮
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(width - btn_w,CGRectGetMinY(titleLb.frame), btn_w,CGRectGetHeight(titleLb.frame))];
        [rightBtn setTitle:rightName forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [rightBtn setBackgroundColor:[UIColor yellowColor]];
        [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
    }
    return self;
}

-(void)leftBtnAction{
    if ([self.delegate respondsToSelector:@selector(leftButtonClick)]) {
        [self.delegate leftButtonClick];
    }
}

-(void)rightBtnAction{
    if ([self.delegate respondsToSelector:@selector(rightButtonClick)]) {
        [self.delegate rightButtonClick];
    }
}

@end
