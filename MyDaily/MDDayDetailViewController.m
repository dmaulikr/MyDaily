//
//  MDDayDetailViewController.m
//  MyDaily
//
//  Created by gaoyang on 2017/2/6.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDayDetailViewController.h"
#import "MDDailyEmotionInterface.h"
#import "MDThemeColorManager.h"

@interface MDDayDetailViewController ()

@property (nonatomic,strong) id<MDDailyEmotionProtocol> emotionModel;

@end

@implementation MDDayDetailViewController

- (instancetype)initWithDailyData:(id<MDDailyEmotionProtocol>)dailyEmotionModel {
    if (self = [super init]) {
        self.emotionModel = dailyEmotionModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[MDThemeColorManager sharedInstance] colorForEmotion:[_emotionModel dailyEmotion].integerValue];
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
