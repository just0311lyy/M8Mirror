//
//  ProductKindView.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductKindView : UIView
@property (nonnull, copy) void(^kindSelectIndex)(NSInteger index);
@property (nonnull, copy) void(^kindViewFadeOut)();

-(id)initKindViewWithArr:(NSArray *)arr current:(NSInteger)currentIndex;
- (void)show:(UIView*)showIn;
@end
