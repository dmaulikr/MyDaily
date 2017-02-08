//
//  MDBaseViewController.h
//  MyDaily
//
//  Created by gaoyang on 17/1/20.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDBaseViewController : UIViewController

@property (nonatomic,strong) UIView *naviBar;
@property (nonatomic,assign) BOOL showNaviBar;
@property (nonatomic,assign) BOOL showLeftView;

- (void)leftButtonAction;

@end
