//
//  DateTextModel.m
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/22.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ESDateTextModel.h"

@implementation ESDateTextModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor blackColor];
        self.hiddenCircle = YES;
        self.circleColor = [UIColor greenColor];
        self.circleRadius = 20;
        self.hiddenBackCircle = YES;
        self.backgroundColor = [UIColor yellowColor];
        self.backCircleRadius = 20;
        self.selectedColor = [UIColor greenColor];
        self.pointRadius = 1;
        self.showPoint = NO;
        self.pointColor = [UIColor redColor];
    }
    return self;
}

+ (instancetype)dateTextModelWithTextColor:(UIColor *)textColor hiddenCircle:(BOOL)hiddenCircle circleColor:(UIColor *)circleColor circleRadius:(CGFloat)circleRadius hiddenBackCircle:(BOOL)hiddenBackCircle backgroundColor:(UIColor *)backgroundColor backCircleRadius:(CGFloat)backCircleRadius {
    ESDateTextModel * model = [[ESDateTextModel alloc] init];
    model.textColor = textColor;
    model.hiddenCircle = hiddenCircle;
    model.circleColor = circleColor;
    model.circleRadius = circleRadius;
    model.hiddenBackCircle = hiddenBackCircle;
    model.backgroundColor = backgroundColor;
    model.backCircleRadius = backCircleRadius;
    return model;
}

@end
