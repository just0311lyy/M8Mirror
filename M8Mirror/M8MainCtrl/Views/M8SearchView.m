//
//  M8SearchView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "M8SearchView.h"

@implementation M8SearchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat searchLb_w = 100;
        
        UILabel *searchLb = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, searchLb_w, height)];
        [searchLb setFont:[UIFont systemFontOfSize:18]];
        [searchLb setText:@"客户姓名"];
        [searchLb setTextAlignment:NSTextAlignmentLeft];
        [searchLb setNumberOfLines:0];
        [searchLb setTextColor:UIColorFromRGB(0x40E0D0)];
        [searchLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:searchLb];
        
        CGFloat space = 4;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(searchLb.frame) + space, space, 1, height - space * 2)];
        lineView.backgroundColor = UIColorFromRGB(0xEDEDED);
        [self addSubview:lineView];
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + space, 0, width - (CGRectGetMaxX(lineView.frame) - space * 3), height)];
        [searchBar setBarStyle:UIBarStyleDefault];
        [searchBar setPlaceholder:@"请输入客户姓名"];
        [searchBar setBackgroundImage:[UIImage new]];
        [self addSubview:searchBar];
    }
    return self;
}

@end
