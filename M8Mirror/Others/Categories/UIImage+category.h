//
//  UIImage+category.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/6.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (category)
/**
 * 改变图片颜色
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
/**
 * 根据指定图片的文件名获取一张圆型的图片对象,并加边框
 * @param name 图片文件名
 * @param borderWidth 边框的宽
 * @param borderColor 边框的颜色
 * @return 切好的圆型图片
 */
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 * 将一张图片变成指定的大小
 * @param image 原图片
 * @param size 指定的大小
 * @return 指定大小的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;

/**
 * 将一张压缩的base64字符串还原为图片
 * @param string base64字符串
 * @return 图片
 */
+(UIImage *)imageWithBase64String:(NSString *)string;

/**
 * 将图片压缩为二进制数据流
 * @param sourceImage 图片
 * @param maxSize 指定最大尺寸
 * @return 图片二进制数据流
 */
- (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;

/**
 * 将图片压缩为二进制数据流
 * @param size 压缩到指定尺寸
 * @param sourceImage 原图片
 * @return 压缩后的图片
 */
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage;

/**
 * 将图片压缩为二进制数据流
 * @param arr
 * @param image 图片
 * @param finallImageData
 * @param maxSize 指定最大尺寸
 * @return 图片二进制数据流
 */
- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize;
@end
