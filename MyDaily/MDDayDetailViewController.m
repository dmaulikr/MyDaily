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

@property (nonatomic,assign) MDEmotionType emotionType;

@end

@implementation MDDayDetailViewController

- (instancetype)initWithEmotion:(MDEmotionType)emotionType {
    if (self = [super init]) {
        self.emotionType = emotionType;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[MDThemeColorManager sharedInstance] colorForEmotion:_emotionType];
}


@end
