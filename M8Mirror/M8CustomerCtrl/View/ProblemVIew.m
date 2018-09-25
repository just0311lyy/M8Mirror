//
//  ProblemVIew.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/18.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ProblemVIew.h"

@implementation ProblemVIew

-(instancetype)initWithFrame:(CGRect)frame/* withProblem:(NSString *)problem andStarLevel:(NSString *)levelString*/{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 10;
        CGFloat title_w = 60;
        //高度固定为40
        //问题
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(space,0, title_w,height)];
        [titleLb setFont:[UIFont systemFontOfSize:19]];
        [titleLb setText:@"问题"];
        [titleLb setTextAlignment:NSTextAlignmentCenter];
        [titleLb setNumberOfLines:0];
        [titleLb setTextColor:UIColorFromRGB(0x626262)];
        [titleLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:titleLb];
        //严重程度
        UIColor *orangeColor = UIColorFromRGB(0xffa900);
        _levelLb = [[UILabel alloc] initWithFrame:CGRectMake(width - space - title_w,0, title_w,height)];
        [_levelLb setFont:[UIFont systemFontOfSize:19]];
//        [_levelLb setText:_levelString];
        [_levelLb setTextAlignment:NSTextAlignmentCenter];
        [_levelLb setNumberOfLines:0];
        [_levelLb setTextColor:orangeColor];
        [_levelLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_levelLb];
        //☆★
//        NSString *stars;
//        if ([_levelString isEqualToString:@"正常"]) {
//            stars = @"★★★";
//        }else if ([_levelString isEqualToString:@"一般"] || [_levelString isEqualToString:@"轻度"]){
//            stars = @"★★";
//        }else{
//            stars = @"★";
//        }
        CGFloat stars_w = 80;
        _starsLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_levelLb.frame) - stars_w,0, stars_w,height)];
        [_starsLb setFont:[UIFont systemFontOfSize:19]];
//        [_starsLb setText:stars];
        [_starsLb setTextAlignment:NSTextAlignmentRight];
        [_starsLb setNumberOfLines:0];
        [_starsLb setTextColor:orangeColor];
        [_starsLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_starsLb];
        //问题内容
        _problemLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLb.frame) + space,0, CGRectGetMinX(_starsLb.frame) - (CGRectGetMaxX(titleLb.frame) + space),height)];
        [_problemLb setFont:[UIFont systemFontOfSize:19]];
//        [_problemLb setText:problem];
        [_problemLb setTextAlignment:NSTextAlignmentLeft];
        [_problemLb setNumberOfLines:0];
        [_problemLb setTextColor:UIColorFromRGB(0x56b9db)];
        [_problemLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_problemLb];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(space, height-1, width - 2 * space, 1)];
        [lineView setBackgroundColor:UIColorFromRGB(0xf5f6f6)];
        [self addSubview:lineView];
    }
    return self;
}

@end
