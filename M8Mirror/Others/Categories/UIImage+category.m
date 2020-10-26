//
//  UIImage+category.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/3/6.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "UIImage+category.h"

@implementation UIImage (category)
- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    //1. 开启上下文
    UIImage *sourceImage = [UIImage imageNamed:name];
    return [self circleImageWithImage:sourceImage borderWidth:borderWidth borderColor:borderColor];
}

+ (UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    //1. 开启上下文
    CGFloat imageWidth = sourceImage.size.width + 2 * borderWidth;
    CGFloat imageHeigh = sourceImage.size.height + 2 * borderWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeigh), NO, 0);
    //2. 获取上下文
    UIGraphicsGetCurrentContext();
    //3. 画圆
    CGFloat radius = sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width * 0.5 : sourceImage.size.height * 0.5;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth * 0.5, imageHeigh * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    bezierPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [bezierPath stroke];
    //4. 使用BezierPath进行剪切
    [bezierPath addClip];
    //5. 画图
    [sourceImage drawInRect:CGRectMake(borderWidth, borderWidth, sourceImage.size.width, sourceImage.size.height)];
    //6. 从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7. 结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)imageWithBase64String:(NSString *)string{
    // 将base64字符串转为NSData
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:string options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    // 将NSData转为UIImage
    UIImage *decodedImage = [UIImage imageWithData: decodeData];
    return decodedImage;
}

#pragma mark -- ** 图片压缩 **
- (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1000;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    //获取原图片宽高比
    CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
    
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualityArr addObject:@(value)];
    }
    
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize
                                      image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}

#pragma mark -- ** 调整图片分辨率/尺寸（等比例缩放）**
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -- ** 二分法 **
- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}

@end
