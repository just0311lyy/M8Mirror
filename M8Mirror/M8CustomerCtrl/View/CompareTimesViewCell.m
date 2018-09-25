//
//  CompareTimesViewCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/3.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "CompareTimesViewCell.h"

@implementation CompareTimesViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self getCellView];
    }
    return self;
}

-(void)getCellView{
    CGFloat space = 5;
    CGFloat width = 165;
    CGFloat height = [CompareTimesViewCell getCellHeight];
    self.backgroundColor = [UIColor clearColor];
    //日期
    _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(0,0,width,height)];
    [_timeLb setTextColor:[UIColor whiteColor]];
    _timeLb.backgroundColor = [UIColor clearColor];
    _timeLb.font = [UIFont systemFontOfSize:16];
    [_timeLb setTextAlignment:NSTextAlignmentCenter];
    [_timeLb setNumberOfLines:0];
    [_timeLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:_timeLb];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(5,height - 1,width - 10,1)];
    bottomLineView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomLineView];
}

+(CGFloat)getCellHeight{
    return 30;
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
