//
//  MDDayPickViewController.m
//  MyDaily
//
//  Created by gaoyang on 2017/2/6.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDDayPickViewController.h"
#import "MDThemeColorManager.h"

@interface MDDayPickViewController ()

@property (nonatomic,strong) UIButton *positiveButton;
@property (nonatomic,strong) UIButton *neutralButton;
@property (nonatomic,strong) UIButton *negativeButton;

@end

@implementation MDDayPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.positiveButton];
    [self.view addSubview:self.neutralButton];
    [self.view addSubview:self.negativeButton];
}

- (void)buttonClicked:(id)sender {
    
}


-(UIButton *)positiveButton {
    if(!_positiveButton) {
        _positiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_positiveButton setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3)];
        [_positiveButton setBackgroundColor:[[MDThemeColorManager sharedInstance] positiveColor]];
        [_positiveButton setTitle:@"Positive" forState:UIControlStateNormal];
        [_positiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_positiveButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    }
    return _negativeButton;
}

@end
