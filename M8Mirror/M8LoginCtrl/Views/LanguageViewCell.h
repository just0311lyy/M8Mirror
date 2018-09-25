//
//  LanguageViewCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/7/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *countryImage;
@property (strong, nonatomic) UIImageView *selectedImage;
@property (strong, nonatomic) UILabel *countryNameLb;
+(CGFloat)getCellHeight;
@end
