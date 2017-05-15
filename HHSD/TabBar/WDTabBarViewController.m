//
//  WDTabBarViewController.m
//  HHSD
//
//  Created by Serge Alain on 16/08/16.
//  Copyright © 2016 mas. All rights reserved.
//

#import "WDTabBarViewController.h"
#import "BaseNavController.h"
#import "MainViewController.h"
#import "SearchListViewController.h"

#import "MainView_A.h"
#import "MainView_B.h"
#import "MainView_C.h"
#import "MainView_D.h"
#import "ViewByCityController.h"


#import "ecolesListViewController.h"




@interface WDTabBarViewController () <UITabBarControllerDelegate>
/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *vcArray;

@end

@implementation WDTabBarViewController
- (instancetype)init
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    self.vcArray = [NSMutableArray array];
    [self applyNormalNavBar];
//    [self tabBarVCInit];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title= @"";
    self.delegate = self;
    [self tabBarVCInit];

}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)applyNormalNavBar
{
    //Setting navigationbar
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:KCOLOR_WHITE}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:KCOLOR_Black_343638];
    [self.navigationController.navigationBar setTintColor:KCOLOR_Black_343638];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageWithColor:KCOLOR_Black_343638 size:CGSizeMake(SCREEN_WIDTH, 1)]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
    _leftBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBackBtn.backgroundColor = KCOLOR_RED;
    [_leftBackBtn setFrame:CGRectMake(-10, 2, 80, 28)];
    [_leftBackBtn setTitle:@"\U0000e625" forState:UIControlStateNormal];
    [_leftBackBtn setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal];
    _leftBackBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;
    _leftBackBtn.titleLabel.font = KICON_FONT_(20);
    //    [_leftBackBtn setImage:[UIImage imageNamed:@"System_Nav_Back_btn"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_leftBackBtn];
    _leftBackBtn.hidden = YES;
    self.navigationItem.leftBarButtonItem = leftButton;
}

#pragma mark
#pragma mark otherAction
- (void)tabBarVCInit
{
// MainView_A
    NSArray *vcStringArray = [NSArray arrayWithObjects:@"ecolesListViewController",@"MainView_B",@"ViewByCityController",@"MainView_D",nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"universities",@"students",@"cities",@"me",nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"universities",@"students",@"cities",@"me",nil];
    [self setTabBarWithVCArray:vcStringArray titleArray:titleArray imageArray:imageArray];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.title = viewController.title;
}

- (void)setTabBarWithVCArray:(NSArray *)VCarray titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray
{
    [VCarray enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *  stop) {
        BaseViewController  *vc = [[KCFS(obj) alloc] init];
        BaseNavController *naVC =  [[BaseNavController alloc] initWithRootViewController:vc];
        naVC.tabBarItem.selectedImage = [UIImage imageNamed:imageArray[idx]];
        naVC.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageArray[idx]]];
        naVC.tabBarItem.selectedImage = [[UIImage imageNamed:imageArray[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        naVC.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageArray[idx]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        naVC.tabBarItem.title = titleArray[idx];
        [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:KCOLOR_GREEN_6ad968} forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:KCOLOR_GRAY_999999} forState:UIControlStateNormal];
        [self.vcArray addObject:naVC];
    }];
    self.viewControllers = self.vcArray;
    UITabBar *tabBar = self.tabBar;
    [tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *  obj, NSUInteger idx, BOOL *  stop) {
        obj.title = titleArray[idx];
        
    }];
}
- (NSMutableArray *)vcArray
{
    if(!_vcArray)
    {
        _vcArray = [NSMutableArray array];
    }
    return _vcArray;
}


@end
