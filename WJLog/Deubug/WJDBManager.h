//
//  WJDBManager.h
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/14.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WJDBManager : NSObject


/**
 design init method; 在path路径上，1.有数据库，链接上数据库 2.没有该数据库，创建数据库文件
 
 @param path 数据库文件路径
 @return return value description
 */
- (instancetype)initWithDataBasePath:(NSString *)path;

/**
 验证数据库内中是否存在表
 
 @param tableName 需要被验证的表名
 @return 存在：YES  不存在：NO
 */
- (BOOL)isExistTable:(NSString *)tableName;

/**
 查询数据
 
 @param sql sql description
 @return 查询的数据结果array
 */
- (NSArray *)getDataBySQL:(NSString *)sql;

/**
 插入一条数据
 
 @param sql sql description
 @return 插入成功：YES 否则：NO
 */
- (BOOL)insertDataWithSQL:(NSString *)sql;

/**
 删除一条数据
 
 @param sql sql
 @return 删除成功：YES 否则：NO
 */
- (BOOL)deleteDataBySQL:(NSString *)sql;

/**
 事务处理批量数据，批量插入或者批量删除数据
 
 @param sqlArray sql语句数据
 @return return value description
 */
- (BOOL)transactionDataWithSQLArray:(NSArray *)sqlArray;

/**
 特殊字符转义方法
 
 @param keyWord 待转义的特殊字符
 @return return value description
 */
+ (NSString *)sqliteEscape:(NSString *)keyWord;


@end

