//
//  MDCalendarViewController.m
//  MyDaily
//
//  Created by gaoyang on 17/1/18.
//  Copyright © 2017年 gaoyang. All rights reserved.
//

#import "MDCalendarViewController.h"
#import <JTCalendar/JTCalendar.h>
#import <Masonry/Masonry.h>
#import "UIDefine.h"
#import "MDCalendarManager.h"

@interface MDCalendarViewController ()<JTCalendarDelegate>

@property (nonatomic,strong) JTCalendarMenuView *calendarMenuView;
@property (nonatomic,strong) JTHorizontalCalendarView *calendarView;
@property (nonatomic,strong) JTCalendarManager *JTCalendarManager;
@property (nonatomic,strong) MDCalendarManager *MDCalendarManager;
@property (nonatomic,strong) NSDictionary *currentMonthData;

@end

@implementation MDCalendarViewController

- (instancetype)init {
    if (self = [super init]) {
        self.MDCalendarManager = [MDCalendarManager sharedInstance];
        self.JTCalendarManager = [JTCalendarManager new];
        self.JTCalendarManager.delegate = self;
        _currentMonthData = [_MDCalendarManager fakeEmotions];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.calendarMenuView];
    [self.view addSubview:self.calendarView];
    
    [self.JTCalendarManager setMenuView:_calendarMenuView];
    [self.JTCalendarManager setContentView:_calendarView];
    [self.JTCalendarManager setDate:[NSDate date]];

    [self makeConstraints];
}

#pragma mark - UI

- (void)makeConstraints {
    [_calendarMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNaviHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_calendarMenuView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(250);
    }];
}

- (void)configPositiveEmotionUI:(UIView<JTCalendarDay> *)dayView {
    JTCalendarDayView *calendarDayView = (JTCalendarDayView *)dayView;
    calendarDayView.circleView.hidden = NO;
    calendarDayView.circleView.backgroundColor = [UIColor colorWithRed:247./255 green:202./255 blue:201./255 alpha:1];
}

- (void)configNeutralEmotionUI:(UIView<JTCalendarDay> *)dayView {
    JTCalendarDayView *calendarDayView = (JTCalendarDayView *)dayView;
    calendarDayView.circleView.hidden = NO;
    calendarDayView.circleView.backgroundColor = [UIColor lightGrayColor];
}

- (void)configNegativeEmotionUI:(UIView<JTCalendarDay> *)dayView {
    JTCalendarDayView *calendarDayView = (JTCalendarDayView *)dayView;
    calendarDayView.circleView.hidden = NO;
    calendarDayView.circleView.backgroundColor = [UIColor colorWithRed:146./255 green:168./255 blue:209./255 alpha:1];
}

#pragma mark - JTCalendarDelegate

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(UIView<JTCalendarDay> *)dayView {
    JTCalendarDayView *calendarDayView = (JTCalendarDayView *)dayView;
    //hide the day view if it is not in the current displayed month
    if(![_JTCalendarManager.dateHelper date:_calendarView.date isTheSameMonthThan:calendarDayView.date]){
        calendarDayView.textLabel.textColor = [UIColor lightGrayColor];
    }else {
        calendarDayView.textLabel.textColor = [UIColor blackColor];
    }
    NSObject<MDDailyEmotionProtocol> *dateObject = [_currentMonthData objectForKey:calendarDayView.date];
    if (dateObject) {
        MDEmotionType dailyEmotionType = [dateObject.dailyEmotion integerValue];
        switch (dailyEmotionType) {
            case MDEmotionTypePositive:
                [self configPositiveEmotionUI:calendarDayView];
                break;
            case MDEmotionTypeNeutral:
                [self configNeutralEmotionUI:calendarDayView];
                break;
            case MDEmotionTypeNegative:
                [self configNegativeEmotionUI:calendarDayView];
                break;
        }
    }

//    if ([_JTCalendarManager.dateHelper date:calendarDayView.date isTheSameDayThan:[NSDate date]]) {
//        calendarDayView.circleView.hidden = NO;
//        calendarDayView.circleView.backgroundColor = [UIColor blueColor];
//        calendarDayView.dotView.hidden = NO;
//        calendarDayView.dotView.backgroundColor = [UIColor blueColor];
//        calendarDayView.textLabel.textColor = [UIColor whiteColor];
//    }else {
//        calendarDayView.circleView.hidden = YES;
//        calendarDayView.dotView.hidden = YES;
//        calendarDayView.textLabel.textColor = [UIColor blackColor];
//    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(UIView<JTCalendarDay> *)dayView {
    JTCalendarDayView *calendarDayView = (JTCalendarDayView *)dayView;
    // Animation for the circleView
    calendarDayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:calendarDayView
                      duration:.3
                       options:0
                    animations:^{
                        calendarDayView.circleView.transform = CGAffineTransformIdentity;
                        [_JTCalendarManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_JTCalendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_JTCalendarManager.dateHelper date:_calendarView.date isTheSameMonthThan:calendarDayView.date]){
        if([_calendarView.date compare:calendarDayView.date] == NSOrderedAscending){
            [_calendarView loadNextPageWithAnimation];
        }
        else{
            [_calendarView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - getter

- (JTCalendarMenuView *)calendarMenuView {
    if (!_calendarMenuView) {
        _calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectZero];
        _calendarMenuView.manager = _JTCalendarManager;
    }
    return _calendarMenuView;
}

- (JTHorizontalCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[JTHorizontalCalendarView alloc] initWithFrame:CGRectZero];
        _calendarView.manager = _JTCalendarManager;
    }
    return _calendarView;
}



@end
