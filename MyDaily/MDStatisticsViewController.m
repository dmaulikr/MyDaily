//
//  MDStatisticsViewController.m
//  MyDaily
//
//  Created by gaoyang on 17/1/19.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDStatisticsViewController.h"
#import "UIDefine.h"
#import <XYPieChart/XYPieChart.h>
#import "MDStatisticsManager.h"
#import <QuartzCore/QuartzCore.h>
#import "MDThemeColorManager.h"
#import "UIColor+MDHexColor.h"

static CGFloat pieChartWidth = 300;

@interface MDStatisticsViewController ()<UIScrollViewDelegate,XYPieChartDelegate,XYPieChartDataSource>

@property (nonatomic,strong) UIScrollView *dataDisplayView;
@property (nonatomic,strong) MDStatisticsManager *statisticsManager;

@end

@implementation MDStatisticsViewController

- (instancetype)init {
    if (self = [super init]) {
        self.statisticsManager = [MDStatisticsManager sharedInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.dataDisplayView];
    [self initPieChart];
}

#pragma mark - pie chart
- (void)initPieChart {
    XYPieChart *pieChart = [[XYPieChart alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - pieChartWidth)/2, kNaviHeight, pieChartWidth , pieChartWidth)];
    pieChart.tag = 0;
    pieChart.dataSource = self;
    pieChart.delegate = self;
    [_dataDisplayView addSubview:pieChart];
    [pieChart reloadData];
}

#pragma mark datasource
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
    return 3;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
    NSDictionary *monthData = [_statisticsManager proportionForEmotionsForMonth:[NSDate date]];
    return [[monthData objectForKey:@(index)] floatValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [[MDThemeColorManager sharedInstance] positiveColor];
            break;
        case 1:
            return [[MDThemeColorManager sharedInstance] neutralColor];
            break;
        case 2:
            return [[MDThemeColorManager sharedInstance] negativeColor];
            break;
        default:
            return [UIColor whiteColor];
            break;
    }
}

#pragma mark delegate

#pragma mark - getter

- (UIScrollView *)dataDisplayView {
    if (!_dataDisplayView) {
        _dataDisplayView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNaviHeight, self.view.bounds.size.width, 400)];
        [_dataDisplayView setContentSize:CGSizeMake(5*self.view.bounds.size.width, 400)];
        _dataDisplayView.showsHorizontalScrollIndicator = NO;
        _dataDisplayView.showsVerticalScrollIndicator = NO;
        _dataDisplayView.pagingEnabled = YES;
        _dataDisplayView.delegate = self;
        _dataDisplayView.backgroundColor = [UIColor orangeColor];
    }
    return _dataDisplayView;
}

@end
