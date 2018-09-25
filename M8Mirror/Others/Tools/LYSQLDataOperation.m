//
//  LYSQLDataOperation.m
//  M8Mirror
//
//  Created by 李阳洋 on 2018/5/1.
//  Copyright © 2018年 lyy. All rights reserved.
//

#import "LYSQLDataOperation.h"
#import "FMDatabase.h"
//#import "M8GlobalData.h"
//#import "NSString+Wrapper.h"

@interface LYSQLDataOperation ()
{
    FMDatabase *_dataBase;
}
@end

@implementation LYSQLDataOperation
/**
 *  创建FMDB数据表的单例
 */
static LYSQLDataOperation *sharedDataInstance = nil;
+(LYSQLDataOperation *)sharedDataInstance{
//    static LYSQLDataOperation *sharedDataInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataInstance = [[self alloc] init];
    });
    return sharedDataInstance;
}

-(BOOL)openDatabase{
    /*根据路径创建数据库和表*/
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [arr objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"M8Database01.db"];
    NSLog(@"db:%@",path);
    _dataBase = [FMDatabase databaseWithPath:path];
    [self createTable];
    return YES;
}
/** 创建所有的数据库表 */
-(void)createTable{
    if (![_dataBase open]) {
        NSLog(@"打开数据表dataBase失败!");
        return;
    }
    //广告图数据存储
    NSMutableString *advertImgsSqlStr = [[NSMutableString alloc] initWithString:@"CREATE TABLE if not exists advertImages_info_table("];
    [advertImgsSqlStr appendString:@"advertImgSortNumber INTEGER PRIMARY KEY AUTOINCREMENT,"];
    [advertImgsSqlStr appendString:@"imageID int DEFAULT 0,"];
    [advertImgsSqlStr appendString:@"imageName TEXT(100),"];
    [advertImgsSqlStr appendString:@"imageOfBase64Str TEXT(100),"];
    [advertImgsSqlStr appendString:@"imagePutdate TEXT(100),"];
    [advertImgsSqlStr appendString:@"imageDeptID int DEFAULT 0,"];
    [advertImgsSqlStr appendString:@"imageParlorID int DEFAULT 0,"];
    [advertImgsSqlStr appendString:@"imageUsername TEXT(100))"];
    [_dataBase executeUpdate:advertImgsSqlStr];
    //主页轮播图数据存储
    NSMutableString *showImgsSqlStr = [[NSMutableString alloc] initWithString:@"CREATE TABLE if not exists showImages_info_table("];
    [showImgsSqlStr appendString:@"showImgSortNumber INTEGER PRIMARY KEY AUTOINCREMENT,"];
    [showImgsSqlStr appendString:@"imageID int DEFAULT 0,"];
    [showImgsSqlStr appendString:@"imageName TEXT(100),"];
    [showImgsSqlStr appendString:@"imageOfBase64Str TEXT(100),"];
    [showImgsSqlStr appendString:@"imagePutdate TEXT(100),"];
    [showImgsSqlStr appendString:@"imageDeptID int DEFAULT 0,"];
    [showImgsSqlStr appendString:@"imageParlorID int DEFAULT 0,"];
    [showImgsSqlStr appendString:@"imageUsername TEXT(100))"];
    [_dataBase executeUpdate:showImgsSqlStr];
    //产品列表数据存储
    NSMutableString *productsSqlStr = [[NSMutableString alloc] initWithString:@"CREATE TABLE if not exists products_info_table("];
    [productsSqlStr appendString:@"productSortNumber INTEGER PRIMARY KEY AUTOINCREMENT,"];
    [productsSqlStr appendString:@"productID int DEFAULT 0,"];
    [productsSqlStr appendString:@"productName TEXT(100),"];
    [productsSqlStr appendString:@"productAttrib TEXT(100),"];
    [productsSqlStr appendString:@"productGrade TEXT(100),"];
    [productsSqlStr appendString:@"productPrice TEXT(100),"];
    [productsSqlStr appendString:@"productDiscount TEXT(100),"];
    [productsSqlStr appendString:@"useMethod TEXT(100),"];
    [productsSqlStr appendString:@"productImgOfBase64Str TEXT(100),"];
    [productsSqlStr appendString:@"productPutdate TEXT(100),"];
    [productsSqlStr appendString:@"productDeptID int DEFAULT 0,"];
    [productsSqlStr appendString:@"productParlorID int DEFAULT 0,"];
    [productsSqlStr appendString:@"productUserid TEXT(100))"];
    [_dataBase executeUpdate:productsSqlStr];
    //客户列表数据存储
    NSMutableString *customersSqlStr = [[NSMutableString alloc] initWithString:@"CREATE TABLE if not exists customers_info_table("];
    [customersSqlStr appendString:@"customerSortNumber INTEGER PRIMARY KEY AUTOINCREMENT,"];
    [customersSqlStr appendString:@"customerID int DEFAULT 0,"];
    [customersSqlStr appendString:@"customerName TEXT(100),"];
    [customersSqlStr appendString:@"customerSex TEXT(100),"];
    [customersSqlStr appendString:@"birthday TEXT(100),"];
    [customersSqlStr appendString:@"phoneNumber TEXT(100),"];
    [customersSqlStr appendString:@"email TEXT(100),"];
    [customersSqlStr appendString:@"address TEXT(100),"];
    [customersSqlStr appendString:@"profession TEXT(100),"];
    [customersSqlStr appendString:@"hobby TEXT(100),"];
    [customersSqlStr appendString:@"isOrNo Boolean,"];
    [customersSqlStr appendString:@"usedProducts TEXT(100),"];
    [customersSqlStr appendString:@"username TEXT(100),"];
    [customersSqlStr appendString:@"lastdate TEXT(100),"];
    [customersSqlStr appendString:@"headImgOfBase64String TEXT(100),"];
    [customersSqlStr appendString:@"adminuser TEXT(100))"];
    [_dataBase executeUpdate:customersSqlStr];
    
    //客户检测记录存储
    NSMutableString *reportSqlStr = [[NSMutableString alloc] initWithString:@"CREATE TABLE if not exists reports_info_table("];
    [reportSqlStr appendString:@"reportSortNumber INTEGER PRIMARY KEY AUTOINCREMENT,"];
    [reportSqlStr appendString:@"customerID int DEFAULT 0,"];
    [reportSqlStr appendString:@"oneImgPath TEXT(100),"];
    [reportSqlStr appendString:@"twoImgPath TEXT(100),"];
    [reportSqlStr appendString:@"threeImgPath TEXT(100),"];
    [reportSqlStr appendString:@"fourImgPath TEXT(100),"];
    [reportSqlStr appendString:@"fiveImgPath TEXT(100),"];
    [reportSqlStr appendString:@"sixImgPath TEXT(100),"];
    [reportSqlStr appendString:@"sevenImgPath TEXT(100),"];
    [reportSqlStr appendString:@"eightImgPath TEXT(100),"];
    [reportSqlStr appendString:@"nineImgPath TEXT(100),"];
//    [reportSqlStr appendString:@"tenImgPath TEXT(100),"];
    [reportSqlStr appendString:@"reportDate TEXT(100))"];
    [_dataBase executeUpdate:reportSqlStr];
    
    //产品网络关系存储
    NSMutableString *proNetSqlStr = [[NSMutableString alloc] initWithString:@"CREATE TABLE if not exists productNets_info_table("];
    [proNetSqlStr appendString:@"proNetSortNumber INTEGER PRIMARY KEY AUTOINCREMENT,"];
    [proNetSqlStr appendString:@"productNetId int DEFAULT 0,"];
    [proNetSqlStr appendString:@"typeName TEXT(100),"];
    [proNetSqlStr appendString:@"minPercent int DEFAULT 0,"];
    [proNetSqlStr appendString:@"maxPercent int DEFAULT 0,"];
    [proNetSqlStr appendString:@"productTypeStr TEXT(100))"];
    [_dataBase executeUpdate:proNetSqlStr];
}

-(BOOL)excuteSqlString:(NSString *)sqlString{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    return [_dataBase executeUpdate:sqlString];
}

#pragma mark - 所有的广告图数据 相关
-(BOOL)saveAdvertImgData:(XmlImgDownloadModel *)imgModel{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    BOOL isInsertResult = NO;
    if (imgModel) {
        @try {
            //判断广告图数据是否存在
            NSString *selectImageSql = [[NSString alloc]initWithFormat:@"select imageID from advertImages_info_table where imageID = '%d'",imgModel.imageId];
            FMResultSet *selectImageResult = [_dataBase executeQuery:selectImageSql];
            BOOL isExistImage = [selectImageResult next];
            if (isExistImage) {
                return isInsertResult;
            }
            NSString *insertSqlString = [NSString stringWithFormat:@"insert into advertImages_info_table(imageID,imageName,imageOfBase64Str,imagePutdate,imageDeptID,imageParlorID,imageUsername) values('%d','%@','%@','%@','%d','%d','%@')",imgModel.imageId,imgModel.name,imgModel.imgOfBase64Str,imgModel.putdate,imgModel.deptId,imgModel.parlorId,imgModel.username];
            isInsertResult = [self excuteSqlString:insertSqlString];
        } @catch (NSException *exception) {
            NSLog(@"保存广告图数据错误:%@",exception);
        } @finally {
            
        }
    }
    return isInsertResult;
}

-(NSArray *)getAllAdvertImgsData{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *sqlString = @"select * from advertImages_info_table order by  advertImgSortNumber asc";
    FMResultSet *selectResult = [_dataBase executeQuery:sqlString];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    while ([selectResult next]) {
        XmlImgDownloadModel *model = [[XmlImgDownloadModel alloc]init];
        model.imageId = [selectResult intForColumn:@"imageID"];
        model.name = [selectResult stringForColumn:@"imageName"];
        model.imgOfBase64Str = [selectResult stringForColumn:@"imageOfBase64Str"];
        model.putdate = [selectResult stringForColumn:@"imagePutdate"];
        model.deptId = [selectResult intForColumn:@"imageDeptID"];
        model.parlorId = [selectResult intForColumn:@"imageParlorID"];
        model.username = [selectResult stringForColumn:@"imageUsername"];
        [dataArray addObject:model];
    }
    return dataArray;
}

-(BOOL)deleteAdvertImgByImageID:(int)imageId{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM advertImages_info_table WHERE imageID = '%d'",imageId];
    return [_dataBase executeUpdate:sqlString];
}

-(BOOL)deleteAllAdvertImgs{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM advertImages_info_table"];
    return [_dataBase executeUpdate:sqlString];
}

#pragma mark - 轮播图相关
-(BOOL)saveShowImageData:(XmlImgDownloadModel *)imgModel{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    BOOL isInsertResult = NO;
    if (imgModel) {
        @try {
            //判断轮播图是否存在
            NSString *selectImageSql = [[NSString alloc] initWithFormat:@"select imageID from showImages_info_table where imageID = '%d'",imgModel.imageId];
            FMResultSet *selectImageResult = [_dataBase executeQuery:selectImageSql];
            BOOL isExistImage = [selectImageResult next];
            if (isExistImage) {
                return isInsertResult;
            }
            NSString *insertSqlString = [NSString stringWithFormat:@"insert into showImages_info_table(imageID,imageName,imageOfBase64Str,imagePutdate,imageDeptID,imageParlorID,imageUsername) values('%d','%@','%@','%@','%d','%d','%@')",imgModel.imageId,imgModel.name,imgModel.imgOfBase64Str,imgModel.putdate,imgModel.deptId,imgModel.parlorId,imgModel.username];
            isInsertResult = [self excuteSqlString:insertSqlString];
        } @catch (NSException *exception) {
            NSLog(@"保存主页轮播图数据错误:%@",exception);
        } @finally {
            
        }
    }
    return isInsertResult;
}

-(NSArray *)getAllShowImages{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *sqlString = @"select * from showImages_info_table order by  showImgSortNumber asc";
    FMResultSet *selectResult = [_dataBase executeQuery:sqlString];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    while ([selectResult next]) {
        XmlImgDownloadModel *model = [[XmlImgDownloadModel alloc]init];
        model.imageId = [selectResult intForColumn:@"imageID"];
        model.name = [selectResult stringForColumn:@"imageName"];
        model.imgOfBase64Str = [selectResult stringForColumn:@"imageOfBase64Str"];
        model.putdate = [selectResult stringForColumn:@"imagePutdate"];
        model.deptId = [selectResult intForColumn:@"imageDeptID"];
        model.parlorId = [selectResult intForColumn:@"imageParlorID"];
        model.username = [selectResult stringForColumn:@"imageUsername"];
        [dataArray addObject:model];
    }
    return dataArray;
}

-(BOOL)deleteShowImgByImageID:(int)imageId{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM showImages_info_table WHERE imageID = '%d'",imageId];
    return [_dataBase executeUpdate:sqlString];
}

-(BOOL)deleteAllShowImgs{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM showImages_info_table"];
    return [_dataBase executeUpdate:sqlString];
}

#pragma mark - 产品列表相关
-(BOOL)saveProductData:(ProductModel *)productModel{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    BOOL isInsertResult = NO;
    if (productModel) {
        @try {
            //判断轮播图是否存在
            NSString *selectImageSql = [[NSString alloc] initWithFormat:@"select productID from products_info_table where productID = '%d'",productModel.productId];
            FMResultSet *selectImageResult = [_dataBase executeQuery:selectImageSql];
            BOOL isExistImage = [selectImageResult next];
            if (isExistImage) {
                return isInsertResult;
            }
            NSString *insertSqlString = [NSString stringWithFormat:@"insert into products_info_table(productID,productName,productAttrib,productGrade,productPrice,productDiscount,useMethod,productImgOfBase64Str,productPutdate,productDeptID,productParlorID,productUserid) values('%d','%@','%@','%@','%@','%@','%@','%@','%@','%d','%d','%@')",productModel.productId,productModel.name,productModel.attrib,productModel.grade,productModel.price,productModel.discount,productModel.useMethod,productModel.base64ImgStr,productModel.putdate,productModel.deptid,productModel.parlorid,productModel.userid];
            isInsertResult = [self excuteSqlString:insertSqlString];
        } @catch (NSException *exception) {
            NSLog(@"保存产品列表数据错误:%@",exception);
        } @finally {
            
        }
    }
    return isInsertResult;
}

-(NSArray *)getAllProducts{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *sqlString = @"select * from products_info_table order by  productSortNumber asc";
    FMResultSet *selectResult = [_dataBase executeQuery:sqlString];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    while ([selectResult next]) {
        ProductModel *model = [[ProductModel alloc]init];
        model.productId = [selectResult intForColumn:@"productID"];
        model.name = [selectResult stringForColumn:@"productName"];
        model.attrib = [selectResult stringForColumn:@"productAttrib"];
        model.grade = [selectResult stringForColumn:@"productGrade"];
        model.price = [selectResult stringForColumn:@"productPrice"];
        model.discount = [selectResult stringForColumn:@"productDiscount"];
        model.useMethod = [selectResult stringForColumn:@"useMethod"];
        model.base64ImgStr = [selectResult stringForColumn:@"productImgOfBase64Str"];
        model.putdate = [selectResult stringForColumn:@"productPutdate"];
        model.deptid = [selectResult intForColumn:@"productDeptID"];
        model.parlorid = [selectResult intForColumn:@"productParlorID"];
        model.userid = [selectResult stringForColumn:@"productUserid"];
        [dataArray addObject:model];
    }
    return dataArray;
}

-(BOOL)updateProductData:(ProductModel *)productModel withID:(NSInteger)productId{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *updateProductSql = [NSString stringWithFormat:@"update products_info_table set productName = '%@',productAttrib = '%@',productGrade = '%@',productPrice = '%@',productDiscount = '%@',useMethod = '%@',productImgOfBase64Str = '%@',productPutdate = '%@',productDeptID = '%d',productParlorID = '%d',productUserid = '%@' where productID ='%d'",productModel.name,productModel.attrib,productModel.grade,productModel.price,productModel.discount,productModel.useMethod,productModel.base64ImgStr,productModel.putdate,productModel.deptid,productModel.parlorid,productModel.userid,productModel.productId];
    return [self excuteSqlString:updateProductSql];
}

-(BOOL)deleteProductByProductID:(int)productId{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM products_info_table WHERE productID = '%d'",productId];
    return [_dataBase executeUpdate:sqlString];
}

-(BOOL)deleteAllProducts{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM products_info_table"];
    return [_dataBase executeUpdate:sqlString];
}

#pragma mark - 客户列表相关
-(BOOL)saveCustomerData:(customerModel *)model{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    BOOL isInsertResult = NO;
    if (model) {
        @try {
            //判断轮播图是否存在
            NSString *selectImageSql = [[NSString alloc] initWithFormat:@"select customerID from customers_info_table where customerID = '%ld'",model.customerId];
            FMResultSet *selectImageResult = [_dataBase executeQuery:selectImageSql];
            BOOL isExistImage = [selectImageResult next];
            if (isExistImage) {
                return isInsertResult;
            }
            NSString *insertSqlString = [NSString stringWithFormat:@"insert into customers_info_table(customerID,customerName,customerSex,birthday,phoneNumber,email,address,profession,hobby,isOrNo,usedProducts,username,lastdate,headImgOfBase64String,adminuser) values('%ld','%@','%@','%@','%@','%@','%@','%@','%@','%d','%@','%@','%@','%@','%@')",model.customerId,model.name,model.sexStr,model.birthday,model.phoneNumber,model.email,model.address,model.profession,model.hobby,model.isOrNo,model.products,model.username,model.lastdate,model.headImgOfBase64String,model.adminuser];
            isInsertResult = [self excuteSqlString:insertSqlString];
        } @catch (NSException *exception) {
            NSLog(@"保存客户列表数据错误:%@",exception);
        } @finally {
            
        }
    }
    return isInsertResult;
}

-(NSArray *)getAllCustomers{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *sqlString = @"select * from customers_info_table order by  customerSortNumber asc";
    FMResultSet *selectResult = [_dataBase executeQuery:sqlString];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    while ([selectResult next]) {
        customerModel *model = [[customerModel alloc]init];
        model.customerId = [selectResult intForColumn:@"customerID"];
        model.name = [selectResult stringForColumn:@"customerName"];
        model.sexStr = [selectResult stringForColumn:@"customerSex"];
        model.birthday = [selectResult stringForColumn:@"birthday"];
        model.phoneNumber = [selectResult stringForColumn:@"phoneNumber"];
        model.email = [selectResult stringForColumn:@"email"];
        model.address = [selectResult stringForColumn:@"address"];
        model.profession = [selectResult stringForColumn:@"profession"];
        model.hobby = [selectResult stringForColumn:@"hobby"];
        model.isOrNo = [selectResult intForColumn:@"isOrNo"];
        model.products = [selectResult stringForColumn:@"usedProducts"];
        model.username = [selectResult stringForColumn:@"username"];
        model.lastdate = [selectResult stringForColumn:@"lastdate"];
        model.headImgOfBase64String = [selectResult stringForColumn:@"headImgOfBase64String"];
        model.adminuser = [selectResult stringForColumn:@"adminuser"];
        [dataArray addObject:model];
    }
    return dataArray;
}

-(BOOL)updateCustomerData:(customerModel *)model withID:(NSInteger)customerID{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *updateProductSql = [NSString stringWithFormat:@"update customers_info_table set customerName = '%@',customerSex = '%@',birthday = '%@',phoneNumber = '%@',email = '%@',address = '%@',profession = '%@',hobby = '%@',isOrNo = '%d',usedProducts = '%@',username = '%@',lastdate = '%@',headImgOfBase64String = '%@',adminuser = '%@' where customerID ='%ld'",model.name,model.sexStr,model.birthday,model.phoneNumber,model.email,model.address,model.profession,model.hobby,model.isOrNo,model.products,model.username,model.lastdate,model.headImgOfBase64String,model.adminuser,model.customerId];
    return [self excuteSqlString:updateProductSql];
}

-(BOOL)deleteCustomerByCustomerID:(NSInteger)customerId{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM customers_info_table WHERE customerID = '%ld'",customerId];
    return [_dataBase executeUpdate:sqlString];
}

-(BOOL)deleteAllCustomers{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM customers_info_table"];
    return [_dataBase executeUpdate:sqlString];
}

#pragma mark - 客户检测记录相关
-(BOOL)saveReportData:(ReportModel *)model{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    BOOL isInsertResult = NO;
    if (model) {
        @try {
            //判断检测报告是否存在
            NSString *selectReportSql = [[NSString alloc] initWithFormat:@"select customerID from reports_info_table where customerID = '%ld' and reportDate = '%@'",model.customerId,model.reportDate];
            FMResultSet *selectReportResult = [_dataBase executeQuery:selectReportSql];
            BOOL isExistImage = [selectReportResult next];
            if (isExistImage) {
                return isInsertResult;
            }
            NSString *insertSqlString = [NSString stringWithFormat:@"insert into reports_info_table(customerID,oneImgPath,twoImgPath,threeImgPath,fourImgPath,fiveImgPath,sixImgPath,sevenImgPath,eightImgPath,nineImgPath,reportDate) values('%ld','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",model.customerId,model.oneImgPathStr,model.twoImgPathStr,model.threeImgPathStr,model.fourImgPathStr,model.fiveImgPathStr,model.sixImgPathStr,model.sevenImgPathStr,model.eightImgPathStr,model.nineImgPathStr,model.reportDate];
            isInsertResult = [self excuteSqlString:insertSqlString];
        } @catch (NSException *exception) {
            NSLog(@"保存客户列表数据错误:%@",exception);
        } @finally {
            
        }
    }
    return isInsertResult;
}

-(NSArray *)getAllReportsOfCustomerID:(NSInteger)customerID{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *sqlString = @"select * from reports_info_table order by reportSortNumber desc";
    FMResultSet *selectResult = [_dataBase executeQuery:sqlString];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    while ([selectResult next]) {
        ReportModel *model = [[ReportModel alloc]init];
        model.customerId = [selectResult intForColumn:@"customerID"];
        model.oneImgPathStr = [selectResult stringForColumn:@"oneImgPath"];
        model.twoImgPathStr = [selectResult stringForColumn:@"twoImgPath"];
        model.threeImgPathStr = [selectResult stringForColumn:@"threeImgPath"];
        model.fourImgPathStr = [selectResult stringForColumn:@"fourImgPath"];
        model.fiveImgPathStr = [selectResult stringForColumn:@"fiveImgPath"];
        model.sixImgPathStr = [selectResult stringForColumn:@"sixImgPath"];
        model.sevenImgPathStr = [selectResult stringForColumn:@"sevenImgPath"];
        model.eightImgPathStr = [selectResult stringForColumn:@"eightImgPath"];
        model.nineImgPathStr = [selectResult stringForColumn:@"nineImgPath"];
        model.reportDate = [selectResult stringForColumn:@"reportDate"];
        if (model.customerId == customerID) {
            [dataArray addObject:model];
        }
    }
    return dataArray;
}

-(BOOL)updateReportData:(ReportModel *)model withCustomerID:(NSInteger)customerID andReportDate:(NSString *)reportDate{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *updateReportSql = [NSString stringWithFormat:@"update reports_info_table set oneImgPath = '%@',twoImgPath = '%@',threeImgPath = '%@',fourImgPath = '%@',fiveImgPath = '%@',sixImgPath = '%@',sevenImgPath = '%@',eightImgPath = '%@',nineImgPath = '%@' where customerID ='%ld' and reportDate = '%@'",model.oneImgPathStr,model.twoImgPathStr,model.threeImgPathStr,model.fourImgPathStr,model.fiveImgPathStr,model.sixImgPathStr,model.sevenImgPathStr,model.eightImgPathStr,model.nineImgPathStr,model.customerId,model.reportDate];
    return [self excuteSqlString:updateReportSql];
}

-(BOOL)deleteReportByCustomerID:(NSInteger)customerId andReportDate:(NSString *)reportDate{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM reports_info_table WHERE customerID = '%ld' and reportDate = '%@'",customerId,reportDate];
    return [_dataBase executeUpdate:sqlString];
}

-(BOOL)deleteReportsOfCustomerID:(NSInteger)customerId{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM reports_info_table WHERE customerID = '%ld'",customerId];
    return [_dataBase executeUpdate:sqlString];
}

-(BOOL)deleteAllReports{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM reports_info_table"];
    return [_dataBase executeUpdate:sqlString];
}

#pragma mark - 产品网络关系相关
-(BOOL)saveProductNetData:(ProductNetModel *)model{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return NO;
    }
    BOOL isInsertResult = NO;
    if (model) {
        @try {
            //判断产品网络关系数据是否存在
            NSString *selectProNetSql = [[NSString alloc]initWithFormat:@"select productNetId from productNets_info_table where productNetId = '%d'",model.productNetId];
            FMResultSet *selectProNetResult = [_dataBase executeQuery:selectProNetSql];
            BOOL isExistProNet = [selectProNetResult next];
            if (isExistProNet) {
                return isInsertResult;
            }
            NSString *productTypeStr = [self stringWithArray:model.productTypeArr];
            NSString *insertSqlString = [NSString stringWithFormat:@"insert into productNets_info_table(productNetId,typeName,minPercent,maxPercent,productTypeStr) values('%d','%@','%ld','%ld','%@')",model.productNetId,model.typeName,model.minPercent,model.maxPercent,productTypeStr];
            isInsertResult = [self excuteSqlString:insertSqlString];
        } @catch (NSException *exception) {
            NSLog(@"保存产品网络关系数据错误:%@",exception);
        } @finally {
            
        }
    }
    return isInsertResult;
}

-(NSArray *)getAllProductNets{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *sqlString = @"select * from productNets_info_table order by proNetSortNumber asc";
    FMResultSet *selectResult = [_dataBase executeQuery:sqlString];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    while ([selectResult next]) {
        ProductNetModel *model = [[ProductNetModel alloc]init];
        model.productNetId = [selectResult intForColumn:@"productNetId"];
        model.typeName = [selectResult stringForColumn:@"typeName"];
        model.minPercent = [selectResult intForColumn:@"minPercent"];
        model.maxPercent = [selectResult intForColumn:@"maxPercent"];
        NSString *productTypeStr = [selectResult stringForColumn:@"productTypeStr"];
        NSArray *modelArr = [productTypeStr componentsSeparatedByString:@","];
        model.productTypeArr = modelArr;
        [dataArray addObject:model];
    }
    return dataArray;
}

-(ProductNetModel *)getProductNetDataByProductNetId:(NSInteger)productNetId{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *sqlString = @"select * from productNets_info_table order by proNetSortNumber asc";
    FMResultSet *selectResult = [_dataBase executeQuery:sqlString];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    while ([selectResult next]) {
        ProductNetModel *model = [[ProductNetModel alloc]init];
        model.productNetId = [selectResult intForColumn:@"productNetId"];
        model.typeName = [selectResult stringForColumn:@"typeName"];
        model.minPercent = [selectResult intForColumn:@"minPercent"];
        model.maxPercent = [selectResult intForColumn:@"maxPercent"];
        NSString *productTypeStr = [selectResult stringForColumn:@"productTypeStr"];
        NSArray *modelArr = [productTypeStr componentsSeparatedByString:@","];
        model.productTypeArr = modelArr;
        [dataArray addObject:model];
    }
    ProductNetModel *proModel = [[ProductNetModel alloc]init];
    if (dataArray.count>0) {
        proModel = [dataArray objectAtIndex:0];
    }
    return proModel;
}

-(BOOL)updateProductNetData:(ProductNetModel *)model{
    if (![_dataBase open]) {
        NSLog(@"FMDB数据表打开失败!");
        return nil;
    }
    NSString *productTypeStr = [self stringWithArray:model.productTypeArr];
    NSString *updateReportSql = [NSString stringWithFormat:@"update productNets_info_table set typeName = '%@',minPercent = '%ld',maxPercent = '%ld',productTypeStr = '%@' where productNetId ='%d'",model.typeName,model.minPercent,model.maxPercent,productTypeStr,model.productNetId];
    return [self excuteSqlString:updateReportSql];
}

//将数组转换为字符串
-(NSString *)stringWithArray:(NSArray *)array{
    NSString *detailStr = @"";
    if (array.count > 0) {
        for (int i = 0; i < array.count; i++) {
            detailStr = [detailStr stringByAppendingFormat:@",%@",array[i]];
        }
    }
    if ([[detailStr substringToIndex:1] isEqualToString:@","]) {
        detailStr = [detailStr substringFromIndex:1];
    }
    return detailStr;
}

@end
