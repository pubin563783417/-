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
    NSMutableArray *_datas;
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
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"sb_date" ofType:@"plist"];
        _dataSource = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    }
    return self;
}
- (NSArray *)dataSourceForArray{
    if (_datas) {
        return _datas;
    }
    _datas = [NSMutableArray array];
    for (int i = 0; i < _dataSource.count; i ++) {
        NSInteger index = i + SB_Base_Year;
        NSString *key = [NSString stringWithFormat:@"%ld",index];
        id objc = [_dataSource objectForKey:key];
        [_datas addObject:objc];
    }
    return _datas.copy;
}
@end
