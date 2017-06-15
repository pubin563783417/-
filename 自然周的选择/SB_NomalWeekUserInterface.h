//
//  SB_NomalWeekUserInterface.h
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SB_NomalWeekDataSource.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface SB_NomalWeekUserInterface : UIVisualEffectView
- (instancetype)initWithFrame:(CGRect)frame confirmBlock:(void(^)(NSInteger year,NSInteger week,NSString *weekFullFormat))confirmBlock cancleBlock:(void(^)(void))cancleBlock;

- (void)reloadData;
- (void)selectYear:(NSInteger)year week:(NSInteger)week animated:(BOOL)animated;
- (void)setYear:(NSInteger)year week:(NSInteger)week;
- (void)show;
- (void)close;
@end
