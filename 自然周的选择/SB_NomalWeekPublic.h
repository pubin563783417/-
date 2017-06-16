//
//  SB_NomalWeekPublic.h
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SB_NomalWeekPublic : NSObject

/**
 当前周

 @return week
 */
+ (NSInteger)sb_fetchCurrentWeek;

/**
 当前年

 @return year
 */
+ (NSInteger)sb_fetchCurrentYear;

/**
 输出特殊格式的时间戳

 @param date date
 @param index index
 @return date
 */
+ (NSString *)sb_outPutTitleFormatWithDate:(NSString *)date index:(NSInteger)index;

/**
 输出特殊格式时间戳

 @param year year
 @param week week
 @return 时间戳
 */
+ (NSString *)sb_dateFormatWithYear:(NSInteger)year week:(NSInteger)week;

/**
 上一周

 @param year 当前的year
 @param week 挡墙的week
 @param callValue call
 */
+ (void)sb_previonsWeekWithYear:(NSInteger)year week:(NSInteger)week callValue:(void(^)(NSInteger year,NSInteger week))callValue;
/**
 下一周
 
 @param year 当前的year
 @param week 挡墙的week
 @param callValue call
 */
+ (void)sb_nextWeekWithYear:(NSInteger)year week:(NSInteger)week callValue:(void(^)(NSInteger year,NSInteger week))callValue;
@end
