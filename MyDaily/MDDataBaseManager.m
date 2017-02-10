//
//  MDDataBaseManager.m
//  MyDaily
//
//  Created by gaoyang on 17/2/10.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDataBaseManager.h"

static MDDataBaseManager *manager = nil;

@implementation MDDataBaseManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MDDataBaseManager alloc] init];
    });
    return manager;
}

@end
