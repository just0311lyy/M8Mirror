//
//  MLUtils.h
//
//  Created by 童 on 2018/1/22.
//  Copyright © 2017年 童. All rights reserved.
//  ML库的指令接口
//

#ifndef MLUtils_h
#define MLUtils_h


#define PHOTOS_FOLDER   @"/Photos"
#define VIDEOS_FOLDER   @"/Videos"
#define DOCUMENT_PATH   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


enum MediaType {
    MediaTypePhoto = 1,
    MediaTypeVideo,
};

@interface MLUtils : NSObject

+ (void) deleteFile:(NSString *)path;
+ (NSMutableArray *)loadImages;
+ (NSMutableArray *)loadVideos;
+ (NSString *)getPhotosPath;
+ (NSString *)getVideosPath;

#pragma --mark 录像接口
#pragma --mark The following APIs used for record
+ (BOOL)startAVIRecord:(NSString *)path;
+ (void)stopAVIRecord;
+ (void)addAVIRecData:(NSData *)data andSize:(NSInteger)length;
+ (NSInteger)getAVIRecTimestamp;
+ (void)setAVIRecParams:(NSInteger)w :(NSInteger) h :(NSInteger) fps;

#pragma --mark 以下为播放AVI视频的接口，参考“VideoPlayerView”
#pragma --mark The following APIs is for playing AVI video, referring to "VideoPlayerView"
+ (BOOL) openAVIVideo:(NSString *)path;
+ (void) closeAVIVideo;
+ (double)getAVIVideoTotalTime;
+ (int)getAVIVideoTotalFrame;
+ (int)getAVIFPS;
+ (NSData *)getAVIVideoFrameAtIndex:(NSInteger)index;
+ (NSData *)getAVIVideoFrameAtTime:(double)time;

#pragma --mark 以下为设置界面所使用的函数接口，参考“SettingViewController”
#pragma --mark 目前所有参数里的ip都是192.168.10.123，在开发时可以根据搜索获得的ip自行替换
#pragma --mark The following APIs is for setting remote parameters, referring to "SettingViewController"
//传入设备ip，返回cmd指针，用做发送指令参数，以下的pCmd都是ML_InitCmdSocket返回的指针
+ (void *) ML_InitCmdSocket:(NSString *)strIp;
+ (void) ML_DeinitCmdSocket:(void *)pCmd;
+ (bool) ML_SendSetSSID:(void *)pCmd andSSID:(NSString *)ssid;
+ (bool) ML_SendSetPassword:(void *)pCmd andPass:(NSString *)pass;
+ (bool) ML_SendReboot:(void *)pCmd;
+ (bool) ML_SendClearPass:(void *)pCmd;
+ (bool) ML_SendSetResolution:(void *)pCmd andWidth:(NSInteger) w andHeight: (NSInteger) h;
+ (NSMutableArray *) ML_SendGetResolution:(void *)pCmd;
//获取按键状态
+ (int) ML_SendGetKeyStatus:(void *)pCmd;
//获取板子是否支持透传，参考ViewController类里的示例
+ (int) ML_SendGetKeyOrUart:(void *)pCmd;
//设置模块的wifi通道，范围为0~11，0代表自动通道
+ (bool) ML_SendSetChannel:(void *)pCmd andChannel:(int)channel;



#pragma --mark station参数设置
//发送成功，返回true，否则false
+ (bool) ML_SendApParams:(void *)pCmd mode:(int)mode andSSID:(NSString *)ssid andPass:(NSString *)pass;
+ (bool) ML_SendClearApParams:(void *)pCmd;
+ (bool) ML_SendSetEthernet:(void *)pCmd;



#pragma --mark 串口透传
#pragma --mark 目前所有参数里的ip都是192.168.10.123，在开发时可以根据搜索获得的ip自行替换
//初始化透传，返回uart透传指针，下面的pUart用的都是ML_InitUartSocket返回的指针
+ (void *) ML_InitUartSocket:(NSString *)strIp;
+ (void) ML_DeinitUartSocket:(void *)pUart;
//发送数据通过网络到串口
+ (int) ML_UartSendData:(void *)pUart andData:(uint8_t *)data len:(int)len;
//接收，在物理串口透传时，即单片机通过串口向wifi模块发送数据时，为避免数据过长而被串口
//分割，应遵循格式：0xa6 + 数据长度 + 数据内容
//如以下数据，data[0]为head，data[1]=0x08为数据长度8，后面8位为数据内容：
//uint8 data[10] = 0xa6 0x08 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88
+ (int) ML_UartRecvData:(void *)pUart andData:(uint8_t *)data;




#pragma --mark 搜索局域网设备
//搜索设备：打开socket，通过socket发送指令，如果有回传认为是wifi设备
+ (int) ML_OpenSearchSocket;
+ (void) ML_CloseSearchSocket:(int) socket;
//ip为局域网ip，从1-255循环发送
+ (int) ML_SendSearch:(int) socket withIp:(NSString *)sendIp;
//成功返回设备ip地址，否则返回nil
+ (NSString *) ML_RecvSearch:(int) socket;
@end



#endif /* MLUtils_h */

