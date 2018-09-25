//
//  MLCameraLibs.h
//  MLCameraLibs
//
//  Created by 童 on 2018/2/28.
//  Copyright © 2018年 童. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MLCameraLibs : NSObject
{
    
}


/**
 传入设备ip，开始传输视频流

 @param strIp device ip
 @return 设备操作指针
 */
+ (void *) ML_StartPreview:(NSString *) strIp;


/**
 停止传输视频流

 @param pCamera ML_StartPreview返回的指针
 */
+ (void) ML_StopPreview:(void *)pCamera;


/**
 获取一帧视频

 @param pCamera ML_StartPreview返回的指针
 @param buffer 自己定义的buffer，获取的视频帧讲会被拷贝到此buffer
 @return buffer长度
 */
+ (int) ML_GetVideoFrame:(void *)pCamera gotBuf:(char *)buffer;


/**
 获取视频流参数

 @param pCamera ML_StartPreview返回的指针
 @param fmt 视频格式，目前支持1，即MJPEG
 @param w width
 @param h height
 @return 1即成功，其他失败
 */
+ (int) ML_GetVideoParams:(void *)pCamera format:(int *)fmt width:(int *)w height:(int *)h;

@end
