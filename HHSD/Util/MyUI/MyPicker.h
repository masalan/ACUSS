//
//  MyPicker.h
//  YWYiphone
//
//  Created by 汪达 on 14/9/22.
//  Copyright (c) 2014年 汪达. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macros.h"

#define PickerHeight 216
@class MyPicker;

@protocol MyPickerDelegate <NSObject>

-(void)myPicker:(MyPicker *)picker didPickRow:(NSInteger)row;

@optional
-(void)myPicker:(MyPicker *)picker willPickRow:(NSInteger)row;

@end



#pragma mark - MyPickerTitleView

@interface MyPickerTitleView : UIView

@property (nonatomic,strong)UIButton *cancelButton;
@property (nonatomic,strong)UIButton *confirmButton;
@property (nonatomic,strong)UILabel *titleLabel;

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

@end

#pragma mark - MyPicker

@interface MyPicker : NSObject <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)MyPickerTitleView *titleView;
@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,strong)id <MyPickerDelegate> delegate;

@property (nonatomic,assign)NSInteger pickerTag;

-(void)showWithTitle:(NSString *)title nameArray:(NSArray *)nameArray;
-(void)open;
-(void)close;

@end


