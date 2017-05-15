//
//  AppDelegate.m
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 mas. All rights reserved.
//

//https://github.com/noodlewerk/NWPusher  APN




#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "WDTabBarViewController.h"
#import "EAIntroView.h"
#import "EAIntroPage.h"

#import "TestFairy.h"
#import "FlickrKit.h"

#import "SCTwitter.h"
#import "MainPageViewController.h"


#define APPID @"1139438812"
#define APPSTORE_ID @"1139438812"  // educoMobile
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]


#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)




@interface AppDelegate ()<EAIntroDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    

    
    [Fabric with:@[[Twitter class]]];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    // https://www.flickr.com/auth-72157680948331111
    // https://www.flickr.com/services/apps/72157680948331111/
      NSString *apiKey = @"1418fc8fa5a6aae0561cd53ecdae85d0";
      NSString *secret = @"718dab0930164c5f";
    if (!apiKey) {
        NSLog(@"\n----------------------------------\nYou need to enter your own 'apiKey' and 'secret' in FKAppDelegate for the demo to run. \n\nYou can get these from your Flickr account settings.\n----------------------------------\n");
        exit(0);
    }
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:apiKey sharedSecret:secret];
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error Google services:----------------------------------> %@", configureError);
    [GIDSignIn sharedInstance].delegate = self;
    
    
    
    
    [self registerForRemoteNotification];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = KCOLOR_WHITE;
    [self.window makeKeyAndVisible];
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 0;
    
   if([[NSUserDefaults standardUserDefaults] objectForKey:KSESSION_ID])
    {
        self.windowController =  [[UINavigationController alloc] initWithRootViewController: [[WDTabBarViewController alloc] init]];
        self.windowController.navigationBarHidden = YES;
    }else
    {
       // self.windowController =  [[UINavigationController alloc] initWithRootViewController: [[fb alloc] init]];
        self.windowController =  [[UINavigationController alloc] initWithRootViewController: [[MainPageViewController alloc] init]];

    }
    
    self.window.rootViewController = self.windowController;
        [self loadFirstImgs]; // Start load that pages
        [self.window makeKeyAndVisible];
    
    
    return YES;
}


// facebook
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark - Remote Notification Delegate // <= iOS 9.x

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *strDevicetoken = [[NSString alloc]initWithFormat:@"%@",[[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
   // NSLog(@"Device Token = %@",strDevicetoken);
    self.strDeviceToken = strDevicetoken;
    
    [self sendGetuiDeviceToken];

   
    _deviceToken = [NSString stringWithFormat:@"%@",deviceToken];
    _devicePlatform = @"IOS";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendGetuiDeviceToken) name:@"huanxinNotice" object:nil];
    
    [USER_DEFAULTS setObject:_deviceToken forKey:@"device_token"];
    [USER_DEFAULTS synchronize];
    
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Push Notification Information : %@",userInfo);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@ = %@", NSStringFromSelector(_cmd), error);
    NSLog(@"Error = %@",error);
}

#pragma mark - UNUserNotificationCenter Delegate // >= iOS 10

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    NSLog(@"User Info notification = %@",notification.request.content.userInfo);
    
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    NSLog(@"User Info = %@",response.notification.request.content.userInfo);
    completionHandler();
}

#pragma mark - Class Methods

/**
 Notification Registration
 */
- (void)registerForRemoteNotification {
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}





- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}


-(void)sendGetuiDeviceToken
{
    DLog(@"Token Iphone");
    
    NSString *typeDevice;
    typeDevice = @"iOS";

    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.strDeviceToken, @"device_token");  // Ok
    kSetDict(typeDevice, @"device_type");  // Ok
    
    NSLog(@"DeviceToken-------------------------------------------.%@",self.strDeviceToken);
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"user/save_device_token"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            NSLog(@"save Token Ok");
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        //code
    }];
    
    
    
}


-(void)loadFirstImgs
{
    BOOL  isFirst = [self isFirstLoadAndShowIntro];
    sleep(1);
    [self introDidFinish:NO];
    
    if (isFirst) {
        //loading introduction page
        [self introDidFinish:YES];
        
        EAIntroPage *page1 = [EAIntroPage page];
        page1.title = @"";
        page1.desc = @"";
        page1.titleImage = [UIImage imageNamed:@""];
        
        EAIntroPage *page2 = [EAIntroPage page];
        page2.title = @"";
        page2.desc = @"";
        page2.titleImage = [UIImage imageNamed:@""];
        
        EAIntroPage *page3 = [EAIntroPage page];
        page3.title = @"";
        page3.desc = @"";
        page3.titleImage = [UIImage imageNamed:@""];
        
        EAIntroPage *page4 = [EAIntroPage page];
        page4.title = @"";
        page4.desc = @"";
        page4.titleImage = [UIImage imageNamed:@""];
        
        
        if (iPhone3) {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"A_0_iphone4s"
                                                             ofType:@"png"];
            page1.bgImage = [UIImage imageWithContentsOfFile:path];
            
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"A_1_iphone4s"
                                                              ofType:@"png"];
            page2.bgImage = [UIImage imageWithContentsOfFile:path2];
            
            NSString *path3 = [[NSBundle mainBundle] pathForResource:@"A_2_iphone4s"
                                                              ofType:@"png"];
            page3.bgImage = [UIImage imageWithContentsOfFile:path3];
            
            NSString *path4 = [[NSBundle mainBundle] pathForResource:@"A_0_iphone4s"
                                                              ofType:@"png"];
            page4.bgImage = [UIImage imageWithContentsOfFile:path4];
            
            
        }else if(iPhone4 || iPhone4s)
        {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"A_0_iphone4s"
                                                             ofType:@"png"];
            page1.bgImage = [UIImage imageWithContentsOfFile:path];
            
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"A_1_iphone4s"
                                                              ofType:@"png"];
            page2.bgImage = [UIImage imageWithContentsOfFile:path2];
            
            NSString *path3 = [[NSBundle mainBundle] pathForResource:@"A_2_iphone4s"
                                                              ofType:@"png"];
            page3.bgImage = [UIImage imageWithContentsOfFile:path3];
            
            NSString *path4 = [[NSBundle mainBundle] pathForResource:@"A_0_iphone4s"
                                                              ofType:@"png"];
            page4.bgImage = [UIImage imageWithContentsOfFile:path4];
            
            
            
        }else if(iPhone5 || iPhone5s)
        {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"B_0_iphone4s"
                                                             ofType:@"png"];
            page1.bgImage = [UIImage imageWithContentsOfFile:path];
            
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"B_1_iphone4s"
                                                              ofType:@"png"];
            page2.bgImage = [UIImage imageWithContentsOfFile:path2];
            
            NSString *path3 = [[NSBundle mainBundle] pathForResource:@"B_2_iphone4s"
                                                              ofType:@"png"];
            page3.bgImage = [UIImage imageWithContentsOfFile:path3];
            
            NSString *path4 = [[NSBundle mainBundle] pathForResource:@"B_3_iphone4s"
                                                              ofType:@"png"];
            page4.bgImage = [UIImage imageWithContentsOfFile:path4];
            
            
        }else if(iPhone6 || iPhone6s)
        {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"C_0_iphone6s"
                                                             ofType:@"png"];
            page1.bgImage = [UIImage imageWithContentsOfFile:path];
            
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"C_1_iphone6s"
                                                              ofType:@"png"];
            page2.bgImage = [UIImage imageWithContentsOfFile:path2];
            
            NSString *path3 = [[NSBundle mainBundle] pathForResource:@"C_2_iphone6s"
                                                              ofType:@"png"];
            page3.bgImage = [UIImage imageWithContentsOfFile:path3];
            
            NSString *path4 = [[NSBundle mainBundle] pathForResource:@"C_3_iphone6s"
                                                              ofType:@"png"];
            page4.bgImage = [UIImage imageWithContentsOfFile:path4];
            
            
            
        }else if(iPhone6sPlus)
        {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"D_0_iphone6splus"
                                                             ofType:@"png"];
            page1.bgImage = [UIImage imageWithContentsOfFile:path];
            
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page2.bgImage = [UIImage imageWithContentsOfFile:path2];
            
            NSString *path3 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page3.bgImage = [UIImage imageWithContentsOfFile:path3];
            
            NSString *path4 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page4.bgImage = [UIImage imageWithContentsOfFile:path4];
            
            
        }else if(iPhone6sPlus || iPhone7plus)
        {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"D_0_iphone6splus"
                                                             ofType:@"png"];
            page1.bgImage = [UIImage imageWithContentsOfFile:path];
            
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page2.bgImage = [UIImage imageWithContentsOfFile:path2];
            
            NSString *path3 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page3.bgImage = [UIImage imageWithContentsOfFile:path3];
            
            NSString *path4 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page4.bgImage = [UIImage imageWithContentsOfFile:path4];
            
            
        }else if(iPhone7)
        {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"D_0_iphone6splus"
                                                             ofType:@"png"];
            page1.bgImage = [UIImage imageWithContentsOfFile:path];
            
            NSString *path2 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page2.bgImage = [UIImage imageWithContentsOfFile:path2];
            
            NSString *path3 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page3.bgImage = [UIImage imageWithContentsOfFile:path3];
            
            NSString *path4 = [[NSBundle mainBundle] pathForResource:@"D_1_iphone6splus"
                                                              ofType:@"png"];
            page4.bgImage = [UIImage imageWithContentsOfFile:path4];
            
            
        }
        
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds
                                                       andPages:@[page1,page2,page3,page4]];
        
        intro.tag = 1;
        intro.pageControl.hidden = YES;
        

        [intro setDelegate:self];
        [intro showInView:self.window.rootViewController.view animateDuration:0.3];

    }
}


//Check if its last update
#define LAST_RUN_VERSION_KEY        @"last_run_version_of_application"
- (BOOL) isFirstLoadAndShowIntro{
    
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        
        [defaults synchronize];
        return YES;
        // App is being run for first time
    }
    else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        
        [defaults synchronize];
        return YES;        // App has been updated since last run
    }
    return NO;
}

- (void)introDidFinish:(BOOL)isHidden {
    [[UIApplication sharedApplication] setStatusBarHidden:isHidden];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    NSLog(@"URL in other Method %@",url);
    if ([[GIDSignIn sharedInstance] handleURL:url
                            sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                   annotation:options[UIApplicationOpenURLOptionsAnnotationKey]]){
        return YES;
    }
    else if ([[FBSDKApplicationDelegate sharedInstance]application:app openURL:url options:options]){
        return YES;
    }
    else if([@"integrations" isEqualToString:[url scheme]]) {
        // I don't recommend doing it like this, it's just a demo... I use an authentication
        // controller singleton object in my projects
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserAuthCallbackNotification" object:url userInfo:nil];
        return YES;
    }
    
    
    // If you handle other (non Twitter Kit) URLs elsewhere in your app, return YES. Otherwise
    return NO;
}



- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
   // NSLog(@"Gname-----------> %@",fullName);
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"googlePlusLogin"];
    [[NSUserDefaults standardUserDefaults] setObject:idToken forKey:@"googlePlusLogin"];
    [[NSUserDefaults standardUserDefaults] setObject:fullName forKey:@"googlePlusLogin"];
    [[NSUserDefaults standardUserDefaults] setObject:givenName forKey:@"googlePlusLogin"];
    [[NSUserDefaults standardUserDefaults] setObject:familyName forKey:@"googlePlusLogin"];
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"googlePlusLogin"];


    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
    
    
  
  
    NSString *values[5];
    values[0] = user.userID;
    values[1] = user.profile.name;
    values[2] = user.profile.givenName;
    values[3] = user.profile.familyName;
    values[4] = user.profile.email;
    
    NSString *keys[5];
    keys[0] = @"userID";
    keys[1] = @"name";
    keys[2] = @"givenName";
    keys[3] = @"familyName";
    keys[4] = @"email";
    NSDictionary *GoogleDatas =  [NSDictionary dictionaryWithObjects:values forKeys:keys count:5];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ForceUpdateLocation" object:self userInfo:GoogleDatas];

    
    
    // ...
}


- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}




@end
