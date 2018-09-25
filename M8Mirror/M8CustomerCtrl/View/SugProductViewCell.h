//
//  SugProductViewCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/6/24.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SugProductViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *titleLabel;  //标题
@property (strong, nonatomic) UILabel *detailLabel;  //内容
@property (strong, nonatomic) UILabel *priceLabel;  //价格
+(CGFloat)getCellHeight;
@end
