//
//  ImagesSelectedCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/30.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ImagesSelectedCell.h"

@implementation ImagesSelectedCell

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
    CGFloat height = [ImagesSelectedCell getCellHeight];
    
    CGFloat img_w = 80;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(space,(height - img_w)/2, img_w, img_w)];
    [self addSubview:_imgView];
    
    CGFloat box_w = 30;
    _selectionButton = [[UIButton alloc] initWithFrame:CGRectMake(width - space - box_w, (height - box_w)/2, box_w, box_w)];
    [_selectionButton setImage:[UIImage imageNamed:@"btn_selected.png"] forState:UIControlStateSelected];
    [_selectionButton setImage:[UIImage imageNamed:@"btn_unselected.png"] forState:UIControlStateNormal];
    //    _selectionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_selectionButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectionButton];
    
    //类型名称
    _imgNameLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgView.frame) + space,CGRectGetMinY(_imgView.frame),CGRectGetMinX(_selectionButton.frame) - CGRectGetMaxX(_imgView.frame) - 2 * space,img_w)];
    _imgNameLb.font = [UIFont systemFontOfSize:24];
    [_imgNameLb setTextAlignment:NSTextAlignmentLeft];
    [_imgNameLb setNumberOfLines:0];
    [_imgNameLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self addSubview:_imgNameLb];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1,width, 1)];
    lineView.backgroundColor = GREY_LINE_COLOR;
    [self addSubview:lineView];
    
}

+(CGFloat)getCellHeight{
    return 100.f;
}

- (void)selectedButtonAction:(UIButton *)sender{
    //返回给delegate值
    if ([self.delegate respondsToSelector:@selector(selectedButton:andShowImg:andIsSelected:andIndexPathRow:)]) {
        if (self.selectionButton.selected == NO) {
            self.selectionButton.selected = YES;
            _isSelected = YES;
        }else{
            self.selectionButton.selected = NO;
            _isSelected = NO;
        }
        [self.delegate selectedButton:self.selectionButton andShowImg:self.showImgModel andIsSelected:self.isSelected andIndexPathRow:self.indexPathRow];
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
