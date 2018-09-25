//
//  customerListCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/11.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageWithStringView.h"
@interface customerListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UIImageView *sexImageView;
@property (strong, nonatomic) UILabel *nameLb;
@property (strong, nonatomic) ImageWithStringView *birthView;
@property (strong, nonatomic) ImageWithStringView *phoneView;
@end
