//
//  SB_NomalWeekPicker.m
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SB_NomalWeekPicker.h"
#import "SB_NomalWeekDataSource.h"
#import "SB_NomalWeekUserInterface.h"
#import "SB_NomalWeekPublic.h"


@implementation SB_NomalWeekPicker
{
    SB_NomalWeekUserInterface *_picker;
    
   
}
- (instancetype)initConfirmBlock:(void(^)(NSInteger year,NSInteger week,NSString *weekFullFormat))confirmBlock cancleBlock:(void(^)(void))cancleBlock{
    self = [super init];
    _picker = [[SB_NomalWeekUserInterface alloc]initWithFrame:CGRectMake(0, 0, Screen_Width/5*4, Screen_Width/2) confirmBlock:confirmBlock cancleBlock:cancleBlock];
    return self;
}

#pragma  mark -  private func 
- (void)showWithYear:(NSInteger)year week:(NSInteger)week{
    [_picker setYear:year-SB_Base_Year week:week-1];
    [_picker show];
}
- (void)close{
    [_picker close];
}
- (void)showWithAutoDate{
   [ self showWithYear:[SB_NomalWeekPublic sb_fetchCurrentYear] week:[SB_NomalWeekPublic sb_fetchCurrentWeek]];
}
- (void)show{
    [_picker show];
}
@end
