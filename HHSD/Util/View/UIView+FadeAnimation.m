//
//  UIView+FadeAnimation.m
//  PHGif
//
//  Created by Phil Cai on 14/12/3.
//  Copyright (c) 2014年 PhilCai. All rights reserved.
//

#import "UIView+FadeAnimation.h"

@implementation UIView (FadeAnimation)
-(void)fade{
   UIView *snapShot = [self snapshotViewAfterScreenUpdates:NO];
    if (!self.superview) {
        return;
    }
    [self.superview  addSubview:snapShot];
    CGRect frame = self.frame;
    snapShot.frame = frame;
    [UIView animateWithDuration:1.0 animations:^{
        snapShot.frame = CGRectMake(frame.origin.x, snapShot.frame.origin.y-100, frame.size.width, frame.size.height);
        snapShot.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [snapShot removeFromSuperview];
    }];
}
@end
