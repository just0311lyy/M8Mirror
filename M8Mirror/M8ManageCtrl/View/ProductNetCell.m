//
//  ProductNetCell.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ProductNetCell.h"
//@interface ProductNetCell (){
//    UILabel *_typeLb;
//    UILabel *_detailLb;
//    TTRangeSlider *_sliderView;
//
//    ProductNetModel *_productNetModel;
//}
//-(void)getCellView;
//@end
@implementation ProductNetCell

//@synthesize productNetModel = _productNetModel;
//-(ProductNetModel *)productNetModel{
//    return _productNetModel;
//}
//
//-(void)setProductNetModel:(ProductNetModel *)productNetModel{
//    if (_productNetModel != productNetModel) {
//        _productNetModel = nil;
//        _productNetModel = productNetModel;
//
//        NSString *typeStr = [_productNetModel.typeName stringByAppendingString:@" %"];
//        _typeLb.text = typeStr;
//        _sliderView.selectedMinimum = _productNetModel.minPercent;
//        _sliderView.selectedMaximum = _productNetModel.maxPercent;
//        NSString *detailStr = @"";
//        if (_productNetModel.productTypeArr.count > 0) {
//            for (int i = 0; i < _productNetModel.productTypeArr.count; i++) {
//                detailStr = [detailStr stringByAppendingFormat:@"   %@",_productNetModel.productTypeArr[i]];
//            }
//        }
//        _detailLb.text = detailStr;
//    }
//}

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
    CGFloat height = [ProductNetCell getCellHeight];
    self.backgroundColor = [UIColor whiteColor];
    //文字内容
    CGFloat title_h = 4*height/10;
    _typeLb = [[UILabel alloc] initWithFrame:CGRectMake(space, 0,width/2 - space,title_h)];
    [_typeLb setFont:[UIFont systemFontOfSize:26]];
    [_typeLb setTextColor:UIColorFromRGB(0x4e4e4e)];
    [_typeLb setTextAlignment:NSTextAlignmentLeft];
    [_typeLb setNumberOfLines:0];
    [_typeLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self addSubview:_typeLb];
    //箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W - space - 23/2, (title_h - 42/2)/2, 23/2, 42/2)];
    arrowImgView.image = [UIImage imageNamed:@"arrow.png"];
    [self addSubview:arrowImgView];
    //内容
    _detailLb = [[UILabel alloc] initWithFrame:CGRectMake(width/2,0,width/2 - 3*space/2 - CGRectGetWidth(arrowImgView.frame),title_h)];
    [_detailLb setFont:[UIFont systemFontOfSize:22]];
    [_detailLb setTextColor:UIColorFromRGB(0x9c9c9c)];
    [_detailLb setTextAlignment:NSTextAlignmentRight];
    [_detailLb setNumberOfLines:0];
    [_detailLb setLineBreakMode:NSLineBreakByWordWrapping];
    [self addSubview:_detailLb];
    //下划线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(space, title_h - 1, width - space, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xefeff4);
    [self addSubview:lineView];
    //滑动条
    _sliderView = [[TTRangeSlider alloc] initWithFrame:CGRectMake(2*space,title_h,width - 4*space,height - title_h)];
    _sliderView.delegate = self;
    _sliderView.minValue = 0;
    _sliderView.maxValue = 100;
    [_sliderView setTintColor:LOGO_COLOR];
    [self addSubview:_sliderView];
    
    UIView *bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0,height-8,width, 8)];
    bottomlineView.backgroundColor = UIColorFromRGB(0xefeff4);
    [self addSubview:bottomlineView];
}

+(CGFloat)getCellHeight{
    return 160;
}

#pragma mark TTRangeSliderViewDelegate
-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
    if (sender == _sliderView){
        NSLog(@"Standard slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
        if ([self.delegate respondsToSelector:@selector(rangSlide:andMinimum:andMaximum:)]) {
            [self.delegate rangSlide:sender andMinimum:selectedMinimum andMaximum:selectedMaximum];
        }
        
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
