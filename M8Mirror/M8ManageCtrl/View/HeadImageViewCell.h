//
//  HeadImageViewCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImageViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *headTitleLb;
+(CGFloat)getCellHeight;
@end
