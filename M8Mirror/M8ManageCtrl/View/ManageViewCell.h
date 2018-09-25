//
//  ManageViewCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/12.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *titleLb;
@property (strong, nonatomic) UILabel *detailLb;
+(CGFloat)getCellHeight;
@end
