//
//  CalendarSetting.m
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ESCalendarSetting.h"
#import "ESCalendarHelp.h"

@interface ESCalendarSetting ()

@property(nonatomic,strong)NSArray* privateDateArray;

@end

@implementation ESCalendarSetting

-(UIColor *)weekViewTextColor{
    if (_weekViewTextColor == nil) {
        _weekViewTextColor = [UIColor blackColor];
    }
    return _weekViewTextColor;
}

-(UIColor *)weekViewWeekendTextColor{
    if (_weekViewWeekendTextColor == nil) {
        _weekViewWeekendTextColor = [UIColor blackColor];
    }
    return _weekViewWeekendTextColor;
}

- (CGFloat)weekViewTextSize {
    if (_weekViewTextSize <= 0) {
        _weekViewTextSize = 20;
    }
    return _weekViewTextSize;
}

- (MonthType)monthType {
    if (_monthType == 0) {
        _monthType = ThisMonth;
    }
    return _monthType;
}

- (NSUInteger)calendarMonths {
    if (_calendarMonths == 0) {
        _calendarMonths = 1;
    }
    return _calendarMonths;
}

- (NSDate *)startDate {
    if (_startDate == nil) {
        //根据monthType计算date
        if (self.monthType == LastMonth) {
            _startDate = [ESCalendarHelp getDate:[NSDate date] withOffMonth:-1];
        }else if (self.monthType == ThisMonth) {
            _startDate = [NSDate date];
        }else {
            _startDate = [ESCalendarHelp getDate:[NSDate date] withOffMonth:1];
        }
    }
    return _startDate;
}

- (NSUInteger)startMonthsIndex {
    if (_startMonthsIndex > self.calendarMonths) {
        _startMonthsIndex = self.calendarMonths - 1;
    }
    return _startMonthsIndex;
}

- (NSArray<NSDate *> *)dateArray {
    return self.privateDateArray;
}

- (NSArray *)privateDateArray {
    if (_privateDateArray == nil) {
        NSMutableArray *temArray = [NSMutableArray array];
        for (int i = 0; i < self.calendarMonths; i++) {
            NSDate* date = [ESCalendarHelp getDate:self.startDate withOffMonth:i];
            [temArray addObject:date];
        }
        _privateDateArray = temArray;
    }
    return _privateDateArray;
}

- (CGFloat)dateViewTextSize {
    if (_dateViewTextSize <= 0) {
        _dateViewTextSize = 20;
    }
    return _dateViewTextSize;
}

- (CGFloat)animationDuration {
    if (_animationDuration <= 0) {
        _animationDuration = 0.3;
    }
    return _animationDuration;
}

@end
