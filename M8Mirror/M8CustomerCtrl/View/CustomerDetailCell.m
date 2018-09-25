//
//  CustomerDetailCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/17.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "CustomerDetailCell.h"

@implementation CustomerDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self getCellView];
    }
    return self;
}

-(void)getCellView{
    CGFloat space = 10;
    CGFloat width = SCREEN_W;
    CGFloat height = [CustomerDetailCell getCellHeight];
    //时间条
    UIView *vercitalLineView = [[UIView alloc] initWithFrame:CGRectMake(space,space, 1,2*space)];
    vercitalLineView.backgroundColor =LOGO_COLOR;
    [self.contentView addSubview:vercitalLineView];
    //日期
    _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(vercitalLineView.frame)+space/2,0,12 * space, 4 * space)];
//    [_timeLb setTextColor:[UIColor whiteColor]];
    _timeLb.font = [UIFont systemFontOfSize:20];
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
    UIButton *reportBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - space - CGRectGetHeight(deleteBtn.frame) - 12 * space, 0, 10*space,CGRectGetHeight(_timeLb.frame))];
    [reportBtn setTitle:@"查看报告" forState:UIControlStateNormal];
    reportBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [reportBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [reportBtn addTarget:self action:@selector(reportButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:reportBtn];
    //scrollview
    CGFloat photo_H = 220;
    CGFloat photo_W = photo_H * 2/3;
    CGFloat photo_Y = 4*space;
    CGFloat photo_space = 2*space;
    UIScrollView *imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, photo_Y, width, height - photo_Y)];
    imgScrollView.contentSize = CGSizeMake(9*photo_W + 10*photo_space,height - photo_Y);
//    imgScrollView.backgroundColor = [UIColor yellowColor];
    imgScrollView.delegate = self;
    imgScrollView.clipsToBounds = NO; //将其子视图超出的部分显现出来
    imgScrollView.pagingEnabled = NO; //是否分页效果
    imgScrollView.showsHorizontalScrollIndicator = NO; //是否显示水平滚动条
    imgScrollView.showsVerticalScrollIndicator = NO;
//    imgScrollView.bounces = NO; //滑动到屏幕边缘则禁止继续滑动
    [self.contentView addSubview:imgScrollView];
    //纹理预测
    _WLImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photo_space, 0, photo_W, photo_H)];
//    _WLImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg01.jpg"]];
    [imgScrollView addSubview:_WLImgView];
    
    UILabel *WLLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_WLImgView.frame), CGRectGetMaxY(_WLImgView.frame), CGRectGetWidth(_WLImgView.frame), height - photo_Y - photo_H)];
    [WLLabel setFont:[UIFont systemFontOfSize:16]];
    [WLLabel setText:@"纹理预测"];
    [WLLabel setTextAlignment:NSTextAlignmentCenter];
    [WLLabel setNumberOfLines:0];
    [WLLabel setTextColor:UIColorFromRGB(0x626262)];
    [WLLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:WLLabel];
    //皮肤老化预测
    _PFLHImgView = [[UIImageView alloc] initWithFrame:CGRectMake(photo_W + 2*photo_space,0, photo_W, photo_H)];
//    _PFLHImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg02.jpg"]];
    [imgScrollView addSubview:_PFLHImgView];
    
    UILabel *PFLHLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_PFLHImgView.frame), CGRectGetMaxY(_PFLHImgView.frame), CGRectGetWidth(_PFLHImgView.frame), height - photo_Y - photo_H)];
    [PFLHLabel setFont:[UIFont systemFontOfSize:16]];
    [PFLHLabel setText:@"皮肤老化预测"];
    [PFLHLabel setTextAlignment:NSTextAlignmentCenter];
    [PFLHLabel setNumberOfLines:0];
    [PFLHLabel setTextColor:UIColorFromRGB(0x626262)];
    [PFLHLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:PFLHLabel];
    //红色区
    _HSQImgView = [[UIImageView alloc] initWithFrame:CGRectMake(2*photo_W + 3*photo_space, 0, photo_W, photo_H)];
//    HSQImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg03.jpg"]];
    [imgScrollView addSubview:_HSQImgView];
    
    UILabel *HSQLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_HSQImgView.frame), CGRectGetMaxY(_HSQImgView.frame), CGRectGetWidth(_HSQImgView.frame), height - photo_Y - photo_H)];
    [HSQLabel setFont:[UIFont systemFontOfSize:16]];
    [HSQLabel setText:@"红色区"];
    [HSQLabel setTextAlignment:NSTextAlignmentCenter];
    [HSQLabel setNumberOfLines:0];
    [HSQLabel setTextColor:UIColorFromRGB(0x626262)];
    [HSQLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:HSQLabel];
    //棕色区
    _ZSQImgView = [[UIImageView alloc] initWithFrame:CGRectMake(3*photo_W + 4*photo_space, 0, photo_W, photo_H)];
//    _ZSQImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg01.jpg"]];
    [imgScrollView addSubview:_ZSQImgView];
    
    UILabel *ZSQLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_ZSQImgView.frame), CGRectGetMaxY(_ZSQImgView.frame), CGRectGetWidth(_ZSQImgView.frame), height - photo_Y - photo_H)];
    [ZSQLabel setFont:[UIFont systemFontOfSize:16]];
    [ZSQLabel setText:@"棕色区"];
    [ZSQLabel setTextAlignment:NSTextAlignmentCenter];
    [ZSQLabel setNumberOfLines:0];
    [ZSQLabel setTextColor:UIColorFromRGB(0x626262)];
    [ZSQLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:ZSQLabel];
    //紫外线班
    _ZWXBImgView = [[UIImageView alloc] initWithFrame:CGRectMake(4*photo_W + 5*photo_space, 0, photo_W, photo_H)];
//    _ZWXBImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg02.jpg"]];
    [imgScrollView addSubview:_ZWXBImgView];
    
    UILabel *ZWXBLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_ZWXBImgView.frame), CGRectGetMaxY(_ZWXBImgView.frame), CGRectGetWidth(_ZWXBImgView.frame), height - photo_Y - photo_H)];
    [ZWXBLabel setFont:[UIFont systemFontOfSize:16]];
    [ZWXBLabel setText:@"紫外线斑"];
    [ZWXBLabel setTextAlignment:NSTextAlignmentCenter];
    [ZWXBLabel setNumberOfLines:0];
    [ZWXBLabel setTextColor:UIColorFromRGB(0x626262)];
    [ZWXBLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:ZWXBLabel];
    
    //图六
    _SIXImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5*photo_W + 6*photo_space, 0, photo_W, photo_H)];
    //    _ZWXBImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg02.jpg"]];
    [imgScrollView addSubview:_SIXImgView];
    
    UILabel *SIXLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_SIXImgView.frame), CGRectGetMaxY(_SIXImgView.frame), CGRectGetWidth(_SIXImgView.frame), height - photo_Y - photo_H)];
    [SIXLabel setFont:[UIFont systemFontOfSize:16]];
    [SIXLabel setText:@"图六"];
    [SIXLabel setTextAlignment:NSTextAlignmentCenter];
    [SIXLabel setNumberOfLines:0];
    [SIXLabel setTextColor:UIColorFromRGB(0x626262)];
    [SIXLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:SIXLabel];
    
    //图七
    _SEVENImgView = [[UIImageView alloc] initWithFrame:CGRectMake(6*photo_W + 7*photo_space, 0, photo_W, photo_H)];
    //    _ZWXBImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg02.jpg"]];
    [imgScrollView addSubview:_SEVENImgView];
    
    UILabel *SEVENLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_SEVENImgView.frame), CGRectGetMaxY(_SEVENImgView.frame), CGRectGetWidth(_SEVENImgView.frame), height - photo_Y - photo_H)];
    [SEVENLabel setFont:[UIFont systemFontOfSize:16]];
    [SEVENLabel setText:@"图七"];
    [SEVENLabel setTextAlignment:NSTextAlignmentCenter];
    [SEVENLabel setNumberOfLines:0];
    [SEVENLabel setTextColor:UIColorFromRGB(0x626262)];
    [SEVENLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:SEVENLabel];
    
    //图八
    _EIGHTImgView = [[UIImageView alloc] initWithFrame:CGRectMake(7*photo_W + 8*photo_space, 0, photo_W, photo_H)];
    //    _ZWXBImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg02.jpg"]];
    [imgScrollView addSubview:_EIGHTImgView];
    
    UILabel *EIGHTLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_EIGHTImgView.frame), CGRectGetMaxY(_EIGHTImgView.frame), CGRectGetWidth(_EIGHTImgView.frame), height - photo_Y - photo_H)];
    [EIGHTLabel setFont:[UIFont systemFontOfSize:16]];
    [EIGHTLabel setText:@"图八"];
    [EIGHTLabel setTextAlignment:NSTextAlignmentCenter];
    [EIGHTLabel setNumberOfLines:0];
    [EIGHTLabel setTextColor:UIColorFromRGB(0x626262)];
    [EIGHTLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:EIGHTLabel];
    
    //图九
    _NINEImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8*photo_W + 9*photo_space, 0, photo_W, photo_H)];
    //    _ZWXBImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"login_bg02.jpg"]];
    [imgScrollView addSubview:_NINEImgView];
    
    UILabel *NINELabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_NINEImgView.frame), CGRectGetMaxY(_NINEImgView.frame), CGRectGetWidth(_NINEImgView.frame), height - photo_Y - photo_H)];
    [NINELabel setFont:[UIFont systemFontOfSize:16]];
    [NINELabel setText:@"图九"];
    [NINELabel setTextAlignment:NSTextAlignmentCenter];
    [NINELabel setNumberOfLines:0];
    [NINELabel setTextColor:UIColorFromRGB(0x626262)];
    [NINELabel setLineBreakMode:NSLineBreakByWordWrapping];
    [imgScrollView addSubview:NINELabel];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(space,space, 1,2*space)];
    bottomLineView.backgroundColor =LOGO_COLOR;
    [self.contentView addSubview:bottomLineView];
}


-(void)reportButtonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(reportViewButtonClick:)]) {
        [self.delegate reportViewButtonClick:button];
        NSLog(@"点击了查勘报告");
    }
}

-(void)deleteButtonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:button];
        NSLog(@"点击了删除按钮");
    }
}

+(CGFloat)getCellHeight{
    return 300;
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
