//
//  MDCalendarManager.h
//  MyDaily
//
//  Created by gaoyang on 17/1/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDDailyEmotionInterface.h"

@interface MDCalendarManager : NSObject

+ (instancetype)sharedInstance;
- (NSMutableDictionary<NSDate *,NSObject<MDDailyEmotionProtocol> *> *)fakeEmotionsForMonth:(NSDate *)date;

//某个月的数据
- (NSMutableDictionary<NSDate *,NSObject<MDDailyEmotionProtocol> *> *)dataForMonth:(NSDate *)date;

@end
