//
//  ESCMultiSelectDateCalendarViewController.m
//  ESCalendarView
//
//  Created by xiang on 2018/8/28.
//  Copyright © 2018年 xiang. All rights reserved.
//

#import "ESCMultiSelectDateCalendarViewController.h"
#import "ESMultiSelectDateCalendarView.h"

#define kScreenSize [UIScreen mainScreen].bounds.size


@interface ESCMultiSelectDateCalendarViewController ()

@property(nonatomic,weak)ESMultiSelectDateCalendarView *calendarView;

@end

@implementation ESCMultiSelectDateCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ESMultiSelectDateCalendarView *calendarView = [[ESMultiSelectDateCalendarView alloc] initWithFrame:CGRectMake(0, 100, kScreenSize.width, 300)];
    self.calendarView = calendarView;
    [self.view addSubview:calendarView];
}


@end
