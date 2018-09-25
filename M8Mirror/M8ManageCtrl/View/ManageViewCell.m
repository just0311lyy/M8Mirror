//
//  ManageViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/12.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ManageViewCell.h"

@implementation ManageViewCell

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
    CGFloat height = [ManageViewCell getCellHeight];
    //图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(space,3*space/2, height - 3*space,height - 3*space)];
    [self.contentView addSubview:_imgView];
    //标题
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame)+space,0,SCREEN_W/2 - height,height)];
    _titleLb.font = [UIFont systemFontOfSize:22];
    [_titleLb setTextAlignment:NSTextAlignmentLeft];
    [_titleLb setNumberOfLines:0];
    [_titleLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_titleLb];
    
    //内容
    _detailLb = [[UILabel alloc] initWithFrame:CGRectMake(width/2,0,width/2 - 2*space - 23/2,height)];
    [_detailLb setTextColor:UIColorFromRGB(0xa3a3a3)];
    _detailLb.font = [UIFont systemFontOfSize:18];
    [_detailLb setTextAlignment:NSTextAlignmentRight];
    [_detailLb setNumberOfLines:0];
    [_detailLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_detailLb];
    //箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(width - space - 23/2, (height - 42/2)/2, 23/2, 42/2)];
    arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
    [self.contentView addSubview:arrowImgView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLb.frame),height - 1,width - height,1)];
    bottomLineView.backgroundColor = UIColorFromRGB(0xf3f4f5);
    [self.contentView addSubview:bottomLineView];
}

+(CGFloat)getCellHeight{
    return 60;
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
