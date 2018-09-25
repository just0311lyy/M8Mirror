//
//  CustomerViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "CustomerViewCell.h"

@implementation CustomerViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat space = 10;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        //头像
        CGFloat w = width - 2 * space;
        CGFloat h = height/2 - space;
        CGFloat headImg_W = w < h ? w : h;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((width - headImg_W)/2, height/2-headImg_W, headImg_W, headImg_W)];
        [self.contentView addSubview:bgView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, headImg_W, headImg_W)];
        //    headImgView.image = [UIImage imageNamed:model.imgName];
//        _imageView.image = [UIImage imageNamed:@"cus_man.png"];
        _imageView.layer.cornerRadius = headImg_W/2;
        [_imageView.layer setMasksToBounds:YES];
        [bgView addSubview:_imageView];
        //性别
        _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_imageView.frame) - headImg_W/4, CGRectGetHeight(_imageView.frame) - headImg_W/4, headImg_W/4, headImg_W/4)];
//        if ([_sexStr isEqualToString:@"man"]) {
////            sexImageView.backgroundColor = UIColorFromRGB(0x70b9f3);
//            sexImageView.image = [UIImage imageNamed:@"man.png"];
//        }else{
////            sexImageView.backgroundColor = UIColorFromRGB(0xef7cb1);
//            sexImageView.image = [UIImage imageNamed:@"woman.png"];
//        }
//        _sexImageView.image = [UIImage imageNamed:@"cus_man.png"];
        _sexImageView.layer.cornerRadius = headImg_W/8;
        _sexImageView.layer.borderWidth = 2;
        _sexImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        [sexImageView.layer setMasksToBounds:YES];
        [bgView addSubview:_sexImageView];
        
        //客户姓名
//        CGFloat nameLb_W = width/4;
        _nameLb = [[UILabel alloc] initWithFrame:CGRectMake(0,height/2, width, height/4)];
        [_nameLb setFont:[UIFont systemFontOfSize:24]];
        //    [_nameLb setText:model.name];
        [_nameLb setTextAlignment:NSTextAlignmentCenter];
        [_nameLb setNumberOfLines:0];
        [_nameLb setTextColor:[UIColor blackColor]];
        [_nameLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self.contentView addSubview:_nameLb];
        //客户出生日
        UIImageView *birthImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(bgView.frame)/2, height*3/4 + space/4, height/8 - space, height/8 - space)];
        birthImgView.image = [UIImage imageNamed:@"birthday.png"];
        [self.contentView addSubview:birthImgView];
        
        _birthLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(birthImgView.frame) + space,CGRectGetMinY(birthImgView.frame), width - (CGRectGetMaxX(birthImgView.frame) + space), CGRectGetHeight(birthImgView.frame))];
        [_birthLb setFont:[UIFont systemFontOfSize:18]];
        //    [_birthLb setText:model.birth];
        [_birthLb setTextAlignment:NSTextAlignmentLeft];
        [_birthLb setNumberOfLines:0];
        [_birthLb setTextColor:[UIColor grayColor]];
        [_birthLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self.contentView addSubview:_birthLb];
        //客户电话
        UIImageView *numberImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(birthImgView.frame), height*7/8 + space/4, CGRectGetWidth(birthImgView.frame), CGRectGetHeight(birthImgView.frame))];
        numberImgView.image = [UIImage imageNamed:@"phone.png"];
        [self.contentView addSubview:numberImgView];
        
        _numberLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(numberImgView.frame) + space,CGRectGetMinY(numberImgView.frame),CGRectGetWidth(_birthLb.frame), CGRectGetHeight(numberImgView.frame))];
        [_numberLb setFont:[UIFont systemFontOfSize:18]];
        //    [_numberLb setText:model.number];
        [_numberLb setTextAlignment:NSTextAlignmentLeft];
        [_numberLb setNumberOfLines:0];
        [_numberLb setTextColor:[UIColor grayColor]];
        [_numberLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self.contentView addSubview:_numberLb];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 5;
    }
    return self;
}

@end
