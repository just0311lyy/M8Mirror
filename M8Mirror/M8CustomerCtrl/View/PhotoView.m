//
//  PhotoView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/22.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 20;
        //(640,480) 图片高度48*2，64*2
        CGFloat imgBtn_w = (width - space)/2;
        CGFloat imgBtn_h = height;
        
        _leftPhotoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, imgBtn_w,imgBtn_h)];
//        [_leftPhotoBtn setTitle:@"RGB光" forState:UIControlStateNormal];
        //    customerBtn.backgroundColor = [UIColor yellowColor];
        //        UIImage *customerImg = [UIImage scaleImage:[UIImage imageNamed:@"home_selected"] toSize:CGSizeMake(100, 100)];
        _leftPhotoBtn.layer.borderWidth = 1;
        _leftPhotoBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_leftPhotoBtn addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftPhotoBtn.tag = TAG_LEFT;
        [self addSubview:_leftPhotoBtn];
        
        _rightPhotoBtn = [[UIButton alloc] initWithFrame:CGRectMake(imgBtn_w + space,0, imgBtn_w,imgBtn_h)];
        _rightPhotoBtn.layer.borderWidth = 1;
        _rightPhotoBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_rightPhotoBtn addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightPhotoBtn.tag = TAG_RIGHT;
        [self addSubview:_rightPhotoBtn];
    }
    return self;
}

-(void)photoButtonAction:(UIButton *)sender{
    
    
//    if ([self.delegate respondsToSelector:@selector(cameraTypeButtonClickWithTag:)]) {
//        [self.delegate cameraTypeButtonClickWithTag:sender.tag];
//    }
}
@end
