//
//  MDDataBaseManager.m
//  MyDaily
//
//  Created by gaoyang on 17/2/10.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDataBaseManager.h"
#import <Realm/Realm.h>
#import "MDDailyEmotionModel.h"
#import <JTCalendar/JTCalendar.h>


static MDDataBaseManager *manager = nil;

@implementation MDDataBaseManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MDDataBaseManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [docPath objectAtIndex:0];
        NSString *filePath = [path stringByAppendingPathComponent:@"maindatabase"];
        RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
        config.fileURL = [NSURL URLWithString:filePath];
        config.readOnly = NO;
        [RLMRealmConfiguration setDefaultConfiguration:config];
    }
    return self;
}


- (BOOL)saveEmotionModel:(MDDailyEmotionModel *)model {
    [self saveEmotionModel:model complete:nil];
    return YES;
}

- (void)saveEmotionModel:(MDDailyEmotionModel *)model complete:(void(^)(NSError *))complete {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:model];
    [realm commitWriteTransaction];
    complete(nil);
}

- (NSArray<MDDailyEmotionModel *> *)dailyModelsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSMutableArray *resultArray = [NSMutableArray array];
    JTDateHelper *dateHelper = [[JTDateHelper alloc] init];
    NSPredicate *predict = [NSPredicate predicateWithBlock:^BOOL(MDDailyEmotionModel*  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        if ([dateHelper date:evaluatedObject.date isEqualOrAfter:fromDate andEqualOrBefore:toDate]) {
            return YES;
        }else {
            return NO;
        }
    }];
    RLMResults *results = [MDDailyEmotionModel objectsWithPredicate:predict];
    for (MDDailyEmotionModel *model in results) {
        [resultArray addObject:model];
    }
    return resultArray;
}

@end
