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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - left view
- (void)initLeftView{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, kNaviHeight, kNaviHeight);
    [backButton setImage:UI_IMAGE(@"bookcity_back") forState:UIControlStateNormal];
    [backButton setImage:UI_IMAGE(@"bookcity_back_pressed") forState:UIControlStateHighlighted];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 16.0, 0, 0);
    [backButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = MDNavigationBarLeftViewTag;
    [_naviBar addSubview:backButton];
}

- (void)removeLeftView{
    UIView* view = [self leftView];
    [view removeFromSuperview];
}

- (void)setShowLeftView:(BOOL)showLeftView {
    _showLeftView = showLeftView;
    if (!_showLeftView) {
        [self removeLeftView];
    }
}

- (void)setCustomLeftView:(UIImage *)customLeftView {
    _customLeftView = customLeftView;
    if (![self leftView]) {
        [self initLeftView];
    }
    UIButton *leftButton = (UIButton *)[self leftView];
    [leftButton setImage:_customLeftView forState:UIControlStateNormal];
}

- (void)setCustomLeftViewHighlighted:(UIImage *)customLeftViewHighlighted {
    _customLeftViewHighlighted = customLeftViewHighlighted;
    if (![self leftView]) {
        [self initLeftView];
    }
    UIButton *leftButton = (UIButton *)[self leftView];
    [leftButton setImage:_customLeftViewHighlighted forState:UIControlStateHighlighted];
}

- (UIView *)leftView {
    return [_naviBar viewWithTag:MDNavigationBarLeftViewTag];
}

#pragma mark - right view
- (void)initRightView{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(self.view.frame.size.width - kNaviHeight, 20, kNaviHeight, kNaviHeight);
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 16.0, 0, 0);
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    rightButton.tag = MDNavigationBarRightViewTag;
    [_naviBar addSubview:rightButton];
}

- (void)setCustomRightView:(UIImage *)customRightView {
    _customRightView = customRightView;
    if (![self rightView]) {
        [self initRightView];
    }
    UIButton *rightButton = (UIButton *)[self rightView];
    [rightButton setImage:_customRightView forState:UIControlStateNormal];
}

- (void)setCustomRightViewHighlighted:(UIImage *)customRightViewHighlighted {
    _customRightViewHighlighted = customRightViewHighlighted;
    if (![self rightView]) {
        [self initRightView];
    }
    UIButton *rightButton = (UIButton *)[self rightView];
    [rightButton setImage:_customRightViewHighlighted forState:UIControlStateHighlighted];
}

- (UIView *)rightView {
    return [_naviBar viewWithTag:MDNavigationBarRightViewTag];
}


- (void)onReceiveThemeChangedNoti {
    //override in subclass
}

- (void)leftButtonAction {
    //override in subclass
}

- (void)rightButtonAction {
    //override in subclass
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangedNotification object:nil];
}

@end
