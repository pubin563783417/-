//
//  SB_NomalWeekPublic.m
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SB_NomalWeekPublic.h"
#import "SB_NomalWeekDataSource.h"
#import "DateTools.h"
@implementation SB_NomalWeekPublic
+ (NSInteger)sb_fetchCurrentWeek{
    NSDate*date = [NSDate date];
    
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];
    NSDateComponents*comps;
    // 年月日获得
    comps =[calendar components:(NSWeekCalendarUnit | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal)
                       fromDate:date];
    NSInteger week = [comps week]; // 今年的第几周
    if (![self firstDayInYear:comps.year]) {
        week --;
    }
    if (week == 0) {
        NSArray *datas = [[SB_NomalWeekDataSource shareManager] dataSourceForArray];
        NSArray *weeks = [datas objectAtIndex:comps.year-2016-1];
        week = weeks.count;
    }
    return week;
}
+ (NSInteger)sb_fetchCurrentYear{
    
    NSDate*date = [NSDate date];
    
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];
    NSDateComponents*comps;
    // 年月日获得
    comps =[calendar components:(NSWeekCalendarUnit | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal)
                       fromDate:date];
    NSInteger week = [comps week]; // 今年的第几周
    NSInteger year = [comps year];
    if (![self firstDayInYear:comps.year]) {
        week --;
    }
    if (week == 0) {
        year --;
    }
    return year;
}
+ (BOOL)firstDayInYear:(NSInteger)year{
    NSDate *firstDayInYear = [NSDate dateWithYear:year month:1 day:1];
    if (firstDayInYear.weekday != 2) {
        return NO;
    }else return YES;
}
@end
