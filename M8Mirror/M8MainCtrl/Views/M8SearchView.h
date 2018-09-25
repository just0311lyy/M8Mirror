//
//  M8SearchView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M8SearchViewDelegate <NSObject>
//-(void)itemBeginEditWithPosition:(float)position;
@end
@interface M8SearchView : UIView <UITextFieldDelegate>
@property (assign, nonatomic)id<M8SearchViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame;
@end
