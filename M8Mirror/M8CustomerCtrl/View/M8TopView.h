//
//  M8TopView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/9.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M8TopViewDelegate <NSObject>
-(void)leftButtonClick;
-(void)rightButtonClick;
@end
@interface M8TopView : UIView
@property (assign, nonatomic)id<M8TopViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andTitleName:(NSString *)title andRightName:(NSString *)rightName;
@end
