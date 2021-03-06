//
//  M8ContentEditViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/6.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M8ContentEditViewControllerDelegate <NSObject>
@optional
- (void)importWithString:(NSString *)detailTextStr andButtonTag:(NSUInteger)buttonTag;
@end
@interface M8ContentEditViewController : UIViewController
@property (nonatomic, weak) id<M8ContentEditViewControllerDelegate> delegate;
@property (nonatomic, assign) NSUInteger buttonTag;
@property (nonatomic, strong) NSString *contentString;
@end
