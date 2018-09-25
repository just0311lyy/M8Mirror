//
//  BottomThreeBtnView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/7/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BottomThreeBtnViewDelegate <NSObject>
-(void)bottomThreeBtnClickWithTag:(NSInteger)btnTag;
@end
@interface BottomThreeBtnView : UIView
@property (assign, nonatomic)id<BottomThreeBtnViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number;
@property (strong , nonatomic) UIButton *selfBtn;
@property (strong , nonatomic) UIButton *leftRightBtn;
@property (strong , nonatomic) UIButton *upDownBtn;
@end
