//
//  MDStatisticsManager.h
//  MyDaily
//
//  Created by gaoyang on 17/1/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDStatisticsManager : NSObject

+ (instancetype)sharedInstance;
- (NSDictionary<NSNumber *,NSNumber *> *)proportionForEmotionsForMonth:(NSDate *)date;

@end
