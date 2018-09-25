//
//  LYHTTPSManager.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/4/28.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 1,
    /**
     *  post请求
     */
    HttpRequestTypePost = 2
};

@interface LYHTTPSManager : NSObject

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success     请求的结果
 */
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id data))success
                     failure:(void (^)(NSError *error))failure;
+ (LYHTTPSManager *)sharedInstance;

@end
