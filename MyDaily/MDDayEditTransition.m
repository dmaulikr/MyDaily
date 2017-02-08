//
//  MDDayEditTransition.m
//  MyDaily
//
//  Created by gaoyang on 17/2/7.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDayEditTransition.h"

@implementation MDDayEditTransition {
    MDDayEditTransitionType _transitionType;
    CGRect _originRect,_toRect;
}

- (instancetype)initWithTransitionType:(MDDayEditTransitionType)transitionType fromRect:(CGRect)originRect toRect:(CGRect)toRect{
    if (self = [super init]) {
        _transitionType = transitionType;
        _originRect = originRect;
        _toRect = toRect;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (_transitionType) {
        case MDDayEditTransitionType_Push:
            [self pushAnimation:transitionContext];
            break;
        case MDDayEditTransitionType_Pop:
            [self popAnimation:transitionContext];
            break;
    }
}

- (void)pushAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    toVC.view.frame = _originRect;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toVC.view.frame = _toRect;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)popAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromVC.view.frame = _toRect;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
