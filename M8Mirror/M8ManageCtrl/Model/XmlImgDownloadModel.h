//
//  XmlImgDownloadModel.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/29.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlImgDownloadModel : NSObject
/** 广告唯一编号 id */
@property (nonatomic,assign)int imageId;
/** 广告名称 ggmc */
@property (nonatomic,strong)NSString *name;
/** 广告图片 img*/
@property (nonatomic,strong)NSString *imgOfBase64Str;
/** 添加日期 putdate*/
@property (nonatomic,strong)NSString *putdate;
/** 所属连锁机构 deptid*/
@property (nonatomic,assign)int deptId;
/** 所属美容院 parlorid*/
@property (nonatomic,assign)int parlorId;
/** 所属用户 userid*/
@property (nonatomic,strong)NSString *username;
@end
