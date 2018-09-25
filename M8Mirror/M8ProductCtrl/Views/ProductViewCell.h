//
//  ProductViewCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProductViewCellDelegate <NSObject>
// 回调方法
-(void)deleteButtonClick:(UIButton *)sender;// 回调方法结束
-(void)editButtonClick:(UIButton *)sender;
@end
@interface ProductViewCell : UICollectionViewCell
@property (nonatomic, assign) id<ProductViewCellDelegate> delegate;

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UILabel *currentPriceLb;
@property (strong, nonatomic) UILabel *oldPriceLb;
@end
