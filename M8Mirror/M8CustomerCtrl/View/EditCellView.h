//
//  EditCellView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/9.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol EditCellViewDelegate <NSObject>
//-(void)editCellViewClick;
//@end
@interface EditCellView : UIView
//@property (assign, nonatomic)id<EditCellViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andDetailTitle:(NSString *)detailTitle;
@property (nonatomic, strong) UILabel *titleLl;
@property (nonatomic, strong) UILabel *detailLb;
@end
