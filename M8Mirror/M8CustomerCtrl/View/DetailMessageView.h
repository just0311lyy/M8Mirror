//
//  DetailMessageView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/11.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customerModel.h"
@protocol DetailMessageViewDelegate <NSObject>
-(void)editButtonClick;
@end
@interface DetailMessageView : UIView
@property (assign, nonatomic)id<DetailMessageViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andCustomer:(customerModel *)model;
@end
