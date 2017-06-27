//
//  WeekView.m
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ESWeekView.h"

@interface ESWeekView ()

@property(nonatomic,strong)NSArray<NSString *>* weekStringArray;

@end

@implementation ESWeekView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    for (int i = 0; i < 7; i++) {
        NSString* weekString = self.weekStringArray[i];
        if (i == 0 || i == 6) {
            [self drawText:weekString frame:CGRectMake(i * rect.size.width / 7, 0, rect.size.width / 7, rect.size.height) color:self.weekViewWeekendTextColor];
        }else {
            [self drawText:weekString frame:CGRectMake(i * rect.size.width / 7, 0, rect.size.width / 7, rect.size.height) color:self.weekViewTextColor];
        }
        
    }
    
}

- (void)drawText:(NSString *)text frame:(CGRect)frame color:(UIColor *)color{
    NSDictionary* attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:self.textSize],
                                 NSForegroundColorAttributeName:color
                                 };
    CGSize size = [text sizeWithAttributes:attributes];
    CGRect drawRect = CGRectMake((frame.size.width - size.width) / 2 + frame.origin.x, (frame.size.height - size.height) / 2, size.width, size.height);
    
    [text drawInRect:drawRect withAttributes:attributes];
}

#pragma mark - setter & getter
- (NSArray<NSString *> *)weekStringArray {
    if (_weekStringArray == nil) {
        _weekStringArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _weekStringArray;
}

@end
