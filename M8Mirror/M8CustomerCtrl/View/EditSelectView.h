//
//  EditSelectView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/10.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditSelectViewDelegate <NSObject>
-(void)editSelectClick:(UIButton *)button withTitle:(NSString *)title;
@end
@interface EditSelectView : UIView
@property (assign, nonatomic)id<EditSelectViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andLeftBtnTitle:(NSString *)leftTitle andRightBtnTitle:(NSString *)rightTitle;
@property (nonatomic, strong) UILabel *titleLl;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@end
