//
//  WJDebugDB.h
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/13.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import "WJDBManager.h"
#import "WJLogConst.h"

@class WJLogModel;

@interface WJLogDB : WJDBManager


-(BOOL)isNeedCreateDebugTable;
/**
 插入一条消息
 
 @param message debug 信息
 */
-(void)saveDebugModel:(WJLogModel *)message;





@end
