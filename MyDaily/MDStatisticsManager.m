//
//  MDStatisticsManager.m
//  MyDaily
//
//  Created by gaoyang on 17/1/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDStatisticsManager.h"
#import "MDDailyEmotionInterface.h"
#import "MDCalendarManager.h"

@implementation MDStatisticsManager
static MDStatisticsManager * manager = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MDStatisticsManager alloc] init];
    });
    return manager;
}

- (NSDictionary<NSNumber *,NSNumber *> *)proportionForEmotionsForMonth:(NSDate *)date {
    NSDictionary *monthData = [[MDCalendarManager sharedInstance] fakeEmotionsForMonth:date];
    __block NSInteger positive = 0,neutral = 0,negative = 0;
    [monthData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSObject<MDDailyEmotionProtocol> *dayData = obj;
        MDEmotionType dayEmotionType = dayData.dailyEmotion.integerValue;
        switch (dayEmotionType) {
            case MDEmotionTypePositive:
                positive++;
                break;
            case MDEmotionTypeNeutral:
                neutral++;
                break;
            case MDEmotionTypeNegative:
                negative++;
                break;
        }
    }];
    NSInteger total = (positive + neutral + negative);
    float positivePortion = (float)positive/total;
    float neutralPortion = (float)neutral/total;
    float negativePortion = (float)negative/total;
    return @{@(MDEmotionTypePositive):@(positivePortion),
             @(MDEmotionTypeNeutral):@(neutralPortion),
             @(MDEmotionTypeNegative):@(negativePortion)};
}

@end
