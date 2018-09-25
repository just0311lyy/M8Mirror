//
//  HeadImageViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "HeadImageViewCell.h"

@implementation HeadImageViewCell

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
    CGFloat height = [HeadImageViewCell getCellHeight];
    
    _headTitleLb = [[UILabel alloc] initWithFrame:CGRectMake(space, 0, width/2 - space, height)];
    [_headTitleLb setFont:[UIFont systemFontOfSize:22]];
    [_headTitleLb setText:@"头像"];
    [_headTitleLb setTextAlignment:NSTextAlignmentLeft];
    [_headTitleLb setNumberOfLines:0];
    [_headTitleLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_headTitleLb];
    //箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - space/2 - 23/2, (height - 42/2)/2, 23/2, 42/2)];
    arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
    [self.contentView addSubview:arrowImgView];
    //头像
    CGFloat head_w = 80;
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(width - 3*space/2 - CGRectGetWidth(arrowImgView.frame) - head_w, (height - head_w)/2, head_w, head_w)];
//    _headImgView.image = [UIImage imageNamed:@"default_head.png"];
    [self.contentView addSubview:_headImgView];
}


+(CGFloat)getCellHeight{
    return 100;
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
