//
//  BaseViewController.m
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 mas. All rights reserved.
//


#import "BaseViewController.h"
#import "WDTabBarViewController.h"
//改为0就取消手势返回
#define GestureBackEnabled 1
@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController
- (instancetype)init
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sess_id = [[NSUserDefaults standardUserDefaults] objectForKey:KSESSION_ID];
    self.view.backgroundColor = KTHEME_COLOR;
    [self applyNormalNavBar];
#if GestureBackEnabled
    BaseViewController*  weakSelf = self;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    // if (self.interfaceOrientation != UIInterfaceOrientationPortrait && !([self supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeLeft)) {
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        [self forceChangeToOrientation:UIInterfaceOrientationPortrait];
    }
    
#endif
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - Orientations
- (BOOL)shouldAutorotate{
    return [UIApplication sharedApplication].statusBarOrientation;
    //  return UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
    
    
    //UIInterfaceOrientation
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    //return UIInterfaceOrientationPortrait;
    return UIInterfaceOrientationUnknown;  // Allow Rotation
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;  // Allow Rotation
    //return UIInterfaceOrientationMaskPortrait;
    
}

- (void)forceChangeToOrientation:(UIInterfaceOrientation)interfaceOrientation{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:interfaceOrientation] forKey:@"orientation"];
}
-(void)applyNormalNavBar
{
    //navigationbar set policy
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:KCOLOR_WHITE}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:KCOLOR_Black_343638];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageWithColor:KCOLOR_Black_343638 size:CGSizeMake(SCREEN_WIDTH, 1)]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
    
}
- (void)leftBackBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
+ (UIViewController *)presentingVC
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[WDTabBarViewController class]]) {
        result = [(WDTabBarViewController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}


+ (void)presentVC:(UIViewController *)viewController
{
    if (!viewController) {
        return;
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"close" style:UIBarButtonItemStylePlain
                                                                                      target:viewController action:@selector(dismissModalViewControllerAnimated:)];
    [[self presentingVC] presentViewController:nav animated:YES completion:nil];
}

#pragma mark
#pragma mark baseBackView
- (UIView *)baseBackView
{
    if(!_baseBackView)
    {
        _baseBackView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
                                    backgroundColor:KCOLOR_GRAY_f5f5f5];
        if(!_backTitleLabel)
        {
            _backTitleLabel = [UILabel createLabelWithFrame:CGRectMake(0, _baseBackView.height / 2, SCREEN_WIDTH, 30)
                                            backgroundColor:KCOLOR_CLEAR
                                                  textColor:KCOLOR_GRAY_999999
                                                       font:KSYSTEM_FONT_(18)
                                              textalignment:NSTextAlignmentCenter
                                                       text:nil];
            _backTitleLabel.centerY = _baseBackView.height/2 - 50;
            _baseBackView.hidden = YES;
            [_baseBackView addSubview:_backTitleLabel];
        }
    }
    return _baseBackView;
}
@end
