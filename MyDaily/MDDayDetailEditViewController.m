//
//  MDDayDetailEditViewController.m
//  MyDaily
//
//  Created by gaoyang on 17/2/7.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDayDetailEditViewController.h"
#import "MDThemeColorManager.h"

@interface MDDayDetailEditViewController ()

@property (nonatomic,assign) MDEmotionType currentEmotionType;

@end

@implementation MDDayDetailEditViewController

- (instancetype)initWithEmotionType:(MDEmotionType)emotionType {
    if (self = [super init]) {
        _currentEmotionType = emotionType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[MDThemeColorManager sharedInstance] colorForEmotion:_currentEmotionType];
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
