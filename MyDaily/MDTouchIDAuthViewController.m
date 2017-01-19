//
//  MDTouchIDAuthViewController.m
//  MyDaily
//
//  Created by gaoyang on 17/1/17.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDTouchIDAuthViewController.h"
#import <LocalAuthentication/LAContext.h>

@interface MDTouchIDAuthViewController ()

@property (nonatomic,strong) UIButton *touchButton;

@end

@implementation MDTouchIDAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.view.backgroundColor = [UIColor colorWithRed:39./255 green:88./255 blue:170./255 alpha:1];
    [self.view addSubview:self.touchButton];
//    [self makeConstraints];
    [self touchIdLogin];
}

//- (void)makeConstraints {
//    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:_touchButton
//                                                                   attribute:NSLayoutAttributeTop
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:self.view
//                                                                   attribute:NSLayoutAttributeTop
//                                                                  multiplier:1.0
//                                                                    constant:200.0];
//    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:_touchButton
//                                                                   attribute:NSLayoutAttributeLeft
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:self.view
//                                                                   attribute:NSLayoutAttributeLeft
//                                                                  multiplier:1.0
//                                                                    constant:100.0];
//    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:_touchButton
//                                                                   attribute:NSLayoutAttributeRight
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:self.view
//                                                                   attribute:NSLayoutAttributeRight
//                                                                  multiplier:1.0
//                                                                    constant:-100.0];
////    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:_touchButton
////                                                                   attribute:NSLayoutAttributeHeight
////                                                                   relatedBy:NSLayoutRelationEqual
////                                                                      toItem:nil
////                                                                   attribute:NSLayoutAttributeBottom
////                                                                  multiplier:1.0
////                                                                    constant:50.0];
//    [self.view addConstraints:@[constraint1,constraint2,constraint3]];
////    [_touchButton addConstraint:constraint4];
//}

- (void)touchIdLogin {
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalAuthStr = @"为了您的数据安全，请使用touchID登录";
    __weak typeof(self) weakself = self;
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication
                  localizedReason:myLocalAuthStr
                            reply:^(BOOL success, NSError * _Nullable error) {
                                if (weakself) {
                                    typeof(self) strongself = weakself;
                                    if (success) {
                                        [strongself dismissViewControllerAnimated:YES completion:nil];
                                    }else {
                                        
                                    }
                                }
                            }];
    }else {
        
    }
}

- (UIButton *)touchButton {
    if (!_touchButton) {
        _touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_touchButton setFrame:CGRectMake(100,200, 200, 100)];
        [_touchButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        _touchButton.layer.borderWidth = 1.f;
        _touchButton.layer.cornerRadius = 2.f;
        _touchButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _touchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_touchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_touchButton setTitle:@"使用指纹登录" forState:UIControlStateNormal];
        [_touchButton addTarget:self action:@selector(touchIdLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _touchButton;
}

@end
