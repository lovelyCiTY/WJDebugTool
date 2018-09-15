//
//  WJDebugDB.m
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/13.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import "WJLogDB.h"
#import "WJLogModel.h"

#define kWJDebugLogTable @"WJDebugTable"

@implementation WJLogDB

- (BOOL)createDebugTable {
    NSMutableString *debugLogTableSql = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (",kWJDebugLogTable];
    [debugLogTableSql appendFormat:@"%@ TEXT,", @"owner"];
    [debugLogTableSql appendFormat:@"%@ TEXT,", @"messgae"];     //log 信息
    [debugLogTableSql appendFormat:@"%@ TEXT,", @"funcName"];    //log 方法名
    [debugLogTableSql appendFormat:@"%@ INTEGER,", @"lineNum"];  //log 行数
    [debugLogTableSql appendFormat:@"%@ TEXT,", @"fileName"];    //log 文件名
    [debugLogTableSql appendFormat:@"%@ TEXT,", @"debugTime"];   //log 时间
    [debugLogTableSql appendFormat:@"%@ INTEGER)", @"debugLevel"];
    BOOL createRes = [self insertDataWithSQL:debugLogTableSql];
    return createRes;
}

-(BOOL)isNeedCreateDebugTable{
    
    BOOL isExistDebugTable = [self isExistTable:kWJDebugLogTable];
    if(!isExistDebugTable){
        if(![self createDebugTable]){
            assert("创建 debugger 日志失败");
            return  NO;
        }
    }
    return YES;
}

-(void)saveDebugModel:(WJLogModel *)debugModel{
    
    NSString *sqlStr = @"INSERT INTO %@ (owner,messgae,funcName,lineNum,fileName,debugTime,debugLevel) VALUES ('%@','%@', '%@', %d, '%@', '%@',%d)" ;
    //防止插入空的操作
    NSString *owner = [WJDBManager sqliteEscape:debugModel.owner];
    NSString *debugMessage = [WJDBManager sqliteEscape:debugModel.messgae];
    NSString *funcName = [WJDBManager sqliteEscape:debugModel.funcName];
    NSString *fileName = [WJDBManager sqliteEscape:debugModel.fileName];
    NSString *debugTime = [WJDBManager sqliteEscape:debugModel.debugTime];
    sqlStr = [NSString stringWithFormat:sqlStr,kWJDebugLogTable,owner,debugMessage,funcName,debugModel.lineNum,fileName,debugTime,debugModel.debugLevel];
    [self insertDataWithSQL:sqlStr];
}


-(NSArray *)searchLogMessageWithLevel:(WJLogLevel )level{
    NSString *sql = @"SELECT * FROM %@ WHERE debugLevel = %d";
    sql = [NSString stringWithFormat:sql, kWJDebugLogTable, level];
    NSArray *result = [self getDataBySQL:sql];
    return result;
}

-(NSArray *)searchLogMessageWithSpecificallyOwner:(NSString *)owner{
    NSString *sql = @"SELECT * FROM %@ WHERE owner = '%@'";
    sql = [NSString stringWithFormat:sql, kWJDebugLogTable, owner];
    NSArray *result = [self getDataBySQL:sql];
    return result;
}


-(void)deleteAll{
    NSString *sql = @"DELETE * FROM %@";
    sql = [NSString stringWithFormat:sql,kWJDebugLogTable];
    [self deleteDataBySQL:sql];
}

@end
