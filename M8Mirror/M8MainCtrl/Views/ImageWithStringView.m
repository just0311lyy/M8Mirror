//
//  ImageWithStringView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/21.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ImageWithStringView.h"

@implementation ImageWithStringView

-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 10;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height/4, height/2, height/2)];
        imgView.image = image;
        [self addSubview:imgView];
        
        _numberLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + space,0,width - height - space, height)];
//        numberLb.backgroundColor = [UIColor blueColor];
        [_numberLb setFont:[UIFont systemFontOfSize:18]];
//        [_numberLb setText:_numberStr];
        [_numberLb setTextAlignment:NSTextAlignmentLeft];
        [_numberLb setNumberOfLines:0];
        [_numberLb setTextColor:UIColorFromRGB(0x868686)];
        [_numberLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_numberLb];

    }
    return self;
}


@end
