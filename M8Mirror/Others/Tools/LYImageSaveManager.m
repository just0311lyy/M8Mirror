//
//  LYImageSaveManager.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LYImageSaveManager.h"
@implementation LYImageSaveManager
+(void)saveImageArray:(NSMutableArray *)array andArrayName:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * path = [paths[0] stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){//判断createPath路径文件夹是否已存在，此处createPath为需要新建的文件夹的绝对路径
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];//创建文件夹
    }
    for (int i =0 ; i < array.count; i++) {
        NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.png",fileName, i]];  // 保存文件的名称
        [UIImagePNGRepresentation(array[i])writeToFile: filePath    atomically:YES];
    }
}

+(NSMutableArray *)getImageArrayWithName:(NSString *)fileName{
    NSMutableArray * imageArray = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * path = [paths[0]stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager]fileExistsAtPath:path]){//判断createPath路径文件夹是否已存在，不存在直接返回
        return imageArray;
    }
    //此文件夹下所有图片名称
    NSArray *filesNameArray = [[NSFileManager defaultManager]  subpathsOfDirectoryAtPath:path error:nil];
    if (filesNameArray && filesNameArray.count !=0 ) {
        for (int i =0 ; i < filesNameArray.count; i++) {
            UIImage * image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:filesNameArray[i]]];
            [imageArray addObject:image];
        }
    }
    return imageArray;
}

+(BOOL)deleteImageName:(NSString * )imageName withFileName:(NSString *)fileName{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString * path = [paths[0] stringByAppendingPathComponent:fileName];
    NSString * pathFull = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
    if([[NSFileManager defaultManager] fileExistsAtPath:pathFull])//如果存在临时文件的配置文件
    {
        return  [[NSFileManager defaultManager]  removeItemAtPath:pathFull error:nil];
    }
    return NO;
}

@end
