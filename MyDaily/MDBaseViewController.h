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
//@property (nonatomic,assign) BOOL showNaviBar;

@property (nonatomic,assign) BOOL showLeftView;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIImage *customLeftView;
@property (nonatomic,strong) UIImage *customLeftViewHighlighted;

//@property (nonatomic,assign) BOOL showRightView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UIImage *customRightView;
@property (nonatomic,strong) UIImage *customRightViewHighlighted;

- (void)leftButtonAction;
- (void)rightButtonAction;

@end
