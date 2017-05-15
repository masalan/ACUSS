//
//  WDTabBar.m
//  HHSD
//
//  Created by Serge Alain on 16/08/16.
//  Copyright © 2016 mas. All rights reserved.
//
#import "WDTabBar.h"
#import "WDTabBarItem.h"

@interface WDTabBar ()
/**
 * Set the previously selected button
 */
@property (nonatomic, weak) WDTabBarItem *selectedBtn;
@end

@implementation WDTabBar

/**
 * In this method to write the control initialization thing, call the init method will call
 */
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
      if (!self)
      {
          return nil;
      }
    //Add a button
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4" ,nil];
    NSMutableArray *iconArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4" ,nil];
    
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat x = idx * self.bounds.size.width / titleArray.count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / titleArray.count;
        CGFloat height = self.bounds.size.height;
        CGRect  itemFrame = CGRectMake(x, y, width, height);
        
        WDTabBarItem *item = [[WDTabBarItem alloc] initWithFrame:itemFrame];
        item.iconLabel.text = [iconArray[idx] copy];
        item.nameLabel.text = [titleArray[idx] copy];
        item.tag = idx;
        [item addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (0 == idx) {
            [self clickBtn:item];
        }
        [self addSubview:item];
    }];
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                   backgroundColor:KCOLOR_GRAY_c9c9c9];
    [self addSubview:lineView];
    return self;
}

/**
 *  Customize TabBar button click event
 */
- (void)clickBtn:(WDTabBarItem *)button {
    //1.Set the previously selected button to unselected
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    
    // but for the view controller thing, should be handed to the controller to do
   // The best way to write, first determine whether the agent method is achieved
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }

    self.selectedBtn = button;
}  

@end
