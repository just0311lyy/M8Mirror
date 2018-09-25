//
//  M8HistoryView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M8HistoryView : UIView
//@property (assign, nonatomic)id<M8SearchViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andName:(NSString *)nameStr andPhoneNumber:(NSString *)numberStr andBirthday:(NSString *)dayStr;
@end
