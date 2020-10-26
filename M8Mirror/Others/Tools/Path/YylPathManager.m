//
//  YylPathManager.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/9.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "YylPathManager.h"

@implementation YylPathManager
singleM(YylPathManager)

- (NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    
    return documentsDirectory;
}
@end
