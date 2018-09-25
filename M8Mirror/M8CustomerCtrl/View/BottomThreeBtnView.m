//
//  BottomThreeBtnView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/7/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "BottomThreeBtnView.h"

@implementation BottomThreeBtnView

-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 30;
        CGFloat btnFont = 22;
        //(60,40) 按钮尺寸
        CGFloat btn_w = (width - (number-1)*space)/number;
        
        _selfBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, btn_w,height)];
        [_selfBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selfBtn setTitle:@"全脸" forState:UIControlStateNormal];
        [_selfBtn.titleLabel setFont:[UIFont systemFontOfSize:btnFont]];
//        _selfBtn.layer.borderWidth = 1;
//        _selfBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
        [_selfBtn setTitleColor:UIColorFromRGB(0x00d4e0) forState:UIControlStateSelected];
        [_selfBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selfBtn.tag = TAG_COMPARE_LEFT;
        [self addSubview:_selfBtn];
        
        _leftRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(btn_w + space,0, btn_w,height)];
        [_leftRightBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftRightBtn setTitle:@"左右" forState:UIControlStateNormal];
        [_leftRightBtn.titleLabel setFont:[UIFont systemFontOfSize:btnFont]];
//        _leftRightBtn.layer.borderWidth = 1;
//        _leftRightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_leftRightBtn setTitleColor:UIColorFromRGB(0x00d4e0) forState:UIControlStateSelected];
        [_leftRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftRightBtn.tag = TAG_COMPARE_CENTER;
        [self addSubview:_leftRightBtn];
        
        _upDownBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*(btn_w + space),0, btn_w,height)];
        [_upDownBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_upDownBtn setTitle:@"上下" forState:UIControlStateNormal];
        [_upDownBtn.titleLabel setFont:[UIFont systemFontOfSize:btnFont]];
//        _upDownBtn.layer.borderWidth = 1;
//        _upDownBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_upDownBtn setTitleColor:UIColorFromRGB(0x00d4e0) forState:UIControlStateSelected];
        [_upDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _upDownBtn.tag = TAG_COMPARE_RIGHT;
        [self addSubview:_upDownBtn];
    }
    return self;
}

-(void)typeButtonAction:(UIButton *)sender{
    switch (sender.tag) {
        case TAG_COMPARE_CENTER:
            if (!_leftRightBtn.selected) {
                _selfBtn.selected = NO;
                _leftRightBtn.selected = YES;
                _upDownBtn.selected = NO;
//                _selfBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//                _leftRightBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
//                _upDownBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_COMPARE_RIGHT:
            if (!_upDownBtn.selected) {
                _selfBtn.selected = NO;
                _leftRightBtn.selected = NO;
                _upDownBtn.selected = YES;
//                _selfBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//                _leftRightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//                _upDownBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
            }
            break;
        case TAG_COMPARE_LEFT:
            if (!_selfBtn.selected) {
                _selfBtn.selected = YES;
                _leftRightBtn.selected = NO;
                _upDownBtn.selected = NO;
//                _selfBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
//                _leftRightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//                _upDownBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
    }
    if ([self.delegate respondsToSelector:@selector(bottomThreeBtnClickWithTag:)]) {
        [self.delegate bottomThreeBtnClickWithTag:sender.tag];
    }
}
@end
