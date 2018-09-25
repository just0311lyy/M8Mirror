//
//  LanguageViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/7/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LanguageViewCell.h"

@implementation LanguageViewCell

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
    CGFloat height = [LanguageViewCell getCellHeight];
    //国旗图标 80x52
    CGFloat countryImage_w = 80*3/5;
    CGFloat countryImage_h = 52*3/5;
    _countryImage = [[UIImageView alloc] initWithFrame:CGRectMake(space,space, countryImage_w,countryImage_h)];
    [self.contentView addSubview:_countryImage];
    
    //选中状态
    CGFloat selectedImg_w = 30;
    _selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(width - space - selectedImg_w,(height - selectedImg_w)/2, selectedImg_w,selectedImg_w)];
    [self.contentView addSubview:_selectedImage];
    //日期
    _countryNameLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_countryImage.frame)+space,CGRectGetMinY(_countryImage.frame),width - countryImage_w - selectedImg_w - 4*space,CGRectGetHeight(_countryImage.frame))];
    _countryNameLb.font = [UIFont systemFontOfSize:20];
    [_countryNameLb setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_countryNameLb];

    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0,height-1, width,1)];
    bottomLineView.backgroundColor = UIColorFromRGB(0xf3f4f5);
    [self.contentView addSubview:bottomLineView];
}


+(CGFloat)getCellHeight{
    return 52*3/5 + 40;
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
