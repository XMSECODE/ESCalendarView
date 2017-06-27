//
//  CalendarView.m
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ESCalendarView.h"
#import "ESMonthView.h"
#import "ESDateTextModel.h"
#import "ESCalendarHelp.h"

@interface ESCalendarView () <UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView* scrollView;

@property(nonatomic,strong)NSArray<ESMonthView *>* monthViewArray;

@property(nonatomic,strong)ESCalendarSetting* calendarSetting;

@end

@implementation ESCalendarView

+ (instancetype)calendarViewWithFrame:(CGRect)frame calendarSetting:(ESCalendarSetting *)calendarSetting calendarDelegate:(id<ESCalendarDelegate>)calendarDelegate {
    ESCalendarView* calendarView = [[ESCalendarView alloc] initWithFrame:frame];
    calendarView.calendarDelegate = calendarDelegate;
    calendarView.calendarSetting = calendarSetting;
    return calendarView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initScrollView];
    }
    return self;
}

- (void)initScrollView {
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
}

- (void)initMonthView {
    NSMutableArray* temArray = [NSMutableArray array];
    for (int i = 0; i < self.calendarSetting.calendarMonths; i++) {
        ESMonthView* monthView = [[ESMonthView alloc] initWithFrame:self.bounds];
        monthView.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        [temArray addObject:monthView];
        monthView.date = self.calendarSetting.dateArray[i];
        monthView.calendarSetting = self.calendarSetting;
        [self.scrollView addSubview:monthView];
        __weak typeof(self)weakSelf = self;
        if (self.calendarDelegate && [self.calendarDelegate respondsToSelector:@selector(prepareDraw:dateTextModel:)]) {
            [monthView setPrepareDraw:^(NSDate *date, ESDateTextModel *dateTextModel) {
                [weakSelf.calendarDelegate prepareDraw:date dateTextModel:dateTextModel];
            }];
        }
        if (self.calendarDelegate && [self.calendarDelegate respondsToSelector:@selector(didTouchDate:dateTextModel:)]) {
            [monthView setDidTouchDate:^(NSDate *date, ESDateTextModel *dateTextModel) {
                [weakSelf.calendarDelegate didTouchDate:date dateTextModel:dateTextModel];
            }];
        }
    }
    
    self.monthViewArray = temArray;
}

- (void)reloadView {
    for (ESMonthView* monthView in self.monthViewArray) {
        [monthView reloadView];
    }
}

#pragma mark - setter & getter
- (void)setCalendarSetting:(ESCalendarSetting *)calendarSetting {
    _calendarSetting = calendarSetting;
    
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * calendarSetting.calendarMonths, self.bounds.size.height);
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width * calendarSetting.startMonthsIndex, 0);
    [self initMonthView];
}

- (void)setShowMonthViewIndex:(NSInteger)showMonthViewIndex {
    _showMonthViewIndex = showMonthViewIndex;
    [self.scrollView scrollRectToVisible:CGRectMake(self.bounds.size.width * showMonthViewIndex, 0, self.bounds.size.width, self.bounds.size.height) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = (NSInteger)(offset.x / scrollView.bounds.size.width);
    if (self.calendarDelegate) {
        if ([self.calendarDelegate respondsToSelector:@selector(CalendarView:scrollToIndex:currentDate:)]) {
            NSDate* startDate = self.calendarSetting.startDate;
            NSDate* currentDate = [ESCalendarHelp getDate:startDate withOffMonth:index];
            [self.calendarDelegate CalendarView:self scrollToIndex:index currentDate:currentDate];
        }
    }
}

- (NSDate *)currentMonthDate {
    CGPoint offset = self.scrollView.contentOffset;
    NSInteger index = (NSInteger)(offset.x / self.scrollView.bounds.size.width);
    NSDate* startDate = self.calendarSetting.startDate;
    NSDate* currentDate = [ESCalendarHelp getDate:startDate withOffMonth:index];
    return currentDate;
}

@end
