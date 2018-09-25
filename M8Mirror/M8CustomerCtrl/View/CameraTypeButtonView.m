//
//  CameraTypeButtonView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "CameraTypeButtonView.h"
#define BUTTON_NORMAL UIColorFromRGB(0x666566)
#define BUTTON_SELECTED UIColorFromRGB(0x00f8ff)

@implementation CameraTypeButtonView

-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat btn_h = height/number;
//        self.backgroundColor = [UIColor whiteColor];
        UIImage *Img = [[UIImage scaleImage:[UIImage imageNamed:@"takephoto.png"] toSize:CGSizeMake(50, 50)] imageWithTintColor:BUTTON_NORMAL];
        UIImage *selectImg = [[UIImage scaleImage:[UIImage imageNamed:@"takephoto.png"] toSize:CGSizeMake(50, 50)] imageWithTintColor:BUTTON_SELECTED];
        
        _RGBGBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(0,0, width,btn_h)];
        _RGBGBtn.adjustsTitleTintColorAutomatically = YES;
        [_RGBGBtn setTintColor:BUTTON_NORMAL];
        _RGBGBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_RGBGBtn setTitle:@"RGB光" forState:UIControlStateNormal];
        //    customerBtn.backgroundColor = [UIColor yellowColor];
        //        UIImage *customerImg = [UIImage scaleImage:[UIImage imageNamed:@"home_selected"] toSize:CGSizeMake(100, 100)];
        [_RGBGBtn setImage:Img forState:UIControlStateNormal];
        [_RGBGBtn setImage:selectImg forState:UIControlStateSelected];
        _RGBGBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _RGBGBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
        [_RGBGBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _RGBGBtn.tag = TAG_RGBG;
        [self addSubview:_RGBGBtn];
        
        _UVGBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(0,btn_h, width, btn_h)];
        _UVGBtn.adjustsTitleTintColorAutomatically = YES;
        [_UVGBtn setTintColor:BUTTON_NORMAL];
        _UVGBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_UVGBtn setTitle:@"UV光" forState:UIControlStateNormal];
        //    infoBtn.backgroundColor = UIColorMake(222, 234, 214);
        //        [infoBtn setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
        [_UVGBtn setImage:Img forState:UIControlStateNormal];
        [_UVGBtn setImage:selectImg forState:UIControlStateSelected];
        _UVGBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _UVGBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
        [_UVGBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _UVGBtn.tag = TAG_UVG;
        [self addSubview:_UVGBtn];
        
        _PZGBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(0,2*btn_h,width, btn_h)];
        _PZGBtn.adjustsTitleTintColorAutomatically = YES;
        [_PZGBtn setTintColor:BUTTON_NORMAL];
        _PZGBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_PZGBtn setTitle:@"偏振光" forState:UIControlStateNormal];
        //    infoBtn.backgroundColor = UIColorMake(222, 234, 214);
        //        [infoBtn setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
        [_PZGBtn setImage:Img forState:UIControlStateNormal];
        [_PZGBtn setImage:selectImg forState:UIControlStateSelected];
        _PZGBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _PZGBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
        [_PZGBtn addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _PZGBtn.tag = TAG_PZG;
        [self addSubview:_PZGBtn];   
    }
    return self;
}

-(void)typeButtonAction:(UIButton *)sender{
    switch (sender.tag) {
        case TAG_UVG:
            if (!_UVGBtn.selected) {
                _RGBGBtn.selected = NO;
                _UVGBtn.selected = YES;
                _PZGBtn.selected = NO;
                [_RGBGBtn setTintColor:BUTTON_NORMAL];
                [_UVGBtn setTintColor:BUTTON_SELECTED];
                [_PZGBtn setTintColor:BUTTON_NORMAL];
            }
            break;
        case TAG_PZG:
            if (!_RGBGBtn.selected) {
                _RGBGBtn.selected = NO;
                _UVGBtn.selected = NO;
                _PZGBtn.selected = YES;
                [_RGBGBtn setTintColor:BUTTON_NORMAL];
                [_UVGBtn setTintColor:BUTTON_NORMAL];
                [_PZGBtn setTintColor:BUTTON_SELECTED];
            }
            break;
        default:
            if (!_RGBGBtn.selected) {
                _RGBGBtn.selected = YES;
                _UVGBtn.selected = NO;
                _PZGBtn.selected = NO;
                [_RGBGBtn setTintColor:BUTTON_SELECTED];
                [_UVGBtn setTintColor:BUTTON_NORMAL];
                [_PZGBtn setTintColor:BUTTON_NORMAL];
            }
            break;
    }
    if ([self.delegate respondsToSelector:@selector(cameraTypeButtonClickWithTag:)]) {
        [self.delegate cameraTypeButtonClickWithTag:sender.tag];
    }
}

@end
