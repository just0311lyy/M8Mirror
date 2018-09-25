//
//  M8HistoryView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8HistoryView.h"

@implementation M8HistoryView

-(instancetype)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andName:(NSString *)nameStr andPhoneNumber:(NSString *)numberStr andBirthday:(NSString *)dayStr{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        self.backgroundColor = [UIColor whiteColor];
        CGFloat imgView_H = height/3;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, width, imgView_H)];
        imgView.backgroundColor = LOGO_COLOR;
        [self addSubview:imgView];
        
        CGFloat headImg_W = width/2;
        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((width - headImg_W)/2,imgView_H - headImg_W/2, headImg_W, headImg_W)];
        headImgView.image = [UIImage imageNamed:imageName];
        headImgView.layer.cornerRadius = headImg_W/2;
        [headImgView.layer setMasksToBounds:YES];
        headImgView.layer.borderWidth = 2;
        headImgView.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self addSubview:headImgView];
        //客户姓名
        CGFloat nameLb_H = height/6;
        CGFloat nameLb_W = width*2/3;
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake((width - nameLb_W)/2, height/2, nameLb_W, nameLb_H)];
        [nameLb setFont:[UIFont systemFontOfSize:28]];
        [nameLb setText:nameStr];
        [nameLb setTextAlignment:NSTextAlignmentCenter];
        [nameLb setNumberOfLines:0];
        [nameLb setTextColor:[UIColor blackColor]];
        [nameLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:nameLb];
        //电话
        CGFloat number_X = width/5;
        UILabel *numberLb = [[UILabel alloc] initWithFrame:CGRectMake(number_X, CGRectGetMaxY(nameLb.frame), nameLb_W, nameLb_H)];
        [numberLb setFont:[UIFont systemFontOfSize:22]];
        [numberLb setText:numberStr];
        [numberLb setTextAlignment:NSTextAlignmentLeft];
        [numberLb setNumberOfLines:0];
        [numberLb setTextColor:UIColorFromRGB(0xAAAAAA)];
        [numberLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:numberLb];
        //生日
        UILabel *dayStrLb = [[UILabel alloc] initWithFrame:CGRectMake(number_X, CGRectGetMaxY(numberLb.frame), nameLb_W, nameLb_H)];
        [dayStrLb setFont:[UIFont systemFontOfSize:22]];
        [dayStrLb setText:dayStr];
        [dayStrLb setTextAlignment:NSTextAlignmentLeft];
        [dayStrLb setNumberOfLines:0];
        [dayStrLb setTextColor:UIColorFromRGB(0xAAAAAA)];
        [dayStrLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:dayStrLb];
    }
    return self;
}

@end
