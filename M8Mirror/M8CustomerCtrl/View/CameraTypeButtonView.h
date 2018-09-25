//
//  CameraTypeButtonView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCustomButton.h"
@protocol CameraTypeButtonViewDelegate <NSObject>
-(void)cameraTypeButtonClickWithTag:(NSInteger)btnTag;
@end
@interface CameraTypeButtonView : UIView
@property (assign, nonatomic)id<CameraTypeButtonViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number;
@property (strong , nonatomic) FSCustomButton *RGBGBtn;
@property (strong , nonatomic) FSCustomButton *UVGBtn;
@property (strong , nonatomic) FSCustomButton *PZGBtn;

@end
