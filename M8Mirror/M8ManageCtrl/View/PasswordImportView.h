//
//  PasswordImportView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/14.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PasswordImportViewDelegate <NSObject>
//-(void)leftButtonClick;
//-(void)rightButtonClick;
@end
@interface PasswordImportView : UIView
@property (assign, nonatomic)id<PasswordImportViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)Title andPlaceholder:(NSString *)placeholderStr;
@end
