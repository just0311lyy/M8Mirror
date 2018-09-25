//
//  BottomPhotoCompareView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/2.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BottomPhotoCompareViewDelegate <NSObject>
-(void)bottomPhotoCompareButtonClickWithTag:(NSInteger)btnTag;
@end
@interface BottomPhotoCompareView : UIView
@property (assign, nonatomic)id<BottomPhotoCompareViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andNumber:(NSInteger)number;
@property (strong , nonatomic) UIButton *oneImgBtn;
@property (strong , nonatomic) UIButton *twoImgBtn;
@property (strong , nonatomic) UIButton *threeImgBtn;
@property (strong , nonatomic) UIButton *fourImgBtn;
@property (strong , nonatomic) UIButton *fiveImgBtn;
@property (strong , nonatomic) UIButton *sixImgBtn;
@property (strong , nonatomic) UIButton *sevenImgBtn;
@property (strong , nonatomic) UIButton *eightImgBtn;
@property (strong , nonatomic) UIButton *nineImgBtn;
@end
