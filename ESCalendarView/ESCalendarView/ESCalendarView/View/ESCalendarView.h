//
//  CalendarView.h
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESCalendarSetting.h"

@class ESCalendarView;


@protocol ESCalendarDelegate <NSObject>

@optional
/**
 初始化调用
 */
- (void)prepareDraw:(NSDate *)date dateTextModel:(ESDateTextModel *)dateTextModel;

/**
 日历被点击时调用
 */
- (void)didTouchDate:(NSDate *)date dateTextModel:(ESDateTextModel *)dateTextModel;

/**
 日历被滚动到指定下标的月份
 */
- (void)CalendarView:(ESCalendarView *)calendarView scrollToIndex:(NSUInteger)index currentDate:(NSDate *)currentDate;

@end

@interface ESCalendarView : UIView

@property(nonatomic,weak)id<ESCalendarDelegate> calendarDelegate;

@property(nonatomic,assign)NSInteger showMonthViewIndex;

//must user this method to init CalendarView
+ (instancetype)calendarViewWithFrame:(CGRect)frame calendarSetting:(ESCalendarSetting *)calendarSetting calendarDelegate:(id<ESCalendarDelegate>)calendarDelegate;

- (void)reloadView;

/**
 返回当前显示日历的时间，只精确到年和月
 */
- (NSDate *)currentMonthDate;

@end
