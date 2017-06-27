//
//  MonthView.m
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ESMonthView.h"
#import "ESWeekView.h"
#import "ESCalendarHelp.h"
#import "ESDateView.h"

@interface ESMonthView ()

@property(nonatomic,weak)ESWeekView* weekView;

@property(nonatomic,weak)ESDateView* dateView;

@end

@implementation ESMonthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    ESWeekView* weekView = [[ESWeekView alloc] init];
    int height = (int)self.bounds.size.height / 6;
    weekView.frame = CGRectMake(0, 0, self.bounds.size.width, height);
    [self addSubview:weekView];
    self.weekView = weekView;
    
    ESDateView* dateView = [[ESDateView alloc] init];
    dateView.frame = CGRectMake(0, weekView.bounds.size.height, self.bounds.size.width, self.bounds.size.height - weekView.bounds.size.height);
    [self addSubview:dateView];
    self.dateView = dateView;
}

- (void)setCalendarSetting:(ESCalendarSetting *)calendarSetting {
    _calendarSetting = calendarSetting;
    self.weekView.weekViewTextColor = calendarSetting.weekViewTextColor;
    self.weekView.weekViewWeekendTextColor = calendarSetting.weekViewWeekendTextColor;
    self.weekView.textSize = calendarSetting.weekViewTextSize;
    self.dateView.textSize = calendarSetting.dateViewTextSize;
    self.dateView.animationDuration = calendarSetting.animationDuration;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    self.dateView.date = date;
}

- (void)setPrepareDraw:(void (^)(NSDate *, ESDateTextModel *))prepareDraw {
    _prepareDraw = prepareDraw;
    if (_prepareDraw) {
        __weak typeof(self)weakSelf = self;
        [self.dateView setPrepareDraw:^(NSDate *date, ESDateTextModel *dateTextModel) {
            weakSelf.prepareDraw(date,dateTextModel);
        }];
    }
}

- (void)setDidTouchDate:(void (^)(NSDate *, ESDateTextModel *))didTouchDate {
    _didTouchDate = didTouchDate;
    if (_didTouchDate) {
        __weak typeof(self)weakSelf = self;
        [self.dateView setDidTouchDate:^(NSDate *date, ESDateTextModel *dateTextModel) {
            weakSelf.didTouchDate(date,dateTextModel);
        }];
    }
}

- (void)reloadView {
    [self.dateView reloadView];
}

@end
