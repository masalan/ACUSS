//
//  MyDatePicker.m
//  YWYiphone
//
//  Created by 刘锋婷 on 14/9/28.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

#import "MyDatePicker.h"

@implementation MyDatePicker

-(id)init
{
    self = [super init];
    if (self) {
        _backgroundView = [UIView createViewWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT)
                                      backgroundColor:KCOLOR_CLEAR];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
        
        UIView *blankView = [UIView createViewWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-PickerHeight-KHEIGHT_40)
                                        backgroundColor:KCOLOR_CLEAR];
        [blankView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBlankTouched)]];
        [_backgroundView addSubview:blankView];
        
        
        _titleView = [[MyPickerTitleView alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-PickerHeight-KHEIGHT_40, KSCREEN_WIDTH, KHEIGHT_40)
                                                   withTitle:@"My birthday"];
        [_titleView.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
        [_titleView.confirmButton addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView  addSubview:_titleView];
        
        
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-PickerHeight, KSCREEN_WIDTH, PickerHeight)];
        _datePicker.backgroundColor = KCOLOR_WHITE;
        [_datePicker setDate:[NSDate date]];
        _datePicker.datePickerMode = UIDatePickerModeDate;
       // _datePicker.datePickerMode = UIDatePickerModeDateAndTime;

        _datePicker.minuteInterval = 5;
        [_backgroundView addSubview:_datePicker];
        
        [self open];
    }
    return self;
}
-(void)showWithTitle:(NSString *)title
{
    _titleView.titleLabel.text = title;
    [self open];
}
//UIDatePickerModeDate
-(void)showWithDatePickerMode:(UIDatePickerMode )mode
{
    [_datePicker setDatePickerMode:mode];
}
-(void)setSelectedDate:(NSDate *)date
{
    [_datePicker setDate:date];
}

#pragma mark - cancel/confirm
-(void)onCancel
{
    [self close];
}
-(void)onConfirm
{
    if (_delegate && [_delegate respondsToSelector:@selector(myDatePickerDidSelectedDate:)]) {
        [_delegate myDatePickerDidSelectedDate:_datePicker.date];
    }
    [self close];
}
#pragma mark - open/close
-(void)open
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_backgroundView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              _backgroundView.backgroundColor = [KCOLOR_BLACK colorWithAlphaComponent:0.2];
                                          }];
                     }];
}
-(void)close
{
    [UIView animateWithDuration:0.1
                     animations:^{
                         _backgroundView.backgroundColor = KCOLOR_CLEAR;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              [_backgroundView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
                                          }];
                     }];
}
#pragma mark -
-(void)onBlankTouched
{
    [self close];
}

@end
