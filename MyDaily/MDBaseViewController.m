//
//  MDBaseViewController.m
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDBaseViewController.h"
#import "UIDefine.h"

#define MDNavigationBarLeftViewTag          100
#define MDNavigationBarCenterViewTag        200
#define MDNavigationBarRightViewTag         300

@interface MDBaseViewController ()

@end

@implementation MDBaseViewController

- (instancetype)init {
    if (self = [super init]) {
        _showNaviBar = YES;
        _showLeftView = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0., 0., CGRectGetWidth(self.view.bounds), kNaviHeight)];
    navigationBar.alpha = 0.5;
    [self.view addSubview:navigationBar];
    navigationBar.clipsToBounds = YES;
    _naviBar = navigationBar;
    [self initLeftView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveThemeChangedNoti) name:kThemeDidChangedNotification object:nil];
}

- (void)initLeftView{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, kNaviHeight, kNaviHeight);
    [backButton setImage:UI_IMAGE(@"bookcity_back") forState:UIControlStateNormal];
    [backButton setImage:UI_IMAGE(@"bookcity_back_pressed") forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 16.0, 0, 0);
    [backButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = MDNavigationBarLeftViewTag;
    [_naviBar addSubview:backButton];
}

- (void)removeLeftView{
    UIView* view = [_naviBar viewWithTag:MDNavigationBarLeftViewTag];
    [view removeFromSuperview];
}

- (void)setShowLeftView:(BOOL)showLeftView {
    _showLeftView = showLeftView;
    if (!_showLeftView) {
        [self removeLeftView];
    }
}

- (void)onReceiveThemeChangedNoti {
    //override in subclass
}

- (void)leftButtonAction {
    //override in subclass
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangedNotification object:nil];
}

@end
