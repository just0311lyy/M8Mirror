//
//  MainTabbarView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "MainTabbarView.h"
//#import "FSCustomButton.h"
@implementation MainTabbarView

-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat btn_w = width/number;
        self.backgroundColor = [UIColor whiteColor];
        UIImage *Img = [[UIImage scaleImage:[UIImage imageNamed:@"home.png"] toSize:CGSizeMake(40, 40)] imageWithTintColor:GREY_TXT_COLOR];
        UIImage *selectImg = [[UIImage scaleImage:[UIImage imageNamed:@"home_selected.png"] toSize:CGSizeMake(40, 40)] imageWithTintColor:LOGO_COLOR];
        
        _homeBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(0,0, btn_w,height)];
        _homeBtn.adjustsTitleTintColorAutomatically = YES;
        [_homeBtn setTintColor:GREY_TXT_COLOR];
        _homeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_homeBtn setTitle:@"首页" forState:UIControlStateNormal];
        //    customerBtn.backgroundColor = [UIColor yellowColor];
//        UIImage *customerImg = [UIImage scaleImage:[UIImage imageNamed:@"home_selected"] toSize:CGSizeMake(100, 100)];
        [_homeBtn setImage:Img forState:UIControlStateNormal];
        [_homeBtn setImage:selectImg forState:UIControlStateSelected];
        _homeBtn.layer.cornerRadius = 4;
        _homeBtn.layer.borderWidth = 2;
        _homeBtn.layer.borderColor = UIColorFromRGB(0xEDEDED).CGColor;
        _homeBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _homeBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
        [_homeBtn addTarget:self action:@selector(tabbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _homeBtn.tag = TAG_HOME;
        [self addSubview:_homeBtn];
        
        _customerBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(btn_w,0, btn_w, height)];
        _customerBtn.adjustsTitleTintColorAutomatically = YES;
        [_customerBtn setTintColor:GREY_TXT_COLOR];
        _customerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_customerBtn setTitle:@"客户档案" forState:UIControlStateNormal];
        //    infoBtn.backgroundColor = UIColorMake(222, 234, 214);
        //        [infoBtn setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
        [_customerBtn setImage:Img forState:UIControlStateNormal];
        [_customerBtn setImage:selectImg forState:UIControlStateSelected];
        _customerBtn.layer.cornerRadius = 4;
        _customerBtn.layer.borderWidth = 2;
        _customerBtn.layer.borderColor = UIColorFromRGB(0xEDEDED).CGColor;
        _customerBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _customerBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
        [_customerBtn addTarget:self action:@selector(tabbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _customerBtn.tag = TAG_LIST;
        [self addSubview:_customerBtn];
        
        _infoBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(btn_w * 2,0, btn_w, height)];
        _infoBtn.adjustsTitleTintColorAutomatically = YES;
        [_infoBtn setTintColor:GREY_TXT_COLOR];
        _infoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_infoBtn setTitle:@"信息中心" forState:UIControlStateNormal];
        //    infoBtn.backgroundColor = UIColorMake(222, 234, 214);
//        [infoBtn setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
        [_infoBtn setImage:Img forState:UIControlStateNormal];
        [_infoBtn setImage:selectImg forState:UIControlStateSelected];
        _infoBtn.layer.cornerRadius = 4;
        _infoBtn.layer.borderWidth = 2;
        _infoBtn.layer.borderColor = UIColorFromRGB(0xEDEDED).CGColor;
        _infoBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _infoBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
        [_infoBtn addTarget:self action:@selector(tabbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _infoBtn.tag = TAG_INFO;
        [self addSubview:_infoBtn];
        //产品
        _productBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(3 * btn_w, 0, btn_w,height)];
        _productBtn.adjustsTitleTintColorAutomatically = YES;
        [_productBtn setTintColor:GREY_TXT_COLOR];
        _productBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_productBtn setTitle:@"解决方案" forState:UIControlStateNormal];
        //    planBtn.backgroundColor = UIColorMake(222, 234, 214);
//        [solveBtn setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
        [_productBtn setImage:Img forState:UIControlStateNormal];
        [_productBtn setImage:selectImg forState:UIControlStateSelected];
        _productBtn.layer.cornerRadius = 4;
        _productBtn.layer.borderWidth = 2;
        _productBtn.layer.borderColor = UIColorFromRGB(0xEDEDED).CGColor;
        _productBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _productBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
        [_productBtn addTarget:self action:@selector(tabbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _productBtn.tag = TAG_PRODUCT;
        [self addSubview:_productBtn];
        
        _myBtn = [[FSCustomButton alloc] initWithFrame:CGRectMake(4 * btn_w, 0, btn_w,height)];
        _myBtn.adjustsTitleTintColorAutomatically = YES;
        [_myBtn setTintColor:GREY_TXT_COLOR];
        _myBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_myBtn setTitle:@"我的" forState:UIControlStateNormal];
        //    setBtn.backgroundColor = UIColorMake(222, 234, 214);
//        [myBtn setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
        [_myBtn setImage:Img forState:UIControlStateNormal];
        [_myBtn setImage:selectImg forState:UIControlStateSelected];
        _myBtn.layer.cornerRadius = 4;
        _myBtn.layer.borderWidth = 2;
        _myBtn.layer.borderColor = UIColorFromRGB(0xEDEDED).CGColor;
        _myBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        _myBtn.titleEdgeInsets = UIEdgeInsetsMake(8, 0, 0, 0);
        [_myBtn addTarget:self action:@selector(tabbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _myBtn.tag = TAG_MINE;
        [self addSubview:_myBtn];
        
    }
    return self;
}

-(void)tabbarButtonAction:(UIButton *)sender{
    switch (sender.tag) {
        case TAG_LIST:
            if (!_customerBtn.selected) {
                _homeBtn.selected = NO;
                _customerBtn.selected = YES;
                _infoBtn.selected = NO;
                _productBtn.selected = NO;
                _myBtn.selected = NO;
                [_homeBtn setTintColor:GREY_TXT_COLOR];
                [_customerBtn setTintColor:LOGO_COLOR];
                [_infoBtn setTintColor:GREY_TXT_COLOR];
                [_productBtn setTintColor:GREY_TXT_COLOR];
                [_myBtn setTintColor:GREY_TXT_COLOR];
            }
            break;
        case TAG_INFO:
            if (!_infoBtn.selected) {
                _homeBtn.selected = NO;
                _customerBtn.selected = NO;
                _infoBtn.selected = YES;
                _productBtn.selected = NO;
                _myBtn.selected = NO;
                [_homeBtn setTintColor:GREY_TXT_COLOR];
                [_customerBtn setTintColor:GREY_TXT_COLOR];
                [_infoBtn setTintColor:LOGO_COLOR];
                [_productBtn setTintColor:GREY_TXT_COLOR];
                [_myBtn setTintColor:GREY_TXT_COLOR];
            }
            break;
        case TAG_PRODUCT:
            if (!_productBtn.selected) {
                _homeBtn.selected = NO;
                _customerBtn.selected = NO;
                _infoBtn.selected = NO;
                _productBtn.selected = YES;
                _myBtn.selected = NO;
                [_homeBtn setTintColor:GREY_TXT_COLOR];
                [_customerBtn setTintColor:GREY_TXT_COLOR];
                [_infoBtn setTintColor:GREY_TXT_COLOR];
                [_productBtn setTintColor:LOGO_COLOR];
                [_myBtn setTintColor:GREY_TXT_COLOR];
            }
            break;
        case TAG_MINE:
            if (!_myBtn.selected) {
                _homeBtn.selected = NO;
                _customerBtn.selected = NO;
                _infoBtn.selected = NO;
                _productBtn.selected = NO;
                _myBtn.selected = YES;
                [_homeBtn setTintColor:GREY_TXT_COLOR];
                [_customerBtn setTintColor:GREY_TXT_COLOR];
                [_infoBtn setTintColor:GREY_TXT_COLOR];
                [_productBtn setTintColor:GREY_TXT_COLOR];
                [_myBtn setTintColor:LOGO_COLOR];
            }
            break;
        default:
            if (!_homeBtn.selected) {
                _homeBtn.selected = YES;
                _customerBtn.selected = NO;
                _infoBtn.selected = NO;
                _productBtn.selected = NO;
                _myBtn.selected = NO;
                [_homeBtn setTintColor:LOGO_COLOR];
                [_customerBtn setTintColor:GREY_TXT_COLOR];
                [_infoBtn setTintColor:GREY_TXT_COLOR];
                [_productBtn setTintColor:GREY_TXT_COLOR];
                [_myBtn setTintColor:GREY_TXT_COLOR];
            }
            break;
    }
    if ([self.delegate respondsToSelector:@selector(mainTabbarButtonClickWithTag:)]) {
        [self.delegate mainTabbarButtonClickWithTag:sender.tag];
    }
}

@end
