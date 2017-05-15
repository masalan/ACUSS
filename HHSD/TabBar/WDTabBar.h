//
//  WDTabBar.h
//  HHSD
//
//  Created by Serge Alain on 16/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDTabBar;

@protocol WDTabBarDelegate <NSObject>


- (void) tabBar:(WDTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

@interface WDTabBar : UIView
@property(nonatomic,weak) id<WDTabBarDelegate> delegate;
@end
