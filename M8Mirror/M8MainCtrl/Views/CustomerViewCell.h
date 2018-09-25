//
//  CustomerViewCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/20.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *sexImageView;
//@property (strong, nonatomic) NSString *sexStr;
@property (strong, nonatomic) UILabel *nameLb;
@property (strong, nonatomic) UILabel *numberLb;
@property (strong, nonatomic) UILabel *birthLb;

@end
