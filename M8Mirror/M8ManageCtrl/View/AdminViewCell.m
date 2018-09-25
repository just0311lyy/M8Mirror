//
//  AdminViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "AdminViewCell.h"

@implementation AdminViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self getCellView];
    }
    return self;
}

-(void)getCellView{
    CGFloat space = 20;
    CGFloat width = SCREEN_W;
    CGFloat height = [AdminViewCell getCellHeight];
    self.backgroundColor = [UIColor whiteColor];

        
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(space, 0,width/2 - space,height)];
    [_titleLb setFont:[UIFont systemFontOfSize:20]];
//        [_titleLl setText:title];
    [_titleLb setTextAlignment:NSTextAlignmentLeft];
    [_titleLb setNumberOfLines:0];
    [_titleLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self addSubview:_titleLb];
    //箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - space - 23/2, (height - 42/2)/2, 23/2, 42/2)];
    arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
    [self addSubview:arrowImgView];
    //内容
    _detailLb = [[UILabel alloc] initWithFrame:CGRectMake(width/2,0,width/2 - 2*space - CGRectGetWidth(arrowImgView.frame),height)];
    [_detailLb setFont:[UIFont systemFontOfSize:16]];
//        [_detailLb setText:detailTitle];
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

+(CGFloat)getCellHeight{
    return 70;
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
