//
//  NetWork+Animation.m
//  HHSD
//
//  Created by 汪达 on 15/10/9.
//  Copyright © 2015年 汪达. All rights reserved.
//

#import "NetWork+Animation.h"
#import <objc/runtime.h>
static const void *HttpRequestAnimation = &HttpRequestAnimation;

@implementation NetWork (Animation)
- (MONActivityIndicatorView *)ANIMATION
{
    return objc_getAssociatedObject(self, HttpRequestAnimation);
}
- (void)setANIMATION:(MONActivityIndicatorView *)ANIMATION{
    objc_setAssociatedObject(self, HttpRequestAnimation, ANIMATION, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)showAnimation
{
    
    UIView *windowView = [[UIApplication sharedApplication].delegate window];
    windowView.userInteractionEnabled = NO;
    MONActivityIndicatorView *indicatorView ;
    if(![self ANIMATION])
    {
        indicatorView= [[MONActivityIndicatorView alloc] init];
    }else
    {
        indicatorView = [self ANIMATION];
    }
    indicatorView.numberOfCircles = 5;
    indicatorView.radius = 10;
    indicatorView.internalSpacing = 5;
    indicatorView.center = windowView.center;
    indicatorView.centerX = SCREEN_WIDTH/2.0 - 50;
    [indicatorView startAnimating];
    indicatorView.backgroundColor = KTHEME_COLOR;
    [windowView addSubview:indicatorView];
    
    [self setANIMATION:indicatorView];
}
- (void)hiddenAnimation
{
    UIView *windowView = [[UIApplication sharedApplication].delegate window];
    windowView.userInteractionEnabled = YES;
    [[self ANIMATION] stopAnimating];
}
@end
