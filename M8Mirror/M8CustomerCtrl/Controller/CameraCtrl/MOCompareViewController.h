//
//  MOCompareViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/28.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportModel.h"
#import "customerModel.h"
@interface MOCompareViewController : UIViewController
@property (strong , nonatomic) ReportModel *currentCompareReport;
@property (strong , nonatomic) customerModel *currentCompareCust;
@end
