//
//  ProductEditInfoCell.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/5.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "ProductEditInfoCell.h"
#import "ProductInfoModel.h"

@interface ProductEditInfoCell()<UITextFieldDelegate>

@property (nonatomic, weak) UILabel *titleNameLabel;

@end

@implementation ProductEditInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
        
        //        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return self;
}

- (void)setupUI
{
    CGFloat cell_h = [ProductEditInfoCell getProductEditInfoCellHeight];
    UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(GetLogicPixelX(30),(cell_h - GetLogicPixelX(30))/2, GetLogicPixelX(110), GetLogicPixelX(30))];
    titleNameLabel.textColor = UIColorFromRGB(0x333333);
    titleNameLabel.font = [UIFont systemFontOfSize:GetLogicFont(11)];
    titleNameLabel.backgroundColor = [UIColor yellowColor];
    titleNameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleNameLabel];
    self.titleNameLabel = titleNameLabel;
    
    UILabel * contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleNameLabel.frame) + GetLogicPixelX(10),CGRectGetMinY(titleNameLabel.frame), SCREEN_W - (CGRectGetMaxX(titleNameLabel.frame) + GetLogicPixelX(10) + GetLogicPixelX(30)),CGRectGetHeight(titleNameLabel.frame))];
    contentLbl.textAlignment = NSTextAlignmentRight;
    [contentLbl setTextColor:UIColorFromRGB(0x333333)];
    [contentLbl setFont:[UIFont systemFontOfSize:GetLogicFont(10)]];
    contentLbl.hidden = YES;
    [self addSubview:contentLbl];
    self.contentLbl = contentLbl;
    
    UITextField *contentTextField = [[UITextField alloc] init];
    contentTextField.textAlignment = NSTextAlignmentRight;
    contentTextField.frame = contentLbl.frame;
    contentTextField.textColor = UIColorFromRGB(0x333333);
    //    contentTextField.placeholder =
    contentTextField.font = [UIFont systemFontOfSize:GetLogicFont(10)];
    contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    contentTextField.adjustsFontSizeToFitWidth = YES;
    [self addSubview:contentTextField];
    self.contentTextField = contentTextField;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(GetLogicPixelX(30), [ProductEditInfoCell getProductEditInfoCellHeight] - GetLogicPixelX(1) ,SCREEN_W - GetLogicPixelX(30), GetLogicPixelX(1))];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self addSubview:lineView];
    
}

-(void)setPICellModel:(ProductInfoModel *)pICellModel{
    self.contentLbl.frame = CGRectMake(CGRectGetMaxX(self.titleNameLabel.frame) + GetLogicPixelX(10),CGRectGetMinY(self.titleNameLabel.frame), SCREEN_W - (CGRectGetMaxX(self.titleNameLabel.frame) + GetLogicPixelX(10) + GetLogicPixelX(30)),CGRectGetHeight(self.titleNameLabel.frame));
    self.contentTextField.frame = self.contentLbl.frame;
    
    
    pICellModel.contentTextField = self.contentTextField;
    pICellModel.contentLabel = self.contentLbl;
    self.contentLbl.text = pICellModel.contentString;
    switch (pICellModel.productInfoType) {
        case ProductInfoTypeName:
        {
            self.contentLbl.hidden = YES;
            self.contentTextField.hidden = NO;
            self.contentTextField.delegate = nil;
        }
            break;
        case ProductInfoTypeOriginalPrice:
        {
            self.contentLbl.hidden = YES;
            self.contentTextField.hidden = NO;
            self.contentTextField.delegate = self;
            self.contentTextField.keyboardType = UIKeyboardTypePhonePad;
        }
            break;
        case ProductInfoTypeDiscount:
        {
            self.contentLbl.hidden = YES;
            self.contentTextField.hidden = NO;
            self.contentTextField.delegate = self;
            self.contentTextField.keyboardType = UIKeyboardTypePhonePad;
        }
            break;
        case ProductInfoTypeDiscountPrice:
        {
            self.contentLbl.hidden = YES;
            self.contentTextField.hidden = NO;
            self.contentTextField.delegate = self;
            self.contentTextField.keyboardType = UIKeyboardTypePhonePad;
        }
            break;
        case ProductInfoTypeAttribute:
        {
            self.contentLbl.hidden = YES;
            self.contentTextField.hidden = NO;
            self.contentTextField.delegate = nil;
        }
            break;
        case ProductInfoTypeClass:
        {
            self.contentLbl.hidden = YES;
            self.contentTextField.hidden = NO;
            self.contentTextField.delegate = nil;

        }
            break;
        case ProductInfoTypeUseMethod:
        {
            self.contentLbl.hidden = YES;
            self.contentTextField.hidden = NO;
            self.contentTextField.delegate = nil;
        }
            break;
        default:
            break;
    }
    self.titleNameLabel.text = pICellModel.titleName;
    self.contentTextField.placeholder = pICellModel.contentString;
    //    self.contentTextField.text = cellModel.content;
    self.contentTextField.tag = pICellModel.productInfoType;
}

#pragma mark -- **** 输入检查 UITextFieldDelegate ****
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    if (textField.tag == 2) {
        //折扣 0-99
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 2) {
            textField.text = [toBeString substringToIndex:2];
            return NO;
        }
        else
        {
            return YES;
        }
    }else {
        return YES;
    }
    
}

+ (CGFloat)getProductEditInfoCellHeight{
    return GetLogicPixelX(70);
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
