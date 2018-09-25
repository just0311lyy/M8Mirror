//
//  LYImageSaveManager.h
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYImageSaveManager : NSObject
/**
 
 *  将图片数组以arrayName存储
 
 *
 
 *  @param array     图片数组，数组元素是UIImage
 
 *  @param arrayName 存储图片文件名称
 
 */

+(void)saveImageArray:(NSMutableArray *)array andArrayName:(NSString *)fileName;



/**
 
 *  获取arrayName文件夹下所有图片
 
 *
 
 *  @param arrayName 文件名称
 
 *
 
 *  @return 返回元素UIImage组成的数组
 
 */

+(NSMutableArray *)getImageArrayWithName:(NSString *)fileName;



/**
 
 *  删除fileName文件夹下名称为imageName的文件
 
 *
 
 *  @param imageName image名称
 
 *  @param fileName  文件夹名称
 
 *
 
 *  @return 是否删除成功
 
 */

+(BOOL)deleteImageName:(NSString * )imageName withFileName:(NSString *)fileName;
@end
