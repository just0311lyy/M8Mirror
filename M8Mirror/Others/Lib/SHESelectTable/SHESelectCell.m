//
//  SHESelectCell.m
//  breeder
//
//  Created by xxx on 2017/11/21.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import "SHESelectCell.h"
#import "UIImage+category.h"
@implementation SHESelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        
//        CGFloat selfWidth = self.frame.size.width;
        _leftLab=[[UILabel alloc] initWithFrame:CGRectMake(50,0,self.frame.size.width/2, self.frame.size.height)];
        _leftLab.textAlignment = NSTextAlignmentLeft;
        _leftLab.font=[UIFont systemFontOfSize:24];
        [self addSubview:_leftLab];
        
        _selectBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50 - 40,(self.frame.size.height - 40)/2, 40, 40)];
        UIImage *image = [UIImage scaleImage:[UIImage imageNamed:@"select_right.png"] toSize:CGSizeMake(40, 40)];
        [_selectBtn setImage:image forState:UIControlStateNormal];
        _selectBtn.userInteractionEnabled = NO;
        _selectBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [self addSubview:_selectBtn];
        
         [self creatLineWithCGRect:CGRectMake(0, 0 ,self.frame.size.width, 1) withColor:UIColorFromRGB(0xf7f8f8) withView:self];
    }
    return self;
}
-(UILabel *)creatLineWithCGRect:(CGRect)rect withColor:(UIColor *)color withView:(UIView *)view
{
    UILabel *line=[[UILabel alloc] initWithFrame:rect];
    line.backgroundColor=color;
    [view addSubview:line];
    return line;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
