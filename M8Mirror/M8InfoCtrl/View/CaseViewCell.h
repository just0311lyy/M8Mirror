//
//  CaseViewCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/31.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *titleLabel;  //标题
@property (strong, nonatomic) UILabel *detailLabel;  //内容
@property (strong, nonatomic) UILabel *timeLabel; //检测日期

@end
