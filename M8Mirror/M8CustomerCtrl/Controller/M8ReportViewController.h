//
//  M8ReportViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/17.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customerModel.h"
#import "ReportModel.h"
@interface M8ReportViewController : UIViewController
@property (strong , nonatomic) customerModel *currentCustomer;
@property (strong , nonatomic) ReportModel *currentReport;
@property (assign , nonatomic) BOOL isFromInstrument;
@end
