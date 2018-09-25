//
//  LanguageView.h
//  M8Mirror
//
//  Created by 卢升 on 2018/3/28.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageView : UIView

@property(nonnull,copy)void(^languageSelectIndex)(NSInteger index);

-(id)initLanguageViewWithArr:(NSArray *)arr current:(NSInteger)currentIndex;
- (void)show:(UIView*)showIn;
@end
