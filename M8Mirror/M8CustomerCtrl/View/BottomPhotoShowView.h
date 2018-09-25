//
//  BottomPhotoShowView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/27.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BottomPhotoShowViewDelegate <NSObject>
-(void)bottomPhotoButtonClickWithTag:(NSInteger)btnTag;
@end
@interface BottomPhotoShowView : UIView
@property (assign, nonatomic)id<BottomPhotoShowViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number;
@property (strong , nonatomic) UIButton *leftImgBtn;
@property (strong , nonatomic) UIButton *middleImgBtn;
@property (strong , nonatomic) UIButton *rightImgBtn;
@end
