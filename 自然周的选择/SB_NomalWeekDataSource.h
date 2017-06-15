//
//  SB_NomalWeekDataSource.h
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SB_Base_Year 2016
@interface SB_NomalWeekDataSource : NSObject
+ (instancetype)shareManager;
- (NSArray *)dataSourceForArray;
@end
