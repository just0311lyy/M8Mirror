//
//  SettingFootView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "SettingFootView.h"

@implementation SettingFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        self.backgroundColor = UIColorFromRGB(0xedf0f3);
        
        UIButton *logOffBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,20, width,height - 20)];
        [logOffBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        logOffBtn.titleLabel.font = [UIFont systemFontOfSize:22];
        [logOffBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [logOffBtn setBackgroundColor:[UIColor whiteColor]];
        [logOffBtn addTarget:self action:@selector(loginOutBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:logOffBtn];
    }
    return self;
}

-(void)loginOutBtnAction{
    if ([self.delegate respondsToSelector:@selector(loginOutButtonClick)]) {
        [self.delegate loginOutButtonClick];
    }
}

@end
