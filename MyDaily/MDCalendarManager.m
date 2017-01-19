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

@implementation MDCalendarManager

static MDCalendarManager *manager = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MDCalendarManager alloc] init];
    });
    return manager;
}

- (NSMutableDictionary<NSDate *,NSObject<MDDailyEmotionProtocol> *> *)fakeEmotions {
    JTDateHelper *dateHelper = [[JTDateHelper alloc] init];
    NSDate *date = [dateHelper firstDayOfMonth:[NSDate date]];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    while ([dateHelper date:date isEqualOrBefore:[NSDate date]]) {
        MDDailyEmotionModel * fakeModel = [MDDailyEmotionModel fakeEmotionModelForDate:date];
        if (fakeModel) {
            [result setObject:fakeModel forKey:date];
        }
        date = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
    }
    return result;
}

@end
