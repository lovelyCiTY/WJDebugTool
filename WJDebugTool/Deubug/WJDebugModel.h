//
//  WJDebugModel.h
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/13.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJDebugConst.h"
@interface WJDebugModel : NSObject


/**
 可以根据业务线设置 同样可以在业务线中对于不同的问题设置 默认不设置 可在终端 filter 中搜索提高效率
 */
@property (nonatomic,strong)NSString *owner;

/**
 一般 log 输入的内容
 */
@property (nonatomic,strong)NSString *messgae;

/**
调用所在方法的方法名称
 */
@property (nonatomic,strong)NSString *funcName;

/**
调用 LOG 的所在行数
 */
@property (nonatomic,assign)NSInteger lineNum;

/**
 调用所在文件的文件名
 */
@property (nonatomic,strong)NSString *fileName;

/**
 可以根据级别进行在终端进行 filter 逐级进行问题的解决
 */
@property (nonatomic,assign)WJDebugLevel debugLevel;

/**
 记录 LOG 记录时间
 使用到的点
 1.记录主线过程每一个点上的事件 找到耗时的地方  然后做进一步排除
 2.可以根据时间从数据库中找到出现问题时间段的日志 查询问题
 3.可以根据时间定期清理数据库  防止数据库冗余数据过多问题
 */
@property (nonatomic,strong)NSString *debugTime;

@end
