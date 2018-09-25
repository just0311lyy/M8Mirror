//
//  ProductViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ProductViewCell.h"

@implementation ProductViewCell


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat space = 15;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        //图片
//        CGFloat img_h = (396/528) * width;
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, width, width * 396/528)];
        _imgView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_imgView];
        
        //删除图标
        CGFloat deleteBtn_w = 25;
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(width - space - deleteBtn_w,space, deleteBtn_w, deleteBtn_w)];
        [deleteBtn setImage:[UIImage imageNamed:@"round_delete.png"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        
        //产品名称
        CGFloat titleLb_W = width - 2*space;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(space,CGRectGetMaxY(_imgView.frame)+space, titleLb_W, 40)];
        [_titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_titleLabel];
        //使用方法
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(space,CGRectGetMinY(_titleLabel.frame)+space,CGRectGetWidth(_titleLabel.frame), height - CGRectGetHeight(_imgView.frame) - 4*space)];
        [_detailLabel setFont:[UIFont systemFontOfSize:16]];
        [_detailLabel setTextAlignment:NSTextAlignmentLeft];
        [_detailLabel setNumberOfLines:2];
        [_detailLabel setTextColor:UIColorFromRGB(0xbdbdbd)];
        [_detailLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_detailLabel];
        //当前价格
        _currentPriceLb = [[UILabel alloc] initWithFrame:CGRectMake(space,height - space - CGRectGetHeight(_titleLabel.frame),45, CGRectGetHeight(_titleLabel.frame))];
        [_currentPriceLb setFont:[UIFont systemFontOfSize:20]];
        [_currentPriceLb setTextAlignment:NSTextAlignmentCenter];
        [_currentPriceLb setNumberOfLines:0];
        [_currentPriceLb setTextColor:UIColorFromRGB(0xed3b3d)];
        [_currentPriceLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_currentPriceLb];
        //折扣之后的价格
        _oldPriceLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_currentPriceLb.frame) + 10,CGRectGetMinY(_currentPriceLb.frame),45, CGRectGetHeight(_currentPriceLb.frame))];
        [_oldPriceLb setFont:[UIFont systemFontOfSize:16]];
        [_oldPriceLb setTextAlignment:NSTextAlignmentCenter];
        [_oldPriceLb setNumberOfLines:0];
        [_oldPriceLb setTextColor:UIColorFromRGB(0xb6b6b6)];
        [_oldPriceLb setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_oldPriceLb];
        //原价上面的横线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(_oldPriceLb.frame)-1)/2,CGRectGetWidth(_oldPriceLb.frame), 1)];
        lineView.backgroundColor = UIColorFromRGB(0xb6b6b6);
        [_oldPriceLb addSubview:lineView];
        //修改图标
        CGFloat editImgView_w = deleteBtn_w;
//        UIImageView *editImgView = [[UIImageView alloc] initWithFrame:CGRectMake(width - space - editImgView_w, height - space - editImgView_w, editImgView_w, editImgView_w)];
//        editImgView.image = [UIImage imageNamed:@"edit.png"];
//        [self addSubview:editImgView];
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(width - space - editImgView_w, height - space - editImgView_w, editImgView_w, editImgView_w)];
        [editBtn setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:editBtn];
        
        self.backgroundColor = [UIColor whiteColor];
//        self.contentView.layer.cornerRadius = 5;
    }
    return self;
}

-(void)deleteButtonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:sender];
    }
}

-(void)editButtonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(editButtonClick:)]) {
        [self.delegate editButtonClick:sender];
    }
}

@end
