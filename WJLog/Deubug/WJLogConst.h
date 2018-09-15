//
//  WJDebugConst.h
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/14.
//  Copyright © 2018年 王俊. All rights reserved.
//

#ifndef WJLogConst
#define WJLogConst

typedef NS_ENUM(NSInteger,WJLogLevel) {
    
    WJLogLevelNormal = 0, //普通输出形式
    WJLogLevelWarn,       //警告级的 debug
    WJLogLevelError,      //错误级的 debug
    
};
#import "WJLogManager.h"

#define WJLogBase(_owner,_level,_oepnDB,...) \
[[WJLogManager sharedInstance] \
debugLogOwner:_owner   \
Message:[NSString stringWithFormat:__VA_ARGS__] \
functionName:NSStringFromSelector(_cmd) \
lineNum:__LINE__  \
file:[[NSString stringWithUTF8String:__FILE__] lastPathComponent] \
debugLevel:_level \
isStorage:_oepnDB] \

#define TLog(format...)          WJLogBase(nil,WJLogLevelNormal,NO,format)
#define TLogWarn(format...)      WJLogBase(nil,WJLogLevelWarn,NO,format)
#define TLogError(format...)     WJLogBase(nil,WJLogLevelError,NO,format)


#define TDBLog(format...)        WJLogBase(nil,WJLogLevelNormal,YES,format)
#define TDBERRORLog(format...)   WJLogBase(nil,WJLogLevelWarn,YES,format)
#define TDBWARNLog(format...)    WJLogBase(nil,WJLogLevelError,YES,format)


#endif /* WJLogConst */
