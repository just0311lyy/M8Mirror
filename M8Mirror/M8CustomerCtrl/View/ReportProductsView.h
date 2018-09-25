//
//  ReportProductsView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReportProductsViewDelegate <NSObject>
-(void)moreProductsShowClick:(UIButton *)sender;
@end
@interface ReportProductsView : UIView
@property (assign, nonatomic)id<ReportProductsViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame withNumber:(NSString *)numberStr andContentHeight:(CGFloat)contentHeight andContentFont:(CGFloat )font;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *percentLb;
@property (nonatomic, strong) UILabel *detailLb;
@end
