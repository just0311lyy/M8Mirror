//
//  M8MreportViewController.h
//  M8Mirror
//
//  Created by YangyangLi on 2019/1/9.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "M8BaseViewController.h"
#import "customerModel.h"
#import "ReportModel.h"
@interface M8MreportViewController : M8BaseViewController
@property (strong , nonatomic) customerModel *currentCustomer;
@property (strong , nonatomic) ReportModel *currentReport;
@property (assign , nonatomic) BOOL isFromInstrument;
@end
