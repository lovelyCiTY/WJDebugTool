//
//  WJDebugManager.h
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/13.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJLogConst.h"

@interface WJLogManager : NSObject

+ (instancetype)sharedInstance;

-(void)debugLogOwner:(NSString *)owner
             Message:(NSString *)message
        functionName:(NSString *)funcName
             lineNum:(NSInteger )lineNum
                file:(NSString *)fileName
          debugLevel:(WJLogLevel )level
           isStorage:(BOOL)isStorage;

@end

