//
//  SugProductViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/24.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "SugProductViewCell.h"

@implementation SugProductViewCell

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
    CGFloat height = [SugProductViewCell getCellHeight];
    //图
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(space, space, height - 2 * space,height - 2 * space)];
    //    _imgView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imgView];
    
    //价格
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(width - 100 - space,(height - 60)/2,100,60)];
    [_priceLabel setTextColor:UIColorFromRGB(0xff5057)];
    _priceLabel.font = [UIFont systemFontOfSize:19];
    [_priceLabel setTextAlignment:NSTextAlignmentRight];
    [_priceLabel setNumberOfLines:0];
    [_priceLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_priceLabel];
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + space,CGRectGetMinY(_imgView.frame), width - CGRectGetMaxX(_imgView.frame) - 2*space - 100,CGRectGetHeight(_imgView.frame)/2)];
    //    [_titleLabel setTextColor:[UIColor blackColor]];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_titleLabel];
    
    //内容
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame),CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_titleLabel.frame))];
    [_detailLabel setTextColor:UIColorFromRGB(0x7c7c7c)];
    _detailLabel.font = [UIFont systemFontOfSize:18];
    [_detailLabel setTextAlignment:NSTextAlignmentLeft];
    [_detailLabel setNumberOfLines:0];
    [_detailLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_detailLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, width, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xefeff4);
    [self.contentView addSubview:lineView];
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
