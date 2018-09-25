//
//  ImagesSelectedCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/30.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XmlImgDownloadModel.h"
@protocol ImagesSelectedCellDelegate <NSObject>
// 回调方法
-(void)selectedButton:(UIButton*)button andShowImg:(XmlImgDownloadModel *)showImgObject andIsSelected:(BOOL)isSelected andIndexPathRow:(NSInteger)indexPathRow;
// 回调方法结束
@end
@interface ImagesSelectedCell : UITableViewCell
@property (nonatomic, assign) id<ImagesSelectedCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *imgNameLb;
@property (strong, nonatomic) UIButton *selectionButton;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) XmlImgDownloadModel *showImgModel;
//@property (nonatomic, strong) UIImage *advertImage;
@property (nonatomic, assign) NSInteger indexPathRow;

+(CGFloat)getCellHeight;
@end
