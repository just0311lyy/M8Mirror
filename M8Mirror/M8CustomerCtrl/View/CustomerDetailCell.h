//
//  CustomerDetailCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/17.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomerDetailCellDelegate <NSObject>
-(void)reportViewButtonClick:(UIButton *)button;
-(void)deleteButtonClick:(UIButton *)button;
@end
@interface CustomerDetailCell : UITableViewCell <UIScrollViewDelegate>
//@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UILabel *timeLb; //检测日期
//@property (strong, nonatomic) UIButton *deleteBtn;
@property (strong, nonatomic) UIImageView *WLImgView;
@property (strong, nonatomic) UIImageView *PFLHImgView;
@property (strong, nonatomic) UIImageView *HSQImgView;
@property (strong, nonatomic) UIImageView *ZSQImgView;
@property (strong, nonatomic) UIImageView *ZWXBImgView;

@property (strong, nonatomic) UIImageView *SIXImgView;
@property (strong, nonatomic) UIImageView *SEVENImgView;
@property (strong, nonatomic) UIImageView *EIGHTImgView;
@property (strong, nonatomic) UIImageView *NINEImgView;

@property (assign, nonatomic)id<CustomerDetailCellDelegate> delegate;
+(CGFloat)getCellHeight;
@end
