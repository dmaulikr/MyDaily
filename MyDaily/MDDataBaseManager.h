//
//  MDDataBaseManager.h
//  MyDaily
//
//  Created by gaoyang on 17/2/10.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDDailyEmotionModel.h"

@interface MDDataBaseManager : NSObject

+ (instancetype)sharedInstance;


- (BOOL)saveEmotionModel:(MDDailyEmotionModel *)model;
- (void)saveEmotionModel:(MDDailyEmotionModel *)model complete:(void(^)(NSError *))complete;

- (MDDailyEmotionModel *)dailyModelForDate:(NSDate *)date;
- (NSArray<MDDailyEmotionModel *> *)dailyModelsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
