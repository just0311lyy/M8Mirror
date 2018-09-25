//
//  customerListCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/11.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "customerListCell.h"
#import "ImageWithStringView.h"
@implementation customerListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self getCellView];
    }
    return self;
}

-(void)getCellView{
    CGFloat space = 10;
//    CGFloat width = CGRectGetWidth(self.contentView.frame);
//    CGFloat height = CGRectGetHeight(self.contentView.frame);
    CGFloat width = SCREEN_W;
    CGFloat height = SCREEN_H/14;
    //头像
    CGFloat headBgView_W = height - 2*space;
    UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(space, space, headBgView_W, headBgView_W)];
    [self.contentView addSubview:headBgView];
    
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headBgView_W, headBgView_W)];
    _headImgView.layer.cornerRadius = headBgView_W/2;
    [_headImgView.layer setMasksToBounds:YES];
    [headBgView addSubview:_headImgView];
    //性别
    _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_headImgView.frame) - headBgView_W/4, CGRectGetHeight(_headImgView.frame) - headBgView_W/4, headBgView_W/4, headBgView_W/4)];
    _sexImageView.layer.cornerRadius = headBgView_W/8;
    _sexImageView.layer.borderWidth = 2;
    _sexImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [headBgView addSubview:_sexImageView];
    //客户姓名
    CGFloat nameLb_W = CGRectGetWidth(self.contentView.frame)-CGRectGetMaxX(headBgView.frame) - space;
    _nameLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headBgView.frame) + space,CGRectGetMinY(headBgView.frame), nameLb_W, CGRectGetHeight(headBgView.frame)/2)];
    [_nameLb setFont:[UIFont systemFontOfSize:22]];
//    [_nameLb setText:model.name];
    [_nameLb setTextAlignment:NSTextAlignmentLeft];
    [_nameLb setNumberOfLines:0];
    [_nameLb setTextColor:[UIColor blackColor]];
    [_nameLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_nameLb];
    //客户生日
    _birthView =[[ImageWithStringView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameLb.frame), CGRectGetMaxY(_nameLb.frame), CGRectGetWidth(_nameLb.frame), CGRectGetHeight(headBgView.frame)/2) andImage:[UIImage imageNamed:@"birthday.png"]];
    [self.contentView addSubview:_birthView];
    //客户电话
    _phoneView =[[ImageWithStringView alloc] initWithFrame:CGRectMake(width/2, CGRectGetMinY(_birthView.frame), width/2, CGRectGetHeight(_birthView.frame)) andImage:[UIImage imageNamed:@"phone.png"]];
    [self.contentView addSubview:_phoneView];
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, width, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xf5f5f6);
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
