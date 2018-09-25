//
//  M8MainTitleView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8MainTitleView.h"

@implementation M8MainTitleView

-(instancetype)initWithFrame:(CGRect)frame andTitleName:(NSString *)title{
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
        
        CGFloat btn_w = 100;
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(width - btn_w,CGRectGetMinY(titleLb.frame), btn_w,CGRectGetHeight(titleLb.frame))];
        [rightBtn setTitle:@"注销" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:24];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [rightBtn setBackgroundColor:[UIColor yellowColor]];
        [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
    }
    return self;
}

-(void)rightBtnAction{
    if ([self.delegate respondsToSelector:@selector(rightButtonClick)]) {
        [self.delegate rightButtonClick];
    }
}

@end
