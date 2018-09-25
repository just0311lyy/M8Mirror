//
//  ReportProductsView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ReportProductsView.h"

@implementation ReportProductsView

-(instancetype)initWithFrame:(CGRect)frame withNumber:(NSString *)numberStr andContentHeight:(CGFloat)contentHeight andContentFont:(CGFloat)font{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 20;
        
        CGFloat title_w = 3*width/2;
        CGFloat title_h = space + space/2;
        UILabel *numberLb = [[UILabel alloc] initWithFrame:CGRectMake(space, space,title_h,title_h)];
        [numberLb setFont:[UIFont systemFontOfSize:20]];
        [numberLb setTextColor:[UIColor whiteColor]];
        [numberLb setText:numberStr];
        [numberLb setBackgroundColor:LOGO_COLOR];
        [numberLb setTextAlignment:NSTextAlignmentCenter];
        [numberLb setNumberOfLines:0];
        [numberLb setLineBreakMode:NSLineBreakByWordWrapping];
        numberLb.layer.cornerRadius = title_h/2;
        numberLb.layer.masksToBounds = YES;
        [self addSubview:numberLb];
        
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(numberLb.frame) + space/2, CGRectGetMinY(numberLb.frame),title_w,CGRectGetHeight(numberLb.frame))];
        [_titleLb setFont:[UIFont systemFontOfSize:font+4]];
        [_titleLb setTextColor:UIColorFromRGB(0x575757)];
        [_titleLb setTextColor:LOGO_COLOR];
        [_titleLb setTextAlignment:NSTextAlignmentLeft];
        [_titleLb setNumberOfLines:0];
        [_titleLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_titleLb];
        //多少人在用
        _percentLb = [[UILabel alloc] initWithFrame:CGRectMake(width - space - title_w, CGRectGetMinY(_titleLb.frame),title_w,CGRectGetHeight(_titleLb.frame))];
        [_percentLb setFont:[UIFont systemFontOfSize:font]];
        [_percentLb setTextColor:UIColorFromRGB(0xb7b7b7)];
        [_percentLb setTextAlignment:NSTextAlignmentRight];
        [_percentLb setNumberOfLines:0];
        [_percentLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_percentLb];
        //内容
        //        CGFloat detailLb_w = [EditCellView getWidthWithText:detailTitle height:height font:16];
        _detailLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(numberLb.frame),CGRectGetMaxY(_titleLb.frame) + space,width - 2*space,contentHeight)];
        [_detailLb setFont:[UIFont systemFontOfSize:font]];
        [_detailLb setTextColor:UIColorFromRGB(0x9c9c9c)];
        [_detailLb setTextAlignment:NSTextAlignmentLeft];
        [_detailLb setNumberOfLines:0];
        [_detailLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_detailLb];
        
        //产品推荐
//        UIView *verView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_detailLb.frame),CGRectGetMaxY(_detailLb.frame) + space,2,space)];
//        verView.backgroundColor = LOGO_COLOR;
//        [self addSubview:verView];
        //
        UILabel *suggestLb = [[UILabel alloc] initWithFrame:CGRectMake(space,CGRectGetMaxY(_detailLb.frame) + space,width - 2*space,space)];
        [suggestLb setFont:[UIFont systemFontOfSize:font+2]];
//        [suggestLb setTextColor:UIColorFromRGB(0x575757)];
        [suggestLb setTextColor:LOGO_COLOR];
        [suggestLb setTextAlignment:NSTextAlignmentLeft];
        [suggestLb setText:@"产品推荐"];
        [suggestLb setNumberOfLines:0];
        [suggestLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:suggestLb];
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,height - 1, width, 1)];
//        lineView.backgroundColor = UIColorFromRGB(0xf5f6f7);
        lineView.backgroundColor = LOGO_COLOR;
        [self addSubview:lineView];
        
        UIButton *suggestBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, width,height)];
        [suggestBtn addTarget:self action:@selector(productsSuggestionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        suggestBtn.tag = TAG_REPORT_PROBLEM + [numberStr integerValue];
        [self addSubview:suggestBtn];
    }
    return self;
}

-(void)productsSuggestionButtonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(moreProductsShowClick:)]) {
        [self.delegate moreProductsShowClick:sender];
    }
}

@end
