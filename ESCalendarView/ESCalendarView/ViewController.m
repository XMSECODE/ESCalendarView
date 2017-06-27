//
//  ViewController.m
//  ESCalendarView
//
//  Created by xiang on 2017/6/27.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ViewController.h"
#import "ESCalendarView.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ViewController () <ESCalendarDelegate>

@property (nonatomic, weak) ESCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCalendarView];
}

- (void)setupCalendarView {
    ESCalendarSetting *calendarSetting = [[ESCalendarSetting alloc] init];
    calendarSetting.calendarMonths = 4;
    ESCalendarView *calendarView = [ESCalendarView calendarViewWithFrame:CGRectMake(0, 20, kScreenSize.width, 300) calendarSetting:calendarSetting calendarDelegate:self];
    self.calendarView = calendarView;
    [self.view addSubview:calendarView];
}

#pragma mark - ESCalendarDelegate
/**
 初始化调用
 */
- (void)prepareDraw:(NSDate *)date dateTextModel:(ESDateTextModel *)dateTextModel {
    
}

/**
 日历被点击时调用
 */
- (void)didTouchDate:(NSDate *)date dateTextModel:(ESDateTextModel *)dateTextModel {
    
}

@end
