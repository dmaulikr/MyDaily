//
//  MDDayDetailViewController.h
//  MyDaily
//
//  Created by gaoyang on 2017/2/6.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDBaseViewController.h"

@protocol MDDailyEmotionProtocol;
@interface MDDayDetailViewController : MDBaseViewController

- (instancetype)initWithDailyData:(id<MDDailyEmotionProtocol>)dailyEmotionModel;

@end
