//
//  ReportModel.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/17.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "ReportModel.h"

@implementation ReportModel
+ (NSMutableArray *)getReportModelData{
    NSString *imagePath01 = [[NSBundle mainBundle] pathForResource:@"login_bg01" ofType:@"jpg"];
    NSString *imagePath02 = [[NSBundle mainBundle] pathForResource:@"login_bg02" ofType:@"jpg"];
    NSString *imagePath03 = [[NSBundle mainBundle] pathForResource:@"login_bg03" ofType:@"jpg"];
//    UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    NSMutableArray *reportAry = [NSMutableArray new];
    ReportModel *report01 = [[ReportModel alloc] init];
    report01.customerId = 1001;
    report01.oneImgPathStr = imagePath01;
    report01.twoImgPathStr = imagePath01;
    report01.threeImgPathStr = imagePath01;
    report01.fourImgPathStr = imagePath01;
    report01.fiveImgPathStr = imagePath01;
    report01.sixImgPathStr = imagePath01;
    report01.sevenImgPathStr = imagePath01;
    report01.eightImgPathStr = imagePath01;
    report01.nineImgPathStr = imagePath01;
    report01.reportDate = @"2018-02-21";
    
    ReportModel *report02 = [[ReportModel alloc] init];
    report02.customerId = 1001;
    report02.oneImgPathStr = imagePath02;
    report02.twoImgPathStr = imagePath02;
    report02.threeImgPathStr = imagePath02;
    report02.fourImgPathStr = imagePath02;
    report02.fiveImgPathStr = imagePath02;
    report02.sixImgPathStr = imagePath02;
    report02.sevenImgPathStr = imagePath02;
    report02.eightImgPathStr = imagePath02;
    report02.nineImgPathStr = imagePath02;
    report02.reportDate = @"2018-02-26";
    
    ReportModel *report03 = [[ReportModel alloc] init];
    report03.customerId = 1001;
    report03.oneImgPathStr = imagePath03;
    report03.twoImgPathStr = imagePath03;
    report03.threeImgPathStr = imagePath03;
    report03.fourImgPathStr = imagePath03;
    report03.fiveImgPathStr = imagePath03;
    report03.sixImgPathStr = imagePath03;
    report03.sevenImgPathStr = imagePath03;
    report03.eightImgPathStr = imagePath03;
    report03.nineImgPathStr = imagePath03;
    report03.reportDate = @"2018-03-21";

    [reportAry addObjectsFromArray:@[report01,report02,report03]];
    return reportAry;
}
@end
