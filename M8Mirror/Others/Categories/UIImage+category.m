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

@end
