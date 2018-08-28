//
//  ESMultiSelectDateCalendarView.m
//  ESCalendarView
//
//  Created by xiang on 2018/8/28.
//  Copyright © 2018年 xiang. All rights reserved.
//

#import "ESMultiSelectDateCalendarView.h"
#import "ESCalendarHelp.h"
#import "ESCalendarView.h"
#define kScreenSize [UIScreen mainScreen].bounds.size

@interface ESMultiSelectDateCalendarView () <ESCalendarDelegate>

@property (nonatomic, weak) ESCalendarView *calendarView;

@property(nonatomic,strong)NSDate* startDate;

@property(nonatomic,strong)NSDate* endDate;

@end

@implementation ESMultiSelectDateCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCalendarView];
    }
    return self;
}

- (void)setupCalendarView {
    ESCalendarSetting *calendarSetting = [[ESCalendarSetting alloc] init];
    calendarSetting.calendarMonths = 4;
    ESCalendarView *calendarView = [ESCalendarView calendarViewWithFrame:CGRectMake(0, 20, kScreenSize.width, 300) calendarSetting:calendarSetting calendarDelegate:self];
    self.calendarView = calendarView;
    [self addSubview:calendarView];
}

#pragma mark - ESCalendarDelegate
/**
 初始化调用
 */
- (void)prepareDraw:(NSDate *)date dateTextModel:(ESDateTextModel *)dateTextModel {
    dateTextModel.hiddenBackCircle = NO;
    dateTextModel.backgroundColor = [UIColor whiteColor];
    dateTextModel.selectedColor = [UIColor redColor];
    
    if (self.startDate != nil && self.endDate == nil) {
        if ([date isEqualToDate:self.startDate]) {
            dateTextModel.backgroundColor = [UIColor redColor];
        }else {
            dateTextModel.backgroundColor = [UIColor whiteColor];
        }
    }else if(self.startDate != nil && self.endDate != nil) {
        
        if ([ESCalendarHelp isSameDayFirstDate:date secondDate:self.startDate] || [ESCalendarHelp isSameDayFirstDate:self.endDate secondDate:date]) {
            dateTextModel.backgroundColor = [UIColor redColor];
        }else if ([[date earlierDate:self.startDate] isEqualToDate:self.startDate] && [[date earlierDate:self.endDate] isEqualToDate:date]) {
            dateTextModel.backgroundColor = [UIColor redColor];
        }else {
            dateTextModel.backgroundColor = [UIColor whiteColor];
        }
    }
}

/**
 日历被点击时调用
 */
- (void)didTouchDate:(NSDate *)date dateTextModel:(ESDateTextModel *)dateTextModel {
    if (self.startDate == nil && self.endDate == nil) {
        self.startDate = date;
    }else if (self.startDate != nil && self.endDate == nil) {
        self.endDate = date;
        if ([[self.startDate earlierDate:self.endDate] isEqualToDate:self.startDate]) {
            self.endDate = date;
        }else {
            self.endDate = self.startDate;
            self.startDate = date;
        }
        
    }else if (self.startDate != nil && self.endDate != nil) {
        self.endDate = nil;
        self.startDate = date;
    }
}

@end
