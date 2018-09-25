//
//  DetailMessageView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/11.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "DetailMessageView.h"

@implementation DetailMessageView

-(instancetype)initWithFrame:(CGRect)frame andCustomer:(customerModel *)model{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = GREY_COLOR;
        
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 10;
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2 * space, space, width - 4 * space, height - 2 * space)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = space;
        [self addSubview:contentView];
        
        CGFloat headImg_W = CGRectGetHeight(contentView.frame) - 2 * space;
        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(space, space, headImg_W, headImg_W)];
        headImgView.image = [UIImage imageNamed:@"login_bg02.jpg"];
        headImgView.layer.cornerRadius = headImg_W/2;
        [headImgView.layer setMasksToBounds:YES];
        [contentView addSubview:headImgView];
        //姓名
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImgView.frame) + space, CGRectGetMinY(headImgView.frame), SCREEN_W/6,CGRectGetHeight(headImgView.frame))];
        [nameLb setFont:[UIFont systemFontOfSize:22]];
        [nameLb setText:model.name];
        [nameLb setTextAlignment:NSTextAlignmentLeft];
        [nameLb setNumberOfLines:0];
        [nameLb setTextColor:[UIColor blackColor]];
        [nameLb setLineBreakMode:NSLineBreakByWordWrapping];
        [contentView addSubview:nameLb];
        //电话
        UILabel *numberLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLb.frame) + space, CGRectGetMinY(nameLb.frame), SCREEN_W/4,CGRectGetHeight(nameLb.frame))];
        [numberLb setFont:[UIFont systemFontOfSize:18]];
        [numberLb setText:model.phoneNumber];
        [numberLb setTextAlignment:NSTextAlignmentLeft];
        [numberLb setNumberOfLines:0];
        [numberLb setTextColor:[UIColor grayColor]];
        [numberLb setLineBreakMode:NSLineBreakByWordWrapping];
        [contentView addSubview:numberLb];
        //出生年月
        UILabel *birthLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(numberLb.frame) + space, CGRectGetMinY(numberLb.frame), SCREEN_W/6,CGRectGetHeight(numberLb.frame))];
        [birthLb setFont:[UIFont systemFontOfSize:18]];
        [birthLb setText:model.birthday];
        [birthLb setTextAlignment:NSTextAlignmentLeft];
        [birthLb setNumberOfLines:0];
        [birthLb setTextColor:[UIColor grayColor]];
        [birthLb setLineBreakMode:NSLineBreakByWordWrapping];
        [contentView addSubview:birthLb];
        
        
//        CGFloat btn_w = 100;
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(contentView.frame) - space - SCREEN_W/5,CGRectGetMinY(birthLb.frame) + space, SCREEN_W/5,CGRectGetHeight(birthLb.frame) - 2 * space)];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:23];
        [editBtn setTitleColor:LOGO_COLOR forState:UIControlStateNormal];
        [editBtn setBackgroundColor:[UIColor whiteColor]];
        editBtn.layer.cornerRadius = (CGRectGetHeight(birthLb.frame) - 2 * space)/2;
        editBtn.layer.borderWidth = 2;
        editBtn.layer.borderColor = LOGO_COLOR.CGColor;
        [editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:editBtn];
    }
    return self;
}

-(void)editBtnAction{
    if ([self.delegate respondsToSelector:@selector(editButtonClick)]) {
        [self.delegate editButtonClick];
    }
}
@end
