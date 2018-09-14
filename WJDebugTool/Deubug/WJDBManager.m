//
//  WJDBManager.m
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/14.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import "WJDBManager.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


@interface WJDBManager()

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end

@implementation WJDBManager

- (instancetype)initWithDataBasePath:(NSString *)path {
    self = [super init];
    if (!self)  return nil;
    _path = path;
    if (_path) {
        self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:_path];
    }
    return self;
}

- (BOOL)isExistTable:(NSString *)tableName {
    NSString *sql = [NSString stringWithFormat:@"select count(*) from sqlite_master where type='table' and name = '%@'",
                     tableName];
    BOOL existTable = NO;
    NSArray *arr = [self getDataBySQL:sql];
    existTable = ([[[arr firstObject] valueForKey:@"count(*)"] intValue] > 0 ? YES : NO);
    return existTable;
}

- (NSArray *)getDataBySQL:(NSString *)sql {
    
    NSMutableArray *res = [NSMutableArray array];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        //获取结果集，返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:sql];
        if([db  hadError]) {
            NSLog(@"%s", __FUNCTION__);
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        while([rs next]) {
            [res addObject:[rs resultDict]];
        }
    }];
    return res;
}

- (BOOL)insertDataWithSQL:(NSString *)sql {
    __block BOOL success = YES;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
        if ([db hadError]) {
            NSLog(@"%s", __FUNCTION__);
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            success = NO;
        }
    }];
    return success;
}

- (BOOL)deleteDataBySQL:(NSString *)sql {
    __block BOOL success = YES;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
        if ([db hadError]) {
            NSLog(@"%s", __FUNCTION__);
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            success = NO;
        }
    }];
    return success;
}

- (BOOL)transactionDataWithSQLArray:(NSArray *)sqlArray {
    __block BOOL success = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        
        BOOL isRollBack = NO;
        @try {
            for (NSString *sql in sqlArray) {
                if (!sql || ![sql isKindOfClass:[NSString class]] || (sql.length <= 0)) {
                    continue;
                }
                [db executeUpdate:sql];
                if ([db hadError]) {
                    NSLog(@"%s", __FUNCTION__);
                    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                    isRollBack = YES;
                    break;
                }
            }
        } @catch (NSException *exception) {
            isRollBack = YES;
            [db rollback];
        } @finally {
            if (!isRollBack) {
                [db commit];
            } else {
                [db rollback];
            }
        }
        
        success = !isRollBack;
    }];
    return success;
}

+ (NSString *)sqliteEscape:(NSString *)keyWord {
    if (keyWord.length > 0) {
        return keyWord;
    }
    keyWord = [keyWord stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    return keyWord;
}


@end
