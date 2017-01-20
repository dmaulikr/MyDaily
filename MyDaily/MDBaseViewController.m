//
//  MDBaseViewController.m
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDBaseViewController.h"
#import "UIDefine.h"

@interface MDBaseViewController ()

@end

@implementation MDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveThemeChangedNoti) name:kThemeDidChangedNotification object:nil];
}

- (void)onReceiveThemeChangedNoti {
    //override in subclass
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangedNotification object:nil];
}

@end
