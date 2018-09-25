//
//  ProductNetCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/23.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRangeSlider.h"
//#import "ProductNetModel.h"
@protocol ProductNetCellDelegate <NSObject>
// 回调方法
-(void)rangSlide:(TTRangeSlider *)sender andMinimum:(CGFloat)minimum andMaximum:(CGFloat)maximum;
// 回调方法结束
@end
@interface ProductNetCell : UITableViewCell<TTRangeSliderDelegate>
@property (nonatomic, assign) id<ProductNetCellDelegate>delegate;
//@property (nonatomic,strong) ProductNetModel *productNetModel;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *detailLb;

@property (nonatomic, strong) TTRangeSlider *sliderView;
+(CGFloat)getCellHeight;
@end
