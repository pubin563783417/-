//
//  SB_NomalWeekDataSource.m
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SB_NomalWeekDataSource.h"

@implementation SB_NomalWeekDataSource
{
    NSDictionary *_dataSource;
}
+ (instancetype)shareManager{
    static SB_NomalWeekDataSource *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[SB_NomalWeekDataSource alloc] init];
    });
    return data;
}
- (instancetype)init
{
    if (self = [super init]) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"date" ofType:@"plist"];
        _dataSource = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    }
    return self;
}
- (NSArray *)dataSourceForArray{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        NSInteger index = i + 2016;
        NSString *key = [NSString stringWithFormat:@"%ld",index];
        id objc = [_dataSource objectForKey:key];
        [array addObject:objc];
    }
    return array.copy;
}
@end
