//
//  ManageTopView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/13.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ManageTopViewDelegate <NSObject>
//-(void)leftButtonClick;
//-(void)rightButtonClick;
@end
@interface ManageTopView : UIView
@property (assign, nonatomic)id<ManageTopViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andAdmin:(NSString *)admin andAdminImage:(UIImage *)image;
@end
