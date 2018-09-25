//
//  ReportModel.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/17.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportModel : NSObject
@property (assign, nonatomic) NSInteger customerId;
@property (strong, nonatomic) NSString *oneImgPathStr;  //纹理预测
@property (strong, nonatomic) NSString *twoImgPathStr;  //皮肤老化预测
@property (strong, nonatomic) NSString *threeImgPathStr;  //红色区
@property (strong, nonatomic) NSString *fourImgPathStr;  //棕色区
@property (strong, nonatomic) NSString *fiveImgPathStr;  //紫外线斑
@property (strong, nonatomic) NSString *sixImgPathStr;  //图六
@property (strong, nonatomic) NSString *sevenImgPathStr;  //图七
@property (strong, nonatomic) NSString *eightImgPathStr;  //图八
@property (strong, nonatomic) NSString *nineImgPathStr;  //图九
//@property (strong, nonatomic) NSString *tenImgPathStr;  //图十

//@property (strong, nonatomic) NSString *RGBOfBase64String;  //纹理预测
//@property (strong, nonatomic) NSString *UVOfBase64String;  //皮肤老化预测
//@property (strong, nonatomic) NSString *PZOfBase64String;  //红色区


@property (strong, nonatomic) NSString *reportDate;  //检测时间

+ (NSMutableArray *)getReportModelData;
@end
