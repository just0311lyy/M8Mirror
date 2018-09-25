//
//  CaseViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/31.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "CaseViewCell.h"

@implementation CaseViewCell

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
    CGFloat height = 100;
    //图
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(space, space, height - 2 * space,height - 2 * space)];
//    _imgView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imgView];
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + space, 0, width - CGRectGetMaxX(_imgView.frame) - space, height/2)];
//    [_titleLabel setTextColor:[UIColor blackColor]];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_titleLabel];

    //内容
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame),CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), height/4)];
    [_detailLabel setTextColor:UIColorFromRGB(0x7c7c7c)];
    _detailLabel.font = [UIFont systemFontOfSize:16];
    [_detailLabel setTextAlignment:NSTextAlignmentLeft];
    [_detailLabel setNumberOfLines:0];
    [_detailLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_detailLabel];
    
    //时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame),CGRectGetMaxY(_detailLabel.frame), CGRectGetWidth(_titleLabel.frame), height/4)];
    [_timeLabel setTextColor:UIColorFromRGB(0xb7b7b7)];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    [_timeLabel setTextAlignment:NSTextAlignmentLeft];
    [_timeLabel setNumberOfLines:0];
    [_timeLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_timeLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), height - 1, CGRectGetWidth(_titleLabel.frame), 1)];
    lineView.backgroundColor = UIColorFromRGB(0xf7f8f8);
    [self.contentView addSubview:lineView];
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
