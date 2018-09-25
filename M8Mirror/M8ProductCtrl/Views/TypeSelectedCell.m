//
//  TypeSelectedCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/24.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "TypeSelectedCell.h"

@implementation TypeSelectedCell

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
    CGFloat height = [TypeSelectedCell getCellHeight];

    //类型名称
    _typeLb = [[UILabel alloc] initWithFrame:CGRectMake(space,0,SCREEN_W/2 - space,height)];
    _typeLb.font = [UIFont systemFontOfSize:24];
    [_typeLb setTextAlignment:NSTextAlignmentLeft];
    [_typeLb setNumberOfLines:0];
    [_typeLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self addSubview:_typeLb];
    
    CGFloat box_w = 30;
    _selectionButton = [[UIButton alloc] initWithFrame:CGRectMake(width - space - box_w, (height - box_w)/2, box_w, box_w)];
    [_selectionButton setImage:[UIImage imageNamed:@"btn_selected.png"] forState:UIControlStateSelected];
    [_selectionButton setImage:[UIImage imageNamed:@"btn_unselected.png"] forState:UIControlStateNormal];
//    _selectionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_selectionButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectionButton];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(space, height - 1, width - space, 1)];
    lineView.backgroundColor = GREY_LINE_COLOR;
    [self addSubview:lineView];

}

+(CGFloat)getCellHeight{
    return 70.f;
}

- (void)selectedButtonAction:(UIButton *)sender{
    //返回给delegate值
    if ([self.delegate respondsToSelector:@selector(selectedButton:andStock_code:andIsSelected:andIndexPathRow:)]) {
        if (self.selectionButton.selected == NO) {
            self.selectionButton.selected = YES;
            _typeLb.textColor = UIColorFromRGB(0x43a8d0);
            _isSelected = YES;
        }else{
            self.selectionButton.selected = NO;
            _typeLb.textColor = [UIColor blackColor];
            _isSelected = NO;
        }
        [self.delegate selectedButton:self.selectionButton andStock_code:self.typeString andIsSelected:self.isSelected andIndexPathRow:self.indexPathRow];
    }
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
