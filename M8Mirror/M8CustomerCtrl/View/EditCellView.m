//
//  EditCellView.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/9.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "EditCellView.h"

@implementation EditCellView

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andDetailTitle:(NSString *)detailTitle{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];        
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        CGFloat space = 10;
        
        CGFloat title_w = [EditCellView getWidthWithText:title height:height font:20];
        _titleLl = [[UILabel alloc] initWithFrame:CGRectMake(2*space, 0,title_w,height)];
        [_titleLl setFont:[UIFont systemFontOfSize:20]];
        [_titleLl setText:title];
        [_titleLl setTextAlignment:NSTextAlignmentLeft];
        [_titleLl setNumberOfLines:0];
        [_titleLl setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_titleLl];
        //箭头
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - space - 23/2, (height - 42/2)/2, 23/2, 42/2)];
        arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
        [self addSubview:arrowImgView];
        //内容
//        CGFloat detailLb_w = [EditCellView getWidthWithText:detailTitle height:height font:16];
        _detailLb = [[UILabel alloc] initWithFrame:CGRectMake(width/2,0,width/2 - 2*space - CGRectGetWidth(arrowImgView.frame),height)];
        [_detailLb setFont:[UIFont systemFontOfSize:16]];
        [_detailLb setText:detailTitle];
        [_detailLb setTextColor:UIColorFromRGB(0x9c9c9c)];
        [_detailLb setTextAlignment:NSTextAlignmentRight];
        [_detailLb setNumberOfLines:0];
        [_detailLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_detailLb];
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(space, height - 1, width - space, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xf5f6f7);
        [self addSubview:lineView];

    }
    return self;
}

//-(void)cellButtonAction{
//    if ([self.delegate respondsToSelector:@selector(editCellViewClick)]) {
//        [self.delegate editCellViewClick];
//    }
//}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
