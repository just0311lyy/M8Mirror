//
//  SQLProductDataOperation.m
//  M8Mirror
//
//  Created by YangyangLi on 2019/7/9.
//  Copyright © 2019 lyy. All rights reserved.
//

#import "SQLProductDataOperation.h"
#import "YylPathManager.h"
#import "ProductModel.h"

#define DBTableOfProductName @"products_table"
//#define CHECK_Nil(object)  ((object == nil) ? @"" : object)
//#define CHECK_NilNumber(object)  ((object == nil) ? @0 : object)
@implementation SQLProductDataOperation
singleM(SQLProductDataOperation)

-(BOOL)openDatabase{
    /*根据路径创建数据库和表*/
//    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString * path = [arr lastObject];
    NSString * path = [[YylPathManager shareYylPathManager] getDocumentPath];
    path = [path stringByAppendingPathComponent:@"SQLDatabase.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [self createTable];
    return YES;
}
/** 创建数据库表 */
-(void)createTable{
    if (![_db open]) {
        NSLog(@"数据库打开失败!");
        return;
    }
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(ID INTEGER PRIMARY KEY AUTOINCREMENT,productID int DEFAULT 0,productName TEXT(100),productAttrib TEXT(100),productGrade TEXT(100),productPrice TEXT(100),productDiscount TEXT(100),useMethod TEXT(100),imgDocumentPath TEXT(100),productPutdate TEXT(100),productDeptID int DEFAULT 0,productParlorID int DEFAULT 0,productUserID TEXT(100))",DBTableOfProductName];
    BOOL result = [_db executeUpdate:sql];
    if(result == YES)
    {
        NSLog(@"創建表成功");
    }
    else{
        NSLog(@"創建表失敗");
    }
    [_db close];
}

#pragma mark -- *** ***
/** 增 或 改*/
-(ProductModel *)updateSourceData:(ProductModel *)sourceModel{
    [_db open];
    NSString * stringSQL=[NSString stringWithFormat:@"SELECT * FROM %@ where productID=?",DBTableOfProductName];
    FMResultSet * result = [_db executeQuery:stringSQL,sourceModel.productId];
    BOOL isUpdate = NO;
    if ([result next])
    {
        isUpdate = YES;
    }
    [result close];
    BOOL isSuccess = NO;
    NSMutableArray * valueArray=[[NSMutableArray alloc] init];
    if (isUpdate) { //更新
        //更新完整数据(productID,productName,productAttrib,productGrade,productPrice,productDiscount,useMethod,imgDocumentPath,productPutdate,productDeptID,productParlorID,productUserID)
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET productName = ?, productAttrib = ?, productGrade = ?, productPrice = ?, productDiscount = ?, useMethod = ?, imgDocumentPath = ?, productPutdate = ?, productDeptID = ?, productParlorID = ?, productUserID = ? where productID = ?;",DBTableOfProductName];
        [valueArray addObject:CHECK_Nil(sourceModel.name)];
        [valueArray addObject:CHECK_Nil(sourceModel.attrib)];
        [valueArray addObject:CHECK_Nil(sourceModel.grade)];
        [valueArray addObject:CHECK_Nil(sourceModel.price)];
        [valueArray addObject:CHECK_Nil(sourceModel.discount)];
        [valueArray addObject:CHECK_Nil(sourceModel.useMethod)];
        [valueArray addObject:CHECK_Nil(sourceModel.imgDocumentPath)];
        [valueArray addObject:CHECK_Nil(sourceModel.putdate)];
        [valueArray addObject:CHECK_NilNumber(@(sourceModel.deptid))];
        [valueArray addObject:CHECK_NilNumber(@(sourceModel.parlorid))];
        [valueArray addObject:CHECK_Nil(sourceModel.userid)];
        [valueArray addObject:CHECK_NilNumber(@(sourceModel.productId))];
        isSuccess = [_db executeUpdate:sql withArgumentsInArray:valueArray];
    }
    else
    {
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (productID,productName,productAttrib,productGrade,productPrice,productDiscount,useMethod,imgDocumentPath,productPutdate,productDeptID,productParlorID,productUserID) values (?,?,?,?,?,?,?,?,?,?,?,?);",DBTableOfProductName];
        [valueArray addObject:CHECK_NilNumber(@(sourceModel.productId))];
        [valueArray addObject:CHECK_Nil(sourceModel.name)];
        [valueArray addObject:CHECK_Nil(sourceModel.attrib)];
        [valueArray addObject:CHECK_Nil(sourceModel.grade)];
        [valueArray addObject:CHECK_Nil(sourceModel.price)];
        [valueArray addObject:CHECK_Nil(sourceModel.discount)];
        [valueArray addObject:CHECK_Nil(sourceModel.useMethod)];
        [valueArray addObject:CHECK_Nil(sourceModel.imgDocumentPath)];
        [valueArray addObject:CHECK_Nil(sourceModel.putdate)];
        [valueArray addObject:CHECK_NilNumber(@(sourceModel.deptid))];
        [valueArray addObject:CHECK_NilNumber(@(sourceModel.parlorid))];
        [valueArray addObject:CHECK_Nil(sourceModel.userid)];
        isSuccess = [_db executeUpdate:sql withArgumentsInArray:valueArray];
    }
    //插入后查询执行结果
    ProductModel *model = [[ProductModel alloc] init];
    if (isSuccess) { //插入或更新数据成功
        NSString * stringSQL=[NSString stringWithFormat:@"SELECT * FROM %@ where productID = ?",DBTableOfProductName];  //根据更新时间查询最新一条数据
        FMResultSet * selectResult=[_db executeQuery:stringSQL,sourceModel.productId];
        if ([selectResult next])
        {
            int  keyId = [selectResult intForColumn:@"ID"];
            model = [ProductModel modelOfSourceWithSqlResult:selectResult];
            NSLog(@"*插入结果*\n_keyId=%d_productID=%d__productName=%@__userid=%@\n**",keyId,model.productId,model.name,model.userid);
        }
        [selectResult close];
    }
    [_db close];
    return model;
    
}

/** 删 */
//清空数据库
-(BOOL)clearSourceTable{
    [_db open];
    NSString * deleteSQL= [NSString stringWithFormat:@"delete from %@",DBTableOfProductName];
    BOOL booResult =[_db executeUpdate:deleteSQL];
    NSLog(@"删除所有数据: %d",booResult);
    [_db close];
    return  booResult;
}

/** 查 */
//查询指定source对象
-(ProductModel *)selectSourceModel:(ProductModel *)sourceModel{
    [_db open];
    NSString * stringSQL=[NSString stringWithFormat:@"SELECT * FROM %@ where productID = ?",DBTableOfProductName];
    FMResultSet * result=[_db executeQuery:stringSQL,sourceModel.productId];
    ProductModel *model = [[ProductModel alloc] init];
    if ([result next])
    {
        model = [ProductModel modelOfSourceWithSqlResult:result];
    }
    [result close];
    [_db close];
    return model;
}
//查询是否存在数据库中
-(BOOL)currentSourceIsInTableWithSource:(ProductModel *)sourceModel
{
    [_db open];
    NSString * stringSQL = [NSString stringWithFormat:@"SELECT * FROM %@ where productID =?",DBTableOfProductName];
    FMResultSet * result = [_db executeQuery:stringSQL,sourceModel.productId];
    BOOL isInTable = NO;
    if ([result next])
    {
        isInTable = YES;
    }
    [result close];
    [_db close];
    return isInTable;
}

/** 查询source数据存相关信息 返回的存储对象数组 */
-(NSArray *)getAllSourceArrayInTable{
    [_db open];
    //select * from sourceData_table order by sourceSortNumber
    NSString *sql = [NSString stringWithFormat:@"select * from %@",DBTableOfProductName];
    FMResultSet * result = [_db executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next])
    {
        ProductModel *model = [ProductModel modelOfSourceWithSqlResult:result];
        NSLog(@"productID=%d__productName=%@__userid=%@\n**",model.productId,model.name,model.userid);
        [array addObject:model];
    }
    [result close];
    [_db close];
    return array;
}
@end
