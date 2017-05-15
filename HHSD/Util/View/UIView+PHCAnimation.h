//
//  UIView+PHCAnimation.h
//  PHGif
//
//  Created by Phil Cai on 14/12/3.
//  Copyright (c) 2014年 PhilCai. All rights reserved.
//
/**
 *
 *
 *  @param FadeAnimation 使View 向上移动，渐变消失
 *
 *  用法：[aView fade:PHCAnimationDirectionRIGHT];
 */
#import <UIKit/UIKit.h>
typedef enum{
    PHCAnimationDirectionUP,
    PHCAnimationDirectionDOWN,
    PHCAnimationDirectionLEFT,
    PHCAnimationDirectionRIGHT,
}PHCAnimationDirection;

@interface UIView (PHCAnimation)
-(void)fade:(PHCAnimationDirection)PHCAnimationDirectionOption;
-(void)fade:(PHCAnimationDirection)PHCAnimationDirectionOption distantce:(CGFloat)distance;
@end
