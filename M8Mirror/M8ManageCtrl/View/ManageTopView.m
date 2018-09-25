//
//  ManageTopView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/13.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ManageTopView.h"

@implementation ManageTopView

-(instancetype)initWithFrame:(CGRect)frame andAdmin:(NSString *)admin andAdminImage:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        self.backgroundColor = LOGO_COLOR;
        CGFloat headImgView_W = 150;
        
//        UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(headBgView_W, (height - headBgView_W)/3, headBgView_W, headBgView_W)];
//        headBgView.layer.cornerRadius = headBgView_W/2;
//        headBgView.backgroundColor = LOGO_COLOR;
//        headBgView.layer.borderWidth = 2;
//        headBgView.layer.borderColor = [UIColor whiteColor].CGColor;
//        [self addSubview:headBgView];
        
        CGFloat space = 10;
        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((width - headImgView_W)/2, 0, headImgView_W, headImgView_W)];
        headImgView.image = image;
        headImgView.layer.cornerRadius = headImgView_W/2;
        [headImgView.layer setMasksToBounds:YES];
        [self addSubview:headImgView];
        
        CGFloat lb_W = CGRectGetWidth(headImgView.frame);
        CGFloat lb_H = 30;
        UILabel *adminLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(headImgView.frame),CGRectGetMaxY(headImgView.frame) + space, lb_W,lb_H)];
        [adminLb setFont:[UIFont systemFontOfSize:24]];
        [adminLb setText:admin];
        [adminLb setTextAlignment:NSTextAlignmentCenter];
        [adminLb setNumberOfLines:0];
        [adminLb setTextColor:[UIColor whiteColor]];
//        adminLb.layer.cornerRadius = 10;
//        [adminLb.layer setMasksToBounds:YES];
//        [adminLb setBackgroundColor:[UIColor orangeColor]];
        [adminLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:adminLb];
        //系统管理员
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(adminLb.frame),CGRectGetMaxY(adminLb.frame), CGRectGetWidth(adminLb.frame),CGRectGetHeight(adminLb.frame))];
        [titleLb setFont:[UIFont systemFontOfSize:16]];
        [titleLb setText:@"系统管理员"];
        [titleLb setTextAlignment:NSTextAlignmentCenter];
        [titleLb setNumberOfLines:0];
        [titleLb setTextColor:[UIColor whiteColor]];
        [titleLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:titleLb];
    }
    return self;
}

//-(void)leftBtnAction{
//    if ([self.delegate respondsToSelector:@selector(leftButtonClick)]) {
//        [self.delegate leftButtonClick];
//    }
//}
//
//-(void)rightBtnAction{
//    if ([self.delegate respondsToSelector:@selector(rightButtonClick)]) {
//        [self.delegate rightButtonClick];
//    }
//}

@end
