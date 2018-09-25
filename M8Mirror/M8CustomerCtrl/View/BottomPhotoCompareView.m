//
//  BottomPhotoCompareView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/2.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "BottomPhotoCompareView.h"

@implementation BottomPhotoCompareView

-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 10;
        //(640,480) 图片高度48，64
        CGFloat btn_w = (width - (number-1)*space)/number;
        
        _oneImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, btn_w,height)];
        [_oneImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _oneImgBtn.layer.borderWidth = 1;
        _oneImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
        _oneImgBtn.tag = TAG_BOTTOM_ONE;
        [self addSubview:_oneImgBtn];
        
        _twoImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(btn_w + space,0, btn_w,height)];
        [_twoImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _twoImgBtn.layer.borderWidth = 1;
        _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _twoImgBtn.tag = TAG_BOTTOM_TWO;
        [self addSubview:_twoImgBtn];
        
        _threeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*(btn_w + space),0, btn_w,height)];
        [_threeImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _threeImgBtn.layer.borderWidth = 1;
        _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _threeImgBtn.tag = TAG_BOTTOM_THREE;
        [self addSubview:_threeImgBtn];
        
        _fourImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(3*(btn_w + space),0, btn_w,height)];
        [_fourImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _fourImgBtn.layer.borderWidth = 1;
        _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _fourImgBtn.tag = TAG_BOTTOM_FOUR;
        [self addSubview:_fourImgBtn];
        
        _fiveImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(4*(btn_w + space),0, btn_w,height)];
        [_fiveImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _fiveImgBtn.layer.borderWidth = 1;
        _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _fiveImgBtn.tag = TAG_BOTTOM_FIVE;
        [self addSubview:_fiveImgBtn];
        
        _sixImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(5*(btn_w + space),0, btn_w,height)];
        [_sixImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _sixImgBtn.layer.borderWidth = 1;
        _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _sixImgBtn.tag = TAG_BOTTOM_SIX;
        [self addSubview:_sixImgBtn];
        
        _sevenImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(6*(btn_w + space),0, btn_w,height)];
        [_sevenImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _sevenImgBtn.layer.borderWidth = 1;
        _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _sevenImgBtn.tag = TAG_BOTTOM_SEVEN;
        [self addSubview:_sevenImgBtn];
        
        _eightImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(7*(btn_w + space),0, btn_w,height)];
        [_eightImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _eightImgBtn.layer.borderWidth = 1;
        _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _eightImgBtn.tag = TAG_BOTTOM_EIGHT;
        [self addSubview:_eightImgBtn];
        
        _nineImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(8*(btn_w + space),0, btn_w,height)];
        [_nineImgBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _nineImgBtn.layer.borderWidth = 1;
        _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _nineImgBtn.tag = TAG_BOTTOM_NINE;
        [self addSubview:_nineImgBtn];
        
    }
    return self;
}

-(void)typeButtonAction:(UIButton *)sender{
    switch (sender.tag) {
        case TAG_BOTTOM_TWO:
            if (!_twoImgBtn.selected) {
                _oneImgBtn.selected = NO;
                _twoImgBtn.selected = YES;
                _threeImgBtn.selected = NO;
                _fourImgBtn.selected = NO;
                _fiveImgBtn.selected = NO;
                _sixImgBtn.selected = NO;
                _sevenImgBtn.selected = NO;
                _eightImgBtn.selected = NO;
                _nineImgBtn.selected = NO;
                _oneImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _twoImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_BOTTOM_THREE:
            if (!_threeImgBtn.selected) {
                _oneImgBtn.selected = NO;
                _twoImgBtn.selected = NO;
                _threeImgBtn.selected = YES;
                _fourImgBtn.selected = NO;
                _fiveImgBtn.selected = NO;
                _sixImgBtn.selected = NO;
                _sevenImgBtn.selected = NO;
                _eightImgBtn.selected = NO;
                _nineImgBtn.selected = NO;
                _oneImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _threeImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_BOTTOM_FOUR:
            if (!_fourImgBtn.selected) {
                _oneImgBtn.selected = NO;
                _twoImgBtn.selected = NO;
                _threeImgBtn.selected = NO;
                _fourImgBtn.selected = YES;
                _fiveImgBtn.selected = NO;
                _sixImgBtn.selected = NO;
                _sevenImgBtn.selected = NO;
                _eightImgBtn.selected = NO;
                _nineImgBtn.selected = NO;
                _oneImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fourImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_BOTTOM_FIVE:
            if (!_fiveImgBtn.selected) {
                _oneImgBtn.selected = NO;
                _twoImgBtn.selected = NO;
                _threeImgBtn.selected = NO;
                _fourImgBtn.selected = NO;
                _fiveImgBtn.selected = YES;
                _sixImgBtn.selected = NO;
                _sevenImgBtn.selected = NO;
                _eightImgBtn.selected = NO;
                _nineImgBtn.selected = NO;
                _oneImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fiveImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_BOTTOM_SIX:
            if (!_sixImgBtn.selected) {
                _oneImgBtn.selected = NO;
                _twoImgBtn.selected = NO;
                _threeImgBtn.selected = NO;
                _fourImgBtn.selected = NO;
                _fiveImgBtn.selected = NO;
                _sixImgBtn.selected = YES;
                _sevenImgBtn.selected = NO;
                _eightImgBtn.selected = NO;
                _nineImgBtn.selected = NO;
                _oneImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sixImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_BOTTOM_SEVEN:
            if (!_sevenImgBtn.selected) {
                _oneImgBtn.selected = NO;
                _twoImgBtn.selected = NO;
                _threeImgBtn.selected = NO;
                _fourImgBtn.selected = NO;
                _fiveImgBtn.selected = NO;
                _sixImgBtn.selected = NO;
                _sevenImgBtn.selected = YES;
                _eightImgBtn.selected = NO;
                _nineImgBtn.selected = NO;
                _oneImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sevenImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_BOTTOM_EIGHT:
            if (!_eightImgBtn.selected) {
                _oneImgBtn.selected = NO;
                _twoImgBtn.selected = NO;
                _threeImgBtn.selected = NO;
                _fourImgBtn.selected = NO;
                _fiveImgBtn.selected = NO;
                _sixImgBtn.selected = NO;
                _sevenImgBtn.selected = NO;
                _eightImgBtn.selected = YES;
                _nineImgBtn.selected = NO;
                _oneImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _eightImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
        case TAG_BOTTOM_NINE:
            if (!_nineImgBtn.selected) {
                _oneImgBtn.selected = NO;
                _twoImgBtn.selected = NO;
                _threeImgBtn.selected = NO;
                _fourImgBtn.selected = NO;
                _fiveImgBtn.selected = NO;
                _sixImgBtn.selected = NO;
                _sevenImgBtn.selected = NO;
                _eightImgBtn.selected = NO;
                _nineImgBtn.selected = YES;
                _oneImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _nineImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
            }
            break;
        default:
            if (!_oneImgBtn.selected) {
                _oneImgBtn.selected = YES;
                _twoImgBtn.selected = NO;
                _threeImgBtn.selected = NO;
                _fourImgBtn.selected = NO;
                _fiveImgBtn.selected = NO;
                _sixImgBtn.selected = NO;
                _sevenImgBtn.selected = NO;
                _eightImgBtn.selected = NO;
                _nineImgBtn.selected = NO;
                _oneImgBtn.layer.borderColor = UIColorFromRGB(0x00d4e0).CGColor;
                _twoImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _threeImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fourImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _fiveImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sixImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _sevenImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _eightImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
                _nineImgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            }
            break;
    }
    if ([self.delegate respondsToSelector:@selector(bottomPhotoCompareButtonClickWithTag:)]) {
        [self.delegate bottomPhotoCompareButtonClickWithTag:sender.tag];
    }
}

@end
