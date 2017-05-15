//
//  BaseNavController.m
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 mas. All rights reserved.
//

#import "BaseNavController.h"

@implementation BaseNavController
- (instancetype)init
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self applyNormalNavBar];
}
-(void)applyNormalNavBar
{
    //Setup navigationbar policy
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
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    if([viewController isEqual:self.viewControllers[0]])
    {
        viewController.hidesBottomBarWhenPushed = NO;
    }else
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
}
@end
