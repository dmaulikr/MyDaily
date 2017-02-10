//
//  MDThemeColorManager.h
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDDailyEmotionInterface.h"

@interface MDThemeColorManager : NSObject

+ (instancetype)sharedInstance;

- (UIColor *)positiveColor;
- (UIColor *)neutralColor;
- (UIColor *)negativeColor;

- (UIColor *)colorForEmotion:(MDEmotionType)emotionType;
- (UIColor *)fontColorForEmotion:(MDEmotionType)emotionType;

@end
