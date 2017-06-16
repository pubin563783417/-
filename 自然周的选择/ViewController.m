//
//  ViewController.m
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ViewController.h"
#import "SB_NomalWeekPicker.h"
#import "DateTools.h"
#import "SB_NomalWeekDataSource.h"
@interface ViewController ()
{
    SB_NomalWeekPicker *picker;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    picker = [[SB_NomalWeekPicker alloc]initConfirmBlock:^(NSInteger year, NSInteger week, NSString *weekFullFormat) {
        
    } cancleBlock:^{
        
    }];
}
- (void)tap{
    
    [picker showWithAutoDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
