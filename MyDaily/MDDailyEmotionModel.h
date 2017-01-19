//
//  MDDailyEmotionModel.h
//  MyDaily
//
//  Created by gaoyang on 17/1/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Realm/Realm.h>
#import "MDDailyEmotionInterface.h"

@interface MDDailyEmotionModel : NSObject<MDDailyEmotionProtocol>

@property (nonatomic,strong,readonly) NSNumber *dailyEmotion;
@property (nonatomic,strong,readonly) NSString *diaryText;
@property (nonatomic,strong,readonly) NSDate *date;

+ (instancetype)fakeEmotionModelForDate:(NSDate *)date;

@end
