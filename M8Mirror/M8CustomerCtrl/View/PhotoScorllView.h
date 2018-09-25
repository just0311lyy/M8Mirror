//
//  PhotoScorllView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/18.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScorllView : UIView <UIScrollViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame;
@property (strong, nonatomic) UIImageView *WLImgView;
@property (strong, nonatomic) UIImageView *PFLHImgView;
@property (strong, nonatomic) UIImageView *HSQImgView;
@property (strong, nonatomic) UIImageView *ZSQImgView;
@property (strong, nonatomic) UIImageView *ZWXBImgView;

@property (strong, nonatomic) UIImageView *SIXImgView;
@property (strong, nonatomic) UIImageView *SEVENImgView;
@property (strong, nonatomic) UIImageView *EIGHTImgView;
@property (strong, nonatomic) UIImageView *NINEImgView;

@end
