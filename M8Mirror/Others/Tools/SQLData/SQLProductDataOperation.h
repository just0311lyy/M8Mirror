//
//  SQLProductDataOperation.h
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/9.
//  Copyright © 2019 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@class ProductModel;

NS_ASSUME_NONNULL_BEGIN

@interface SQLProductDataOperation : NSObject
{
    FMDatabase* _db;
}

singleH(SQLProductDataOperation)

-(BOOL)openDatabase;

/** 创建数据库表 */
-(void)createTable;

/** 增 或 改*/
-(ProductModel *)updateSourceData:(ProductModel *)sourceModel;

/** 删 清空数据库 */
-(BOOL)clearSourceTable;

/** 查 查询指定source对象 */
-(ProductModel *)selectSourceModel:(ProductModel *)sourceModel;

/** 查 查询是否存在数据库中 */
-(BOOL)currentSourceIsInTableWithSource:(ProductModel *)sourceModel;

/** 查 查询source数据存相关信息 返回的存储对象数组 */
-(NSArray *)getAllSourceArrayInTable;
@end

NS_ASSUME_NONNULL_END
