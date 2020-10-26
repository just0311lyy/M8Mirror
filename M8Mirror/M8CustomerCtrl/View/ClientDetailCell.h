//
//  ClientDetailCell.h
//  M8Mirror
//
//  Created by YangyangLi on 2019/1/9.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReportModel;
@protocol ClientDetailCellDelegate <NSObject>

//-(void)reportViewButtonClick:(UIButton *)button;
-(void)deleteButtonClick:(UIButton *)button;
-(void)detailButtonClick:(UIButton *)button;
@end

@interface ClientDetailCell : UITableViewCell

@property (strong, nonatomic) UILabel *timeLb; //检测日期
@property (strong, nonatomic) UIImageView *WLImgView;
@property (strong, nonatomic) UIImageView *PFLHImgView;
@property (strong, nonatomic) UIImageView *HSQImgView;
@property (strong, nonatomic) UIImageView *ZSQImgView;
@property (strong, nonatomic) UIImageView *ZWXBImgView;
@property (strong, nonatomic) UIImageView *SIXImgView;
@property (strong, nonatomic) UIImageView *SEVENImgView;
@property (strong, nonatomic) UIImageView *EIGHTImgView;
@property (strong, nonatomic) UIImageView *NINEImgView;
@property (assign, nonatomic) id<ClientDetailCellDelegate> delegate;
@property (strong, nonatomic) ReportModel *reportModel;

+(CGFloat)getCellHeight;

@end
