//
//  M8MProductEditViewController.h
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/5.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "M8BaseViewController.h"
#import "ProductModel.h"

typedef NS_ENUM(NSInteger, ProductEditType) {
    ProductEditTypeNewCreat = 0,        //新建产品
    ProductEditTypeEdit,                //修改产品
};

NS_ASSUME_NONNULL_BEGIN
typedef void(^EditBlock)(ProductModel *editProduct,ProductEditType editType); //block属性 @property (nonatomic, copy) ClickBlock imageClickBlock;
//@protocol M8MProductEditViewControllerDelegate <NSObject>
//@optional
//- (void)savedEditProduct:(ProductModel *)product withTitle:(NSString *)title;
//@end
@interface M8MProductEditViewController : M8BaseViewController
//@property (nonatomic, weak) id<M8MProductEditViewControllerDelegate> delegate;
//@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic, strong) ProductModel *currentProduct;
@property (nonatomic, strong) EditBlock productEditBlock;
@property (nonatomic, assign) ProductEditType controllerType;

@end

NS_ASSUME_NONNULL_END
