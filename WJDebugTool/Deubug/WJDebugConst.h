//
//  WJDebugConst.h
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/14.
//  Copyright © 2018年 王俊. All rights reserved.
//

#ifndef WJDebugConst_h
#define WJDebugConst_h

typedef NS_ENUM(NSInteger,WJDebugLevel) {
    
    WJDebugLevelNormal = 0, //普通输出形式
    WJDebugLevelWarn,       //警告级的 debug
    WJDebugLevelError,      //错误级的 debug
    
};

#define TLogBase(_owner,_level,_oepnDB,_format,...) \
[[TravelDebugManager sharedInstance] \
debugLogOwner:_owner   \
Message:_format \
functionName:NSStringFromSelector(_cmd) \
lineNum:__LINE__  \
file:[[NSString stringWithUTF8String:__FILE__] lastPathComponent] \
debugLevel:TravelDebugLevelNormal \
isStorage:_oepnDB] \

#define TLog(format...)          TLogBase(nil,TravelDebugLevelNormal,NO,format)
#define TLogWarn(format...)      TLogBase(nil,TravelDebugLevelError,NO,format)
#define TLogError(format...)     TLogBase(nil,TravelDebugLevelError,NO,format)


#define TDBLog(format...)        TLogBase(nil,TravelDebugLevelNormal,YES,format)
#define TDBERRORLog(format...)   TLogBase(nil,TravelDebugLevelWarn,YES,format)
#define TDBWARNLog(format...)    TLogBase(nil,TravelDebugLevelError,YES,format)


#endif /* WJDebugConst_h */
