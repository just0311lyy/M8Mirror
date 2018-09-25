//
//  EditSelectView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/10.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "EditSelectView.h"

@implementation EditSelectView

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andLeftBtnTitle:(NSString *)leftTitle andRightBtnTitle:(NSString *)rightTitle{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 10;
        
        CGFloat title_w = [EditSelectView getWidthWithText:title height:height font:20];
        _titleLl = [[UILabel alloc] initWithFrame:CGRectMake(2*space, 0,title_w,height)];
        [_titleLl setFont:[UIFont systemFontOfSize:20]];
        [_titleLl setText:title];
        [_titleLl setTextAlignment:NSTextAlignmentLeft];
        [_titleLl setNumberOfLines:0];
        [_titleLl setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_titleLl];
        //选择1
        CGFloat btn_w = 80;
        CGFloat btn_h = btn_w/2;
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(width - 2*space - 2*btn_w, (height - btn_h)/2,btn_w,btn_h)];
        _leftBtn.selected = YES;
        [_leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"round_unselected.png"] toSize:CGSizeMake(24, 24)] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"button_selected.png"] toSize:CGSizeMake(24, 24)] forState:UIControlStateSelected];
        [_leftBtn addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.tag = 100;
        [self addSubview:_leftBtn];
        //选择2
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(width - space - CGRectGetWidth(_leftBtn.frame), CGRectGetMinY(_leftBtn.frame),CGRectGetWidth(_leftBtn.frame),CGRectGetHeight(_leftBtn.frame))];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"round_unselected.png"] toSize:CGSizeMake(24, 24)] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage scaleImage:[UIImage imageNamed:@"button_selected.png"] toSize:CGSizeMake(24, 24)] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.tag = 101;
        [self addSubview:_rightBtn];

        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(space, height - 1, width - space, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xf5f6f7);
        [self addSubview:lineView];

    }
    return self;
}

-(void)buttonSelectAction:(UIButton *)sender{
    for (int i = 0; i<2; i++) {
        if (sender.tag == 100 + i) {
            sender.selected =YES;
            continue;
        }
        UIButton *but = (UIButton*)[self viewWithTag:i+100];
        but.selected = NO;
    }
    if ([self.delegate respondsToSelector:@selector(editSelectClick:withTitle:)]) {
        [self.delegate editSelectClick:sender withTitle:_titleLl.text];
    }
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
