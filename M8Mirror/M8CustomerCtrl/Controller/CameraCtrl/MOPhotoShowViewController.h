//
//  MOPhotoShowViewController.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/27.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportModel.h"
@interface MOPhotoShowViewController : UIViewController
@property (strong , nonatomic) ReportModel *currentShowReport;
@property (strong , nonatomic) customerModel *currentShowCust;
@end
