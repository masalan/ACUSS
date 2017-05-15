//
//  MySegementedControl.h
//  YWYiphone2
//
//  Created by liufengting on 15/1/23.
//  Copyright (c) 2015年 liufengting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"

#define MySegementedControlButtonImageWidth 15


@protocol MySegementedControlDelegate <NSObject>

-(void)mySegementedControlDidSelectIndex:(NSInteger)selectedIndex;

@end

/**
 MySegementedControlButton
 
 :param: idinitWithFrame
 */
@interface MySegementedControlButton : UIButton

-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image name:(NSString *)name backgroundColor:(UIColor *)backgroundColor selectedBackgroudColor:(UIColor *)selectedBackgroudColor;

@end

/**
 MySegementedControl
 
 :param: idinitWithFrame 
 */
@interface MySegementedControl : UIView

@property (nonatomic,strong)id<MySegementedControlDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray nameArray:(NSArray *)nameArray selectedIndex:(NSInteger)selectedIndex;

@end



