//
//  MDCalendarManager.m
//  MyDaily
//
//  Created by gaoyang on 17/1/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDCalendarManager.h"
#import <JTCalendar/JTCalendar.h>
#import "MDDailyEmotionModel.h"
#import "MDDataBaseManager.h"

@implementation MDCalendarManager

static MDCalendarManager *manager = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MDCalendarManager alloc] init];
    });
    return manager;
}

- (NSMutableDictionary<NSDate *,NSObject<MDDailyEmotionProtocol> *> *)fakeEmotionsForMonth:(NSDate *)date {
    JTDateHelper *dateHelper = [[JTDateHelper alloc] init];
    NSDate *adate = [dateHelper firstDayOfMonth:date];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    while ([dateHelper date:adate isEqualOrBefore:[NSDate date]]) {
        MDDailyEmotionModel * fakeModel = [MDDailyEmotionModel fakeEmotionModelForDate:adate];
        if (fakeModel) {
            [result setObject:fakeModel forKey:adate];
        }
        adate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:adate];
    }
    return result;
}

- (NSMutableDictionary<NSDate *,NSObject<MDDailyEmotionProtocol> *> *)dataForMonth:(NSDate *)date {
    JTDateHelper *dateHelper = [[JTDateHelper alloc] init];
    NSDate *adate = [dateHelper firstDayOfMonth:date];
    NSArray<MDDailyEmotionModel *> *queryResult = [[MDDataBaseManager sharedInstance] dailyModelsFromDate:adate toDate:date];
    if (queryResult || queryResult.count == 0) {
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (MDDailyEmotionModel *model in queryResult) {
        [dict setObject:model forKey:model.date];
    }
    return dict;
}


@end
