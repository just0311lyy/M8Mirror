//
//  M8ProductDetailViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/11.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol M8ProductDetailViewControllerDelegate <NSObject>
@optional
- (void)importWithString:(NSString *)detailTextStr andButtonTag:(NSUInteger)buttonTag;
@end
@interface M8ProductDetailViewController : UIViewController
@property (nonatomic, weak) id<M8ProductDetailViewControllerDelegate> delegate;
@property (nonatomic, assign) NSUInteger buttonTag;
@property (nonatomic, strong) NSString *contentString;
@end
