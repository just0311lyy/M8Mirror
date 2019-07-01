//
//  ClientDetailCell.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/1/9.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "ClientDetailCell.h"
#import "ReportModel.h"

#define detailFont GetLogicFont(14)
@implementation ClientDetailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self getCellView];
    }
    return self;
}

-(void)getCellView{
    CGFloat space = GetLogicPixelX(10);
//    CGFloat width = SCREEN_W;
    CGFloat height = [ClientDetailCell getCellHeight];
    //时间条
    UIView *vercitalLineView = [[UIView alloc] initWithFrame:CGRectMake(space,(6 * space - 2*space)/2,GetLogicPixelX(2),2*space)];
    vercitalLineView.backgroundColor = LOGO_COLOR;
    [self.contentView addSubview:vercitalLineView];
    //日期
    _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(vercitalLineView.frame) + space/2,0,GetLogicPixelX(200), 6 * space)];
    //    [_timeLb setTextColor:[UIColor whiteColor]];
    _timeLb.font = [UIFont systemFontOfSize:detailFont];
    [_timeLb setTextAlignment:NSTextAlignmentLeft];
    [_timeLb setNumberOfLines:0];
    [_timeLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_timeLb];
    
    //删除按钮
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - space - (CGRectGetHeight(_timeLb.frame) -space),space/2,CGRectGetHeight(_timeLb.frame)-space,CGRectGetHeight(_timeLb.frame)-space)];
    [deleteBtn setImage:[UIImage imageNamed:@"round_delete.png"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleteBtn];
    //查看报告按钮
//    UIButton *reportBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - space - CGRectGetHeight(deleteBtn.frame) - GetLogicPixelX(200), 0, GetLogicPixelX(200),CGRectGetHeight(_timeLb.frame))];
//    [reportBtn setTitle:@"查看报告" forState:UIControlStateNormal];
//    reportBtn.titleLabel.font = [UIFont systemFontOfSize:detailFont];
//    [reportBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [reportBtn addTarget:self action:@selector(reportButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:reportBtn];
    //scrollview
    CGFloat photo_H = GetLogicPixelX(220);
    CGFloat photo_W = photo_H * 2/3;
//    CGFloat photo_Y = 4*space;
    CGFloat photo_space = 2*space;
    
    //纹理预测
    _WLImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photo_space,CGRectGetMaxY(_timeLb.frame), photo_W, photo_H)];
    //    _WLImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg01.jpg"]];
    [self.contentView addSubview:_WLImgView];
    
    UILabel *WLLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_WLImgView.frame), CGRectGetMaxY(_WLImgView.frame), CGRectGetWidth(_WLImgView.frame), CGRectGetHeight(_timeLb.frame))];
    [WLLabel setFont:[UIFont systemFontOfSize:detailFont]];
    [WLLabel setText:@"纹理预测"];
    [WLLabel setTextAlignment:NSTextAlignmentCenter];
    [WLLabel setNumberOfLines:0];
    [WLLabel setTextColor:UIColorFromRGB(0x626262)];
    [WLLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:WLLabel];
    //皮肤老化预测
    _PFLHImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photo_W + 2*photo_space,CGRectGetMinY(_WLImgView.frame), photo_W, photo_H)];
    //    _PFLHImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg02.jpg"]];
    [self.contentView addSubview:_PFLHImgView];
    
    UILabel *PFLHLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_PFLHImgView.frame), CGRectGetMaxY(_PFLHImgView.frame), CGRectGetWidth(_PFLHImgView.frame), CGRectGetHeight(_timeLb.frame))];
    [PFLHLabel setFont:[UIFont systemFontOfSize:detailFont]];
    [PFLHLabel setText:@"皮肤老化预测"];
    [PFLHLabel setTextAlignment:NSTextAlignmentCenter];
    [PFLHLabel setNumberOfLines:0];
    [PFLHLabel setTextColor:UIColorFromRGB(0x626262)];
    [PFLHLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:PFLHLabel];
    //红色区
    _HSQImgView = [[UIImageView alloc] initWithFrame:CGRectMake(2*photo_W + 3*photo_space,CGRectGetMinY(_WLImgView.frame), photo_W, photo_H)];
    //    HSQImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg03.jpg"]];
    [self.contentView addSubview:_HSQImgView];
    
    UILabel *HSQLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_HSQImgView.frame), CGRectGetMaxY(_HSQImgView.frame), CGRectGetWidth(_HSQImgView.frame), CGRectGetHeight(_timeLb.frame))];
    [HSQLabel setFont:[UIFont systemFontOfSize:GetLogicFont(14)]];
    [HSQLabel setText:@"红色区"];
    [HSQLabel setTextAlignment:NSTextAlignmentCenter];
    [HSQLabel setNumberOfLines:0];
    [HSQLabel setTextColor:UIColorFromRGB(0x626262)];
    [HSQLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:HSQLabel];
    
    //详情按钮
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_HSQImgView.frame) + (SCREEN_W - CGRectGetMaxX(_HSQImgView.frame) - GetLogicPixelX(80))/2,CGRectGetMinY(_HSQImgView.frame) + (CGRectGetHeight(_HSQImgView.frame) - GetLogicPixelX(80))/2, GetLogicPixelX(80),GetLogicPixelX(80))];
    [detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:detailFont];
    [detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [detailBtn setBackgroundColor:LOGO_COLOR];
    detailBtn.layer.cornerRadius = GetLogicPixelX(80)/2;
    [detailBtn addTarget:self action:@selector(detailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:detailBtn];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0,height - GetLogicPixelX(2),SCREEN_W,GetLogicPixelX(2))];
    bottomLineView.backgroundColor = GREY_LINE_COLOR;
    [self.contentView addSubview:bottomLineView];
}

- (void)setReportModel:(ReportModel *)model{
    _reportModel = model;
    _timeLb.text = [model.reportDate substringWithRange:NSMakeRange(0,10)];
    if (model.oneImgPathStr) {
        _WLImgView.image = [[UIImage alloc] initWithContentsOfFile:model.oneImgPathStr];
    }
    if (model.twoImgPathStr) {
        _PFLHImgView.image = [[UIImage alloc] initWithContentsOfFile:model.twoImgPathStr];
    }
    if (model.threeImgPathStr) {
        _HSQImgView.image = [[UIImage alloc] initWithContentsOfFile:model.threeImgPathStr];
    }
}

-(void)reportButtonAction:(UIButton *)button{
//    if ([self.delegate respondsToSelector:@selector(reportViewButtonClick:)]) {
//        [self.delegate reportViewButtonClick:button];
//        NSLog(@"点击了查勘报告");
//    }
}

-(void)deleteButtonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:button];
        NSLog(@"点击了删除按钮");
    }
}

-(void)detailButtonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(detailButtonClick:)]) {
        [self.delegate detailButtonClick:button];
        NSLog(@"点击了删除按钮");
    }
}

+(CGFloat)getCellHeight{
    return (6 * GetLogicPixelX(10) + GetLogicPixelX(220) + 6 * GetLogicPixelX(10));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
