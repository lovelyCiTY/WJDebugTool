//
//  WJDebugDB.h
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/13.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import "WJDBManager.h"
#import "WJDebugConst.h"

@class WJDebugModel;

@interface WJDebugDB : WJDBManager


-(BOOL)isNeedCreateDebugTable;
/**
 插入一条消息
 
 @param message debug 信息
 */
-(void)saveDebugModel:(WJDebugModel *)message;

/**
 批量的处理（事务处理更高效）
 
 @param messages debug 信息
 @return 返回批量处理是否成功
 */
-(BOOL)transactionInsertDebugModel:(NSArray <WJDebugModel *>*)messages;


-(NSArray *)searchDebugMessageWithType:(WJDebugLevel )type;



@end
