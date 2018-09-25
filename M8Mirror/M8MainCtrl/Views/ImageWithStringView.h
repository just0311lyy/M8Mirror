//
//  ImageWithStringView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/21.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageWithStringView : UIView
@property (strong, nonatomic) UILabel *numberLb;
-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;
@end
