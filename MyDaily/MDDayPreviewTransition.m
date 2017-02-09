//
//  MDDayPreviewTransition.m
//  MyDaily
//
//  Created by gaoyang on 17/2/8.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDayPreviewTransition.h"
#import "MDCalendarViewController.h"
#import <JTCalendar/JTCalendar.h>

@interface MDDayPreviewTransition ()<CAAnimationDelegate>

@property (nonatomic,strong) id<UIViewControllerContextTransitioning> context;
//@property (nonatomic,strong) UIViewController *fromVC;

@end

@implementation MDDayPreviewTransition {
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
    self.context = transitionContext;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:_originRect];
    CGPoint originCenter = CGPointMake(_originRect.origin.x + _originRect.size.width/2, _originRect.origin.y + _originRect.size.height/2);
    CGFloat radius = 0;//外层大圆的半径
    //判断起始点圆心是在哪个象限以确定大圆半径
    if (originCenter.x < _toRect.size.width/2 && originCenter.y < _toRect.size.height/2) {
        //第一象限
        radius = sqrt((_toRect.size.width - originCenter.x)*(_toRect.size.width - originCenter.x) + (_toRect.size.height - originCenter.y)*(_toRect.size.height - originCenter.y));
    }else if (originCenter.x >= _toRect.size.width/2 && originCenter.y < _toRect.size.height/2) {
        //第二象限
        radius = sqrt((originCenter.x)*(originCenter.x) + (_toRect.size.height - originCenter.y)*(_toRect.size.height - originCenter.y));
    }else if (originCenter.x < _toRect.size.width/2 && originCenter.y >= _toRect.size.height/2) {
        //第三象限
        radius = sqrt((_toRect.size.width - originCenter.x)*(_toRect.size.width - originCenter.x) + (originCenter.y)*(originCenter.y));
    }else {
        //第四象限
        radius = sqrt((originCenter.x)*(originCenter.x) + (originCenter.y)*(originCenter.y));
    }
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(_originRect, -radius, -radius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = endPath.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    toVC.view.layer.mask = shapeLayer;
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskAnimation.toValue = (__bridge id)(endPath.CGPath);
    maskAnimation.delegate = self;
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [shapeLayer addAnimation:maskAnimation forKey:@"pushpath"];
}

- (void)popAnimation:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    self.context = transitionContext;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    CGPoint originCenter = CGPointMake(_toRect.origin.x + _toRect.size.width/2, _toRect.origin.y + _toRect.size.height/2);
    CGFloat radius = 0;//外层大圆的半径
    //判断起始点圆心是在哪个象限以确定大圆半径
    if (originCenter.x < _toRect.size.width/2 && originCenter.y < _toRect.size.height/2) {
        //第一象限
        radius = sqrt((_toRect.size.width - originCenter.x)*(_toRect.size.width - originCenter.x) + (_toRect.size.height - originCenter.y)*(_toRect.size.height - originCenter.y));
    }else if (originCenter.x >= _toRect.size.width/2 && originCenter.y < _toRect.size.height/2) {
        //第二象限
        radius = sqrt((originCenter.x)*(originCenter.x) + (_toRect.size.height - originCenter.y)*(_toRect.size.height - originCenter.y));
    }else if (originCenter.x < _toRect.size.width/2 && originCenter.y >= _toRect.size.height/2) {
        //第三象限
        radius = sqrt((_toRect.size.width - originCenter.x)*(_toRect.size.width - originCenter.x) + (originCenter.y)*(originCenter.y));
    }else {
        //第四象限
        radius = sqrt((originCenter.x)*(originCenter.x) + (originCenter.y)*(originCenter.y));
    }
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(_toRect, -radius, -radius)];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:_toRect];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = endPath.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    fromVC.view.layer.mask = shapeLayer;
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskAnimation.toValue = (__bridge id)(endPath.CGPath);
    maskAnimation.delegate = self;
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [shapeLayer addAnimation:maskAnimation forKey:@"pushpath"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UIViewController *toVC = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromVC = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    toVC.view.layer.mask = nil;
    [self.context completeTransition:![self.context transitionWasCancelled]];
}


@end
