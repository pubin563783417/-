//
//  SB_NomalWeekPicker.h
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SB_NomalWeekPicker : NSObject
- (instancetype)initConfirmBlock:(void(^)(NSInteger year,NSInteger week,NSString *weekFullFormat))confirmBlock cancleBlock:(void(^)(void))cancleBlock;
- (void)showWithYear:(NSInteger)year week:(NSInteger)week;
- (void)showWithAutoDate;
- (void)show;
- (void)close;
@end
