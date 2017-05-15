//
//  MyPicker.m
//  YWYiphone
//
//  Created by 汪达 on 14/9/22.
//  Copyright (c) 2014年 汪达. All rights reserved.
//

#import "MyPicker.h"

@implementation MyPicker

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
                                                   withTitle:@"...."];
        [_titleView.cancelButton addTarget:self action:@selector(onCancel) forControlEvents:UIControlEventTouchUpInside];
        [_titleView.confirmButton addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView  addSubview:_titleView];

        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT-PickerHeight,KSCREEN_WIDTH, PickerHeight)];
        _pickerView.backgroundColor = KCOLOR_WHITE;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_backgroundView  addSubview:_pickerView];
    }
    return self;
}
-(void)showWithTitle:(NSString *)title nameArray:(NSArray *)nameArray
{
    _titleArray = nameArray;
    _titleView.titleLabel.text = title;
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [self open];
}

#pragma mark - cancel/confirm
-(void)onCancel
{
    [self close];
}
-(void)onConfirm
{
    if (_delegate && ![_delegate respondsToSelector:@selector(myPicker:willPickRow:)]) {
        if (_delegate && [_delegate respondsToSelector:@selector(myPicker:didPickRow:)]) {
            [_delegate myPicker:self didPickRow:[_pickerView selectedRowInComponent:0]];
        }
        [self close];
    }else{
        [_delegate myPicker:self willPickRow:[_pickerView selectedRowInComponent:0]];
    }
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
                                              _backgroundView.backgroundColor = [KCOLOR_BLACK colorWithAlphaComponent:0.3];
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

#pragma mark - picker delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;//这个picker里的组键数
}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return _titleArray[row];
//}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titleArray count];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(0, 0, pickerView.bounds.size.width,KHEIGHT_40 )
                                       backgroundColor:KCOLOR_CLEAR
                                             textColor:KCOLOR_BLACK
                                                  font:KSYSTEM_FONT_18
                                         textalignment:NSTextAlignmentCenter
                                                  text:_titleArray[row]];
    return nameLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return pickerView.bounds.size.width;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

#pragma mark - 
-(void)onBlankTouched
{
    [self close];
}


@end

#pragma mark - titleView

@implementation MyPickerTitleView

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KCOLOR_BACKGROUND_WHITE;
        
        _cancelButton = [UIButton createButtonwithFrame:CGRectMake(0, 0, KHEIGHT_60, KBOUNDS_HEIGHT)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KTHEME_COLOR
                                                   font:KSYSTEM_FONT_15
                                                  title:@"Cancel"];
        [self addSubview:_cancelButton];
        
        _confirmButton = [UIButton createButtonwithFrame:CGRectMake(kBOUNDS_WIDTH-KHEIGHT_60, 0, KHEIGHT_60, KBOUNDS_HEIGHT)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KTHEME_COLOR
                                                   font:KSYSTEM_FONT_15
                                                  title:@"Ok"];
        [self addSubview:_confirmButton];
        
        _titleLabel = [UILabel createLabelWithFrame:CGRectMake(KHEIGHT_60, 0, kBOUNDS_WIDTH-KHEIGHT_60-KHEIGHT_60, KBOUNDS_HEIGHT)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_BLACK
                                               font:KSYSTEM_FONT_BOLD_(15)
                                      textalignment:NSTextAlignmentCenter
                                               text:title];
        [self addSubview:_titleLabel];
    }
    return self;
}

@end

