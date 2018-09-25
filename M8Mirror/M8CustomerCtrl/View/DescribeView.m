//
//  DescribeView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/19.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "DescribeView.h"

@implementation DescribeView

-(instancetype)initWithFrame:(CGRect)frame withDescribe:(NSString *)describeString andContent:(NSString *)contentString{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 10;
        CGFloat title_w = 60;
        UIColor *graycolor = UIColorFromRGB(0x626262);
        //高度固定为40
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(space,0, title_w,height)];
        [titleLb setFont:[UIFont systemFontOfSize:19]];
        [titleLb setText:describeString];
        [titleLb setTextAlignment:NSTextAlignmentCenter];
        [titleLb setNumberOfLines:0];
        [titleLb setTextColor:graycolor];
        [titleLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:titleLb];

        //问题内容
        UILabel *problemLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame) + space,0,width - 2*space,height)];
        [problemLb setFont:[UIFont systemFontOfSize:19]];
        [problemLb setText:contentString];
        [problemLb setTextAlignment:NSTextAlignmentLeft];
        [problemLb setNumberOfLines:0];
        [problemLb setTextColor:graycolor];
        [problemLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:problemLb];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(space, height-1, width - 2 * space, 1)];
        [lineView setBackgroundColor:UIColorFromRGB(0xf5f6f6)];
        [self addSubview:lineView];
    }
    return self;
}


@end
