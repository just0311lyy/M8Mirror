//
//  SettingFootView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingFootViewDelegate <NSObject>
-(void)loginOutButtonClick;
@end
@interface SettingFootView : UIView
@property (assign, nonatomic)id<SettingFootViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame;
@end
