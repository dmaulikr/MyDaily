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


- (BOOL)saveEmotionModel:(MDDailyEmotionModel *)model forDate:(NSDate *)date;
- (void)saveEmotionModel:(MDDailyEmotionModel *)model forDate:(NSDate *)date complete:(void(^)(NSError *))complete;


@end
