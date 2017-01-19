//
//  MDDailyEmotionInterface.h
//  MyDaily
//
//  Created by gaoyang on 17/1/18.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#ifndef MDDailyEmotionInterface_h
#define MDDailyEmotionInterface_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MDEmotionType) {
    MDEmotionTypePositive,
    MDEmotionTypeNeutral,
    MDEmotionTypeNegative,
};

@protocol MDDailyEmotionProtocol <NSObject>

- (NSNumber *)dailyEmotion;
- (NSString *)diaryText;
- (NSDate *)date;

@end


#endif /* MDDailyEmotionInterface_h */
