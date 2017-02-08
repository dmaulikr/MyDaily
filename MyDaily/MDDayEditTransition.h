//
//  MDDayEditTransition.h
//  MyDaily
//
//  Created by gaoyang on 17/2/7.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MDDayEditTransitionType) {
    MDDayEditTransitionType_Push,
    MDDayEditTransitionType_Pop
};

@interface MDDayEditTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(MDDayEditTransitionType)transitionType fromRect:(CGRect)originRect toRect:(CGRect)toRect;

@end
