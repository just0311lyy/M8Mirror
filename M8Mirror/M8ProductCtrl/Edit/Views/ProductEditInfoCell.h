//
//  ProductEditInfoCell.h
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/5.
//  Copyright © 2019 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface ProductEditInfoCell : UITableViewCell

@property (nonatomic, weak) UITextField *contentTextField;
@property (nonatomic, strong) ProductInfoModel *pICellModel;
@property (nonatomic, strong) UILabel * contentLbl;

+ (CGFloat)getProductEditInfoCellHeight;
@end

NS_ASSUME_NONNULL_END
