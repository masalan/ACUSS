//
//  MyAdView.h
//  GLKiphone
//
//  Created by 刘锋婷 on 14-4-12.
//  Copyright (c) 2014年 刘锋婷. All rights reserved.
//

@protocol MyAdViewDelegate <NSObject>

-(void)myAdViewTappedAtIndex:(NSInteger )index;

@end

#import <UIKit/UIKit.h>
#import "Macros.h"

@interface MyAdView : UIView

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;
@property (nonatomic)NSInteger numberOfImages;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic, assign) UIViewContentMode imageViewContentMode;
@property (nonatomic,strong)id<MyAdViewDelegate> delegate;

-(void)drawAdViewWithNameArray:(NSArray *)nameArray urlArray:(NSArray *)urlArray animationDurtion:(NSTimeInterval)durition;
-(void)drawAdViewWithNameArray:(NSArray *)nameArray urlArray:(NSArray *)urlArray withAnimationDurtion:(NSTimeInterval) durition;
- (void)timerActins;
- (void)timeStart;
- (void)timeStop;

@end
