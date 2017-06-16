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
    [calendar setMinimumDaysInFirstWeek:7];
    NSLog(@"%ld",calendar.minimumDaysInFirstWeek);
    NSDateComponents*comps;
    // 年月日获得
    comps =[calendar components:(NSWeekCalendarUnit | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal)
                       fromDate:date];
    NSInteger week = [comps week]; // 今年的第几周
    
    return week;
}
+ (NSInteger)sb_fetchCurrentYear{
    NSDate *date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];
    [calendar setMinimumDaysInFirstWeek:7];
    NSDateComponents*comps;
    // 年月日获得
    comps =[calendar components:(NSWeekCalendarUnit | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitMonth)
                       fromDate:date];
    NSInteger week = [comps week]; // 今年的第几周
    NSInteger year = [comps year];
    
    if ([comps month] == 1 && week > 10) {
        year --;
    }
    return year;
}
+ (NSString *)sb_outPutTitleFormatWithDate:(NSString *)date index:(NSInteger)index{
    date = [date stringByReplacingOccurrencesOfString:@" "withString:@"."];
    NSArray *array = [date componentsSeparatedByString:@"-"];
    NSString *first = [[array firstObject] substringFromIndex:5];
    NSString *last = [[array lastObject] substringFromIndex:5];
    return [NSString stringWithFormat:@"第%ld周(%@-%@)",index+1,first,last];
}
+ (NSString *)sb_dateFormatWithYear:(NSInteger)year week:(NSInteger)week{
    NSArray *datas = [[[SB_NomalWeekDataSource shareManager] dataSourceForArray] objectAtIndex:year-SB_Base_Year];
    NSInteger index = week -1;
    NSString *date = [datas objectAtIndex:index];
    return [self sb_outPutTitleFormatWithDate:date index:index];
}
+ (void)sb_previonsWeekWithYear:(NSInteger)year week:(NSInteger)week callValue:(void(^)(NSInteger year,NSInteger week))callValue{
    week -- ;
    if (week <= 0) {
        year --;
        NSArray *datas = [[SB_NomalWeekDataSource shareManager] dataSourceForArray];
        NSArray *weeks = [datas objectAtIndex:year-SB_Base_Year];
        week = weeks.count;
    }
    
    if (callValue) {
        callValue(year,week);
    }
}
+ (void)sb_nextWeekWithYear:(NSInteger)year week:(NSInteger)week callValue:(void(^)(NSInteger year,NSInteger week))callValue{
    week ++;
    NSArray *datas = [[SB_NomalWeekDataSource shareManager] dataSourceForArray];
    NSArray *weeks = [datas objectAtIndex:year-SB_Base_Year];
    NSInteger maxWeek = weeks.count;
    if (week > maxWeek) {
        year ++;
        week = 1;
    }
    if (callValue) {
        callValue(year,week);
    }
}
+ (BOOL)firstDayInYear:(NSInteger)year{
    NSDate *firstDayInYear = [NSDate dateWithYear:year month:1 day:1];
    if (firstDayInYear.weekday != 2) {
        return NO;
    }else return YES;
}
@end
