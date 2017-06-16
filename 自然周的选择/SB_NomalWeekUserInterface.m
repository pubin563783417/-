//
//  SB_NomalWeekUserInterface.m
//  自然周的选择
//
//  Created by qyb on 2017/6/15.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SB_NomalWeekUserInterface.h"
#import "SB_NomalWeekPublic.h"

#define SB_PickerSection_Numbers 2 //分组个数
#define SB_PickerFirst_Width self.bounds.size.width/5  //年宽
#define SB_PickerSecond_Width self.bounds.size.width/5*2 //周宽
#define SB_PickerRow_Height self.bounds.size.height/6  //row 高

#define self_width  self.bounds.size.width
#define self_height  self.bounds.size.height

@interface SB_NomalWeekUserInterface() <UIPickerViewDelegate,UIPickerViewDataSource>
@end

@implementation SB_NomalWeekUserInterface
{
    UIPickerView *_pickView;
    NSArray *_datas;
     UIView *_blackView;
    void(^_confirmBlock)(NSInteger year,NSInteger week,NSString *weekFullFormat);
    void(^_cancleBlock)(void);
    
    NSInteger _selectYear;
    NSInteger _selectWeek;
    
    NSInteger _recordWeek;
    NSInteger _recordYear;
    
    BOOL _firstLock;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame confirmBlock:(void(^)(NSInteger year,NSInteger week,NSString *weekFullFormat))confirmBlock cancleBlock:(void(^)(void))cancleBlock{
    if (self = [super initWithFrame:frame]) {
        _cancleBlock = cancleBlock;
        _confirmBlock = confirmBlock;
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
        [self configurationFuncControl];
        _recordWeek = [SB_NomalWeekPublic sb_fetchCurrentWeek];
        _recordYear=  [SB_NomalWeekPublic sb_fetchCurrentYear];
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 0, self_width-40, self_height/3*2)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.showsSelectionIndicator = YES;
        [self addSubview:_pickView];
        _datas = [[SB_NomalWeekDataSource shareManager] dataSourceForArray];
    }
    return self;
}

#pragma mark  -  func Control
- (void)configurationFuncControl{
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(0, self_height-45, self_width/2, 45)];
    [cancle setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancle];
    
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(self_width/2, self_height-45, self_width/2, 45)];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirm];
    
    CALayer *separated = [[CALayer alloc]init];
    separated.frame = CGRectMake(0, self_height-45, self_width, 0.5f);
    separated.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    [self.layer addSublayer:separated];
    
    CALayer *vertical = [[CALayer alloc]init];
    vertical.frame = CGRectMake(self_width/2-0.5f, self_height-45, 0.5f, 45);
    vertical.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    [self.layer addSublayer:vertical];
}
- (void)cancle{
    if (_cancleBlock) {
        _cancleBlock();
    }
    [self close];
}
- (void)confirm{
    if (_confirmBlock) {
        _confirmBlock(_selectYear+SB_Base_Year,_selectWeek+1,_datas[_selectYear][_selectWeek]);
    }
    [self close];
}


- (void)close{
    
    _blackView.alpha = 0.35;
    self.alpha = 1.0f;
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:0.20];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationStop)];
    _blackView.alpha = 0.0;
    self.alpha = 0.0f;
    [UIView commitAnimations];
    
}

- (void)animationStop{
    [_blackView removeFromSuperview];
    _blackView = nil;
    [self removeFromSuperview];
    UIView *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in window.subviews) {
        view.userInteractionEnabled = YES;
    }
}
- (void)show{
    if (!_firstLock) {
        _firstLock = YES;
        [self selectYear:0 week:0 animated:NO];
    }
    
    _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    _blackView.backgroundColor = [UIColor blackColor];
    //    _blackView.userInteractionEnabled = NO;
    UIView *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_blackView];
    
    for (UIView *view in window.subviews) {
        view.userInteractionEnabled = NO;
    }
    self.center = window.center;
    [window addSubview:self];
    _blackView.alpha = 0;
    self.alpha = 0.0f;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.20];
    _blackView.alpha = 0.35;
    self.alpha = 1.0f;
    [UIView commitAnimations];
    
    [self reloadData];
   [self selectYear:_selectYear week:_selectWeek animated:NO];
//    [self setNeedsDisplay];
}
#pragma mark  - picker  delegate 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return SB_PickerSection_Numbers;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        
        return _recordYear-SB_Base_Year+1;
    }
    if (_selectYear+SB_Base_Year < _recordYear) {
        NSArray *dataComponents = [_datas objectAtIndex:_selectYear];
        return dataComponents.count;
    }else if (_selectYear+SB_Base_Year == _recordYear){
        return _recordWeek;
    }else{
        return 0;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return  self_width/14*3;
    }else
    return self_width/7*3;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return SB_PickerRow_Height;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    if (view == nil) {
        view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor greenColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SB_PickerSecond_Width, SB_PickerRow_Height)];
        label.tag = 21;
        label.font = [UIFont systemFontOfSize:16];
        
        label.textColor = [UIColor darkTextColor];
        [view addSubview:label];
    }
    UILabel *label = [view viewWithTag:21];
    switch (component) {
        case 0:
        {
            NSString * title = [NSString stringWithFormat:@"%ld年",row+SB_Base_Year];
            label.textAlignment = NSTextAlignmentLeft;
            label.text = title;
            label.frame = CGRectMake(0, 0, SB_PickerSecond_Width, SB_PickerRow_Height);
        }
            
            break;
        case 1:
        {
            NSString *date = [[_datas objectAtIndex:_selectYear] objectAtIndex:row];
            NSString * title = [SB_NomalWeekPublic sb_outPutTitleFormatWithDate:date index:row];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title;
            label.frame = CGRectMake(0, 0, SB_PickerSecond_Width+30, SB_PickerRow_Height);
        }
            break;
        default:
            
            break;
    }
    return view;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        if (_selectYear != row) {
            _selectYear = row;
            NSInteger maxWeeks = ((NSArray *)[_datas objectAtIndex:_selectYear]).count-1;
            maxWeeks = _selectYear==(_recordYear-SB_Base_Year) ? (_recordWeek-1):maxWeeks;
            if (_selectWeek>maxWeeks) {
                _selectWeek = maxWeeks;
            }
            //刷新周的数据
            [pickerView reloadComponent:1];
        }else{
            _selectYear = row;
        }
        
    }else{
        
        _selectWeek = row;
    }
    
    
    
}
#pragma mark  - public func
- (void)reloadData{
    [_pickView reloadAllComponents];
}

- (void)selectYear:(NSInteger)year week:(NSInteger)week animated:(BOOL)animated{
    [_pickView selectRow:year inComponent:0 animated:animated];
    [_pickView selectRow:week inComponent:1 animated:animated];
//    [_pickView selectRow:0 inComponent:0 animated:YES];
}
- (void)setYear:(NSInteger)year week:(NSInteger)week{
    _selectYear = year;
    _selectWeek = week;
}
#pragma mark  -  private  func

@end
