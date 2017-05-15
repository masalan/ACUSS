//
//  BaseViewController+MBHUD.m
//  YWY2
//
//  Created by 汪达 on 15/7/21.
//  Copyright (c) 2015年 wangda. All rights reserved.
//

#import "BaseViewController+MBHUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
static const void *MBHttpRequestHUDKey = &MBHttpRequestHUDKey;

@implementation BaseViewController (MBHUD)
- (MBProgressHUD *)MBHUD{
    return objc_getAssociatedObject(self, MBHttpRequestHUDKey);
}

- (void)setMBHUD:(MBProgressHUD *)MBHUD{
    objc_setAssociatedObject(self, MBHttpRequestHUDKey, MBHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showMBHudInView:(UIView *)view hint:(NSString *)hint{
    if(!view)
    {
        view = [[UIApplication sharedApplication].delegate window];
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setMBHUD:HUD];
    [HUD hide:YES afterDelay:8];
}
- (void)showMB
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
}
- (void)showMBWithString:(NSString *)hint afterDelay:(NSTimeInterval)delay
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
}
- (void)showMBHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
- (void)showSuccessMBHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
- (void)showSuccessMBHint:(NSString *)hint afterDelay:(NSTimeInterval)delay
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
}
- (void)showFailMBHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
- (void)showFailMBHint:(NSString *)hint afterDelay:(NSTimeInterval)delay
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
}

- (void)showMBHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
- (void)hideMBHud{
    [[self MBHUD] hide:YES];
}
@end
