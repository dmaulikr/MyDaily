//
//  MDDailyEmotionModel.h
//  MyDaily
//
//  Created by gaoyang on 17/1/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Realm/Realm.h>
#import "MDDailyEmotionInterface.h"

@interface MDDailyEmotionModel : RLMObject<MDDailyEmotionProtocol>

@property (nonatomic,strong) NSNumber<RLMInt> *dailyEmotion;
@property (nonatomic,strong) NSString *diaryText;
@property (nonatomic,strong,readonly) NSDate *date;

+ (instancetype)fakeEmotionModelForDate:(NSDate *)date;

@end
