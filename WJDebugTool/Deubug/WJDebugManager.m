//
//  WJDebugManager.m
//  WJDebugTool
//
//  Created by 王俊 on 2018/9/13.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import "WJDebugManager.h"
#import "WJDebugDB.h"
#import "WJDebugModel.m"
#import "WJDebugConst.h"
#import <UIKit/UIKit.h>

@interface WJDebugManager()

@property (nonatomic,strong)WJDebugDB *debugDB;

@end

@implementation WJDebugManager


-(instancetype)init{
    if(self = [super init]){
        self.debugDB = [[WJDebugDB alloc] initWithDataBasePath:[self getTravelDBCachePath]];
        if (![self.debugDB isNeedCreateDebugTable]) {
            return self;
        }
        NSLog(@"debug database path:%@", [self getTravelDBCachePath]);
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WJDebugManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[WJDebugManager alloc] init];
    });
    return instance;
}

-(void)debugLogOwner:(NSString *)owner
             Message:(NSString *)message
        functionName:(NSString *)funcName
             lineNum:(NSInteger )lineNum
                file:(NSString *)fileName
          debugLevel:(WJDebugLevel )level
           isStorage:(BOOL)isStorage
{
    
    NSString *tipsMessage = @"";
    if(level == WJDebugLevelWarn){
        tipsMessage = @"Warn";
    }else if (level == WJDebugLevelError){
        tipsMessage = @"Error";
    }
    
    //制定标准化的输出格式（简单易搜索）
    NSLog(@"%@ %@ %@ %@ %@\n %@",owner,tipsMessage,fileName,funcName,@(lineNum),message);
    
    if(!isStorage){
        return;
    }
    dispatch_queue_t queue = [self getLowPriorityQueue];
    if(!queue){
        assert("查看此处创建低级别线程失败的原因");
    }
    
    dispatch_async(queue, ^{
        WJDebugModel *model = [[WJDebugModel alloc] init];
        model.messgae = message;
        model.funcName = funcName;
        model.lineNum = lineNum;
        model.fileName = fileName;
        model.debugLevel = level;
        model.debugTime = [self getCurrentTimeStringFormatter];
        [self.debugDB saveDebugModel:model];
    });
}

-(dispatch_queue_t )getLowPriorityQueue{
    dispatch_queue_t queue = nil;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8){
        dispatch_queue_attr_t queue_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,QOS_CLASS_BACKGROUND, -1);
        queue = dispatch_queue_create("com.wjDebug.backgroundDebugQueue", queue_attr);
    }else{
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
    return queue;
}

-(NSString *)getCurrentTimeStringFormatter{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    return timeLocal;
}

-(NSString *)getTravelDBCachePath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"DebugLog"];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if(isExist){
        path = [path stringByAppendingPathComponent:@"TravelDebugDB.db"];
        return path;
    }else{
        NSError *error ;
        BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        if(error){
            NSLog(@"error === %@",error);
        }
        if(isSuccess){
            path = [path stringByAppendingPathComponent:@"TravelDebugDB.db"];
            return path;
        }else{
            return @"";
        }
    }
}


@end
