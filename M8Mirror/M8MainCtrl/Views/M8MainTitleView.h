//
//  M8MainTitleView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M8MainTitleViewDelegate <NSObject>
-(void)rightButtonClick;
@end
@interface M8MainTitleView : UIView
//@property (strong,nonatomic)NSString *mainTitle;
@property (assign, nonatomic)id<M8MainTitleViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andTitleName:(NSString *)title;
@end
