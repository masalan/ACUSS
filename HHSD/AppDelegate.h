//
//  AppDelegate.h
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 mas. All rights reserved.
//

#import "WDTabBarViewController.h"
#import <UserNotifications/UserNotifications.h>


#import <linkedin-sdk/LISDK.h>
#import <Google/SignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate,GIDSignInDelegate>

//支付类型
typedef NS_ENUM(NSUInteger, PayType) {
    PayTypeWXServiceFee,
    PayTypeZFBServiceFee,
    PayTypeWXShopping,
    PayTypeZFBShopping,
    PayTypeNone,
};
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *strDeviceToken;
@property (nonatomic, strong) UINavigationController *windowController;
@property (nonatomic,assign)PayType payType;

@property (nonatomic,strong ) WDTabBarViewController         *rootViewController;

@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *devicePlatform;
@property (nonatomic, strong) NSString *deviceID;




@property (nonatomic, copy  ) NSString            *cityName;
@property (nonatomic, copy  ) NSString            *cityID;

@end

