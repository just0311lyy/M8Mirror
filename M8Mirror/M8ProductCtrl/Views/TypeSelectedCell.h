//
//  TypeSelectedCell.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/24.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeSelectedCellDelegate <NSObject>
// 回调方法
-(void)selectedButton:(UIButton*)button andStock_code:(NSString *)stockCode andIsSelected:(BOOL)isSelected andIndexPathRow:(NSInteger)indexPathRow;
// 回调方法结束
@end
@interface TypeSelectedCell : UITableViewCell
@property (nonatomic, assign) id<TypeSelectedCellDelegate> delegate;
@property (strong, nonatomic) UILabel *typeLb;
@property (strong, nonatomic) UIButton *selectionButton;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *typeString;
@property (nonatomic, assign) NSInteger indexPathRow;

+(CGFloat)getCellHeight;

@end
