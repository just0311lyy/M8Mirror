//
//  BottomPhotoShowView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/27.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "BottomPhotoShowView.h"

@implementation BottomPhotoShowView

-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 10;
        //(640,480) 图片高度48*2，64*2
        CGFloat btn_w = (width - (number-1)*space)/number;
        //        self.backgroundColor = [UIColor whiteColor];
        
        _leftImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, btn_w,height)];
        [_leftImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftImgBtn.layer.borderWidth = 1;
        _leftImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
        _leftImgBtn.tag = TAG_BOTTOM_LEFT;
        [self addSubview:_leftImgBtn];
        
        _middleImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(btn_w + space,0, btn_w,height)];
        [_middleImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _middleImgBtn.layer.borderWidth = 1;
        _middleImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _middleImgBtn.tag = TAG_BOTTOM_MIDDLE;
        [self addSubview:_middleImgBtn];
        
        _rightImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*(btn_w + space),0, btn_w,height)];
        [_rightImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightImgBtn.layer.borderWidth = 1;
        _rightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightImgBtn.tag = TAG_BOTTOM_RIGHT;
        [self addSubview:_rightImgBtn];
    }
    return self;
}

-(void)typeButtonAction:(UIButton *)sender{
    switch (sender.tag) {
        case TAG_BOTTOM_MIDDLE:
            if (!_middleImgBtn.selected) {
                _leftImgBtn.selected = NO;
                _middleImgBtn.selected = YES;
                _rightImgBtn.selected = NO;
                _leftImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _middleImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _rightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_BOTTOM_RIGHT:
            if (!_rightImgBtn.selected) {
                _leftImgBtn.selected = NO;
                _middleImgBtn.selected = NO;
                _rightImgBtn.selected = YES;
                _leftImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _middleImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _rightImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
            }
            break;
        default:
            if (!_leftImgBtn.selected) {
                _leftImgBtn.selected = YES;
                _middleImgBtn.selected = NO;
                _rightImgBtn.selected = NO;
                _leftImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _middleImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _rightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
    }
    if ([self.delegate respondsToSelector:@selector(bottomPhotoButtonClickWithTag:)]) {
        [self.delegate bottomPhotoButtonClickWithTag:sender.tag];
    }
}


@end
