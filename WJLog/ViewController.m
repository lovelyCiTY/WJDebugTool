//
//  ViewController.m
//  WJLog
//
//  Created by 王俊 on 2018/9/14.
//  Copyright © 2018年 王俊. All rights reserved.
//

#import "ViewController.h"
#import "WJLogConst.h"
#import "WJDBManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0 ; i < 999; i++) {
        TDBLog(@"我要输出部分内容 %@",@"aaaa");
        NSLog(@"我要输出的内容是 %@",@"aaa");
    }
    
}


@end
