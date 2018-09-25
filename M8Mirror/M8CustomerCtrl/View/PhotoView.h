//
//  PhotoView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/22.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView
-(instancetype)initWithFrame:(CGRect)frame;
@property (strong , nonatomic) UIButton *leftPhotoBtn;
@property (strong , nonatomic) UIButton *rightPhotoBtn;
@end
