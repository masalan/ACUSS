//
//  BaseViewController+MBHUD.h
//  YWY2
//
//  Created by 汪达 on 15/7/21.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (MBHUD)

- (void)showMBHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideMBHud;
- (void)showMB;

- (void)showMBHint:(NSString *)hint;
- (void)showSuccessMBHint:(NSString *)hint;
- (void)showSuccessMBHint:(NSString *)hint afterDelay:(NSTimeInterval)delay;
- (void)showFailMBHint:(NSString *)hint;
- (void)showFailMBHint:(NSString *)hint afterDelay:(NSTimeInterval)delay;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showMBHint:(NSString *)hint yOffset:(float)yOffset;

@end
