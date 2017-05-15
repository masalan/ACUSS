//
//  UIView+PHCAnimation.m
//  PHGif
//
//  Created by Phil Cai on 14/12/3.
//  Copyright (c) 2014年 PhilCai. All rights reserved.
//

#import "UIView+PHCAnimation.h"

@implementation UIView (PHCAnimation)
-(void)fade:(PHCAnimationDirection)PHCAnimationDirectionOption{
    UIView *snapShot = [self snapshotViewAfterScreenUpdates:NO];
    if (!self.superview) {
        return;
    }
    [self.superview  addSubview:snapShot];
    CGRect frame = self.frame;
    snapShot.frame = frame;
    __block CGRect finalFrame = CGRectZero;
    [UIView animateWithDuration:1.0 animations:^{
        switch (PHCAnimationDirectionOption) {
            case PHCAnimationDirectionUP:
            {
                finalFrame = CGRectMake(frame.origin.x, snapShot.frame.origin.y-120, frame.size.width, frame.size.height);
            }
                break;
            case PHCAnimationDirectionDOWN:
            {
                finalFrame = CGRectMake(frame.origin.x, snapShot.frame.origin.y+120, frame.size.width, frame.size.height);
            }
                break;
            case PHCAnimationDirectionLEFT:
            {
                finalFrame = CGRectMake(frame.origin.x-120, snapShot.frame.origin.y, frame.size.width, frame.size.height);
            }
                break;
            case PHCAnimationDirectionRIGHT:
            {
                finalFrame = CGRectMake(frame.origin.x+120, snapShot.frame.origin.y, frame.size.width, frame.size.height);
            }
                break;
            default:{
                finalFrame = CGRectMake(frame.origin.x, snapShot.frame.origin.y-120, frame.size.width, frame.size.height);
            }
                break;
        }
        snapShot.frame = finalFrame;
        snapShot.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [snapShot removeFromSuperview];
    }];
}



-(void)fade:(PHCAnimationDirection)PHCAnimationDirectionOption distantce:(CGFloat)distance{
    UIView *snapShot = [self snapshotViewAfterScreenUpdates:NO];
    if (!self.superview) {
        return;
    }
    [self.superview  addSubview:snapShot];
    CGRect frame = self.frame;
    snapShot.frame = frame;
    __block CGRect finalFrame = CGRectZero;
    [UIView animateWithDuration:1.0 animations:^{
        switch (PHCAnimationDirectionOption) {
            case PHCAnimationDirectionUP:
            {
                finalFrame = CGRectMake(frame.origin.x, snapShot.frame.origin.y-distance, frame.size.width, frame.size.height);
            }
                break;
            case PHCAnimationDirectionDOWN:
            {
                finalFrame = CGRectMake(frame.origin.x, snapShot.frame.origin.y+distance, frame.size.width, frame.size.height);
            }
                break;
            case PHCAnimationDirectionLEFT:
            {
                finalFrame = CGRectMake(frame.origin.x-distance, snapShot.frame.origin.y, frame.size.width, frame.size.height);
            }
                break;
            case PHCAnimationDirectionRIGHT:
            {
                finalFrame = CGRectMake(frame.origin.x+distance, snapShot.frame.origin.y, frame.size.width, frame.size.height);
            }
                break;
            default:{
                finalFrame = CGRectMake(frame.origin.x, snapShot.frame.origin.y-distance, frame.size.width, frame.size.height);
            }
                break;
        }
        snapShot.frame = finalFrame;
        snapShot.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [snapShot removeFromSuperview];
    }];

}
@end
