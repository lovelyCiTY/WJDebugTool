//
//  WJDebugDB.m
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/13.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import "WJDebugDB.h"
#import "WJDebugModel.h"

#define kWJDebugLogTable @"WJDebugTable"


@implementation WJDebugDB


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

-(void)saveDebugModel:(WJDebugModel *)debugModel{
    
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

-(BOOL)transactionInsertDebugModel:(NSArray <WJDebugModel *>*)messages{
    
//    if(messages.count <= 0) return YES;
//    __block NSMutableArray *sqlStrArrays = [NSMutableArray array];
//    [messages enumerateObjectsUsingBlock:^(TravelDebugModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        TravelDebugModel *debugModel = (TravelDebugModel *)obj;
//        NSString *sqlStr = @"INSERT INTO (messgae,funcName,lineNum,fileName,debugTime) VALUES ('%@', %@, '%d', %@, '%@')" ;
//        //防止插入空的操作
//        NSString *debugMessage = [TravelDBQueueManager sqliteEscape:debugModel.messgae];
//        NSString *funcName = [TravelDBQueueManager sqliteEscape:debugModel.funcName];
//        NSString *fileName = [TravelDBQueueManager sqliteEscape:debugModel.fileName];
//        NSString *debugTime = [TravelDBQueueManager sqliteEscape:debugModel.debugTime];
//        sqlStr = [NSString stringWithFormat:sqlStr,debugMessage,funcName,debugModel.lineNum,fileName,debugTime];
//        [sqlStrArrays addObject:sqlStr];
//    }];
//    BOOL isSuccess = [self transactionDataWithSQLArray:sqlStrArrays];
//    if(!isSuccess){
//        assert("查询批量插入失败的原因");
//    }
//    return isSuccess;
    return YES;
}


/**
 根据时间 批量的删除无用的 debug 信息
 
 @param messages debug 信息
 */
-(void)transactionDelegateDebugModel:(NSArray <WJDebugModel *>*)messages{
    
    
}

-(NSArray *)searchDebugMessageWithType:( )type{

    
    return nil;
}

@end
