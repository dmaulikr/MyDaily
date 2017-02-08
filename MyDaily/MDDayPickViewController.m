//
//  MDDayPickViewController.m
//  MyDaily
//
//  Created by gaoyang on 2017/2/6.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDayPickViewController.h"
#import "MDThemeColorManager.h"
#import "MDDayDetailEditViewController.h"
#import "MDDayEditTransition.h"

static NSInteger positiveBtnTag = 0;
static NSInteger neutralBtnTag = 1;
static NSInteger negativeBtnTag = 2;

@interface MDDayPickViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) UIButton *positiveButton;
@property (nonatomic,strong) UIButton *neutralButton;
@property (nonatomic,strong) UIButton *negativeButton;

@end

@implementation MDDayPickViewController {
    CGRect _buttonRect;
    CGRect _screenRect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.positiveButton];
    [self.view addSubview:self.neutralButton];
    [self.view addSubview:self.negativeButton];
    self.naviBar.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.naviBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

#pragma mark - action
- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonClicked:(id)sender {
    MDEmotionType emotion = ((UIButton *)sender).tag;
    switch (emotion) {
        case MDEmotionTypePositive: {
            _buttonRect = _positiveButton.frame;
        }
            break;
        case MDEmotionTypeNeutral: {
            _buttonRect = _neutralButton.frame;
        }
            break;
        case MDEmotionTypeNegative: {
            _buttonRect = _negativeButton.frame;
        }
            break;
    }
    _screenRect = self.view.frame;
    MDDayDetailEditViewController *dayEditVC = [[MDDayDetailEditViewController alloc] initWithEmotionType:emotion];
    [self.navigationController pushViewController:dayEditVC animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if(operation == UINavigationControllerOperationPop) {
        if ([toVC isKindOfClass:[UITabBarController class]]) {
            return nil;
        }else {
            return [[MDDayEditTransition alloc] initWithTransitionType:MDDayEditTransitionType_Pop
                                                              fromRect:_screenRect toRect:_buttonRect];
        }
    }else {
        return [[MDDayEditTransition alloc] initWithTransitionType:MDDayEditTransitionType_Push
                                                          fromRect:_buttonRect toRect:_screenRect];
    }
}

#pragma mark - getter
-(UIButton *)positiveButton {
    if(!_positiveButton) {
        _positiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_positiveButton setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3)];
        [_positiveButton setBackgroundColor:[[MDThemeColorManager sharedInstance] positiveColor]];
        [_positiveButton setTitle:@"Positive" forState:UIControlStateNormal];
        [_positiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_positiveButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _positiveButton.tag = positiveBtnTag;
    }
    return _positiveButton;
}

-(UIButton *)neutralButton {
    if(!_neutralButton) {
        _neutralButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_neutralButton setFrame:CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, self.view.frame.size.height/3)];
        [_neutralButton setBackgroundColor:[[MDThemeColorManager sharedInstance] neutralColor]];
        [_neutralButton setTitle:@"Neutral" forState:UIControlStateNormal];
        [_neutralButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_neutralButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _neutralButton.tag = neutralBtnTag;
    }
    return _neutralButton;
}

-(UIButton *)negativeButton {
    if(!_negativeButton) {
        _negativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_negativeButton setFrame:CGRectMake(0, self.view.frame.size.height*2/3, self.view.frame.size.width, self.view.frame.size.height/3)];
        [_negativeButton setBackgroundColor:[[MDThemeColorManager sharedInstance] negativeColor]];
        [_negativeButton setTitle:@"Negative" forState:UIControlStateNormal];
        [_negativeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_negativeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _negativeButton.tag = negativeBtnTag;
    }
    return _negativeButton;
}

@end
