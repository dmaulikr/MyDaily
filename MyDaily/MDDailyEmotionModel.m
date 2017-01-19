//
//  MDDailyEmotionModel.m
//  MyDaily
//
//  Created by gaoyang on 17/1/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDailyEmotionModel.h"

@interface MDDailyEmotionModel ()

@property (nonatomic,strong,readwrite) NSNumber *dailyEmotion;
@property (nonatomic,strong,readwrite) NSString *diaryText;
@property (nonatomic,strong,readwrite) NSDate *date;

@end

@implementation MDDailyEmotionModel

+ (instancetype)fakeEmotionModelForDate:(NSDate *)date {
    MDDailyEmotionModel *fakeModel = [[MDDailyEmotionModel alloc] init];
    fakeModel.dailyEmotion = @(rand() % 3);
    fakeModel.diaryText = @"this is a fake recode";
    fakeModel.date = date;
    return fakeModel;
}

@end
