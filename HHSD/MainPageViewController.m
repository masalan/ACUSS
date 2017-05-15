//
//  MainPageViewController.m
//  HHSD
//
//  Created by alain serge on 4/28/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MainPageViewController.h"



#import "LoginViewController.h"
#import "PopMenu.h"
#import "AppDelegate.h"
#import <linkedin-sdk/LISDK.h>
#import <TwitterKit/TwitterKit.h>
#import "LinkedInHelper.h"


#import "InstagramLoginViewController.h"
#import "FKAuthViewController.h"


#import "SearchListViewController.h"
#import "SearchListStudentViewController.h"
#import "LoginViewController.h"
#import "WDTabBarViewController.h"
#import "AppDelegate.h"
#import "SignupViewController.h"

@interface MainPageViewController ()
@property (nonatomic, strong) PopMenu *popMenu;
@property (nonatomic,strong) NSUserDefaults * userDefaults;
@property (nonatomic, retain) FKFlickrNetworkOperation *todaysInterestingOp;
@property (nonatomic, retain) FKFlickrNetworkOperation *myPhotostreamOp;
@property (nonatomic, retain) FKDUNetworkOperation *completeAuthOp;
@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;
@property (nonatomic, retain) FKImageUploadNetworkOperation *uploadOp;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, strong) Mobile_Config *conig_app;


@property (nonatomic, assign) NSUInteger topSelectedTag;
@property (nonatomic, assign) NSString *socialLoginTag,*sess_ID,*S_ID,*G_ID,*L_ID,*email,*gender,*last_name,*first_name,*name,*picture,*phone,*location,*social_type;
@property (nonatomic, assign) NSString *googleIsLogin,*facebookIsLogin,*twitterIsLogin,*instagramIsLogin,*linkedlnIsLogin,*yahooIsLogin;
@property (nonatomic, assign) NSMutableArray *profileUser;

@end

@implementation MainPageViewController


-(instancetype)init
{
    self =[super init];
    if (self) {
        _topSelectedTag = 1;
        _socialLoginTag = @"Facebook";
        _googleIsLogin      = 0;
        _facebookIsLogin    = 0;
        _twitterIsLogin     = 0;
        _instagramIsLogin   = 0;
        _linkedlnIsLogin    = 0;
        _yahooIsLogin       = 0;
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userDefaults=[NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLocating:) name:@"ForceUpdateLocation" object:nil]; // don't forget the ":"
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticateCallback:) name:@"UserAuthCallbackNotification" object:nil];
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    self.view.backgroundColor = KTHEME_COLOR;
    [self.navigationController.navigationBar setHidden:YES];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageWithColor:KTHEME_COLOR size:CGSizeMake(SCREEN_WIDTH, 1)]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [navigationBar setShadowImage:[UIImage new]];
    
    [self getAllData];
    
}


- (void) dealloc {
    [self.todaysInterestingOp cancel];
    [self.myPhotostreamOp cancel];
}
- (void) viewWillDisappear:(BOOL)animated {
    //Cancel any operations when you leave views
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [self.todaysInterestingOp cancel];
    [self.myPhotostreamOp cancel];
    [self.completeAuthOp cancel];
    [self.checkAuthOp cancel];
    [self.uploadOp cancel];
    [self popMenu];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}






#pragma mark - Auth

- (void) userAuthenticateCallback:(NSNotification *)notification {
    NSURL *callbackURL = notification.object;
    self.completeAuthOp = [[FlickrKit sharedFlickrKit] completeAuthWithURL:callbackURL completion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
        NSLog(@"User id %@,User name %@",userId,userName);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self userLoggedIn:userName userID:userId];
            } else {
                [self showingAlert:@"Error" :error.localizedDescription];
                
                
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) userLoggedIn:(NSString *)username userID:(NSString *)userID {
    self.userID = userID;
    [self showAlertForLoggedIn:username];
    [_userDefaults setObject:username forKey:@"flickerLogin"];
    [_userDefaults synchronize];
}

- (void) userLoggedOut {
}


- (void)startLocating:(NSNotification *)notification {
    
    NSDictionary *dict = [notification userInfo];

    NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
    desc =[[NSMutableDictionary alloc] initWithDictionary:dict];
    [self showAlertForLoggedIn:desc];
 
}



-(void)facebookLogin {
    
    __block  NSMutableDictionary *fbResultData;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         [SVProgressHUD showWithStatus:@"Login..."];

         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
             [[FBSDKLoginManager new] logOut];
         } else {
             NSLog(@"Logged in OK");
             [SVProgressHUD dismiss];

             if ([FBSDKAccessToken currentAccessToken])
             {
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,name,age_range,birthday,devices,email,gender,last_name,family,friends,location,picture" parameters:nil]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                          
                          NSString * accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
                          NSLog(@"fetched user:%@ ,%@", result,accessToken);
                          
                          fbResultData =[[NSMutableDictionary alloc]init];
                          
                          if ([result objectForKey:@"email"]) {
                              [fbResultData setObject:[result objectForKey:@"email"] forKey:@"email"];
                          }
                          if ([result objectForKey:@"gender"]) {
                              [fbResultData setObject:[result objectForKey:@"gender"] forKey:@"gender"];
                          }
                          if ([result objectForKey:@"name"]) {
                              NSArray *arrName;
                              arrName=[[result objectForKey:@"name"] componentsSeparatedByString:@" "];
                              
                              [fbResultData setObject:[arrName objectAtIndex:0] forKey:@"name"];
                          }
                          if ([result objectForKey:@"last_name"]) {
                              [fbResultData setObject:[result objectForKey:@"last_name"] forKey:@"last_name"];
                          }
                          if ([result objectForKey:@"id"]) {
                              [fbResultData setObject:[result objectForKey:@"id"] forKey:@"id"];
                          }
                          
                          FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                                        initWithGraphPath:[NSString stringWithFormat:@"me/picture?type=large&redirect=false"]
                                                        parameters:nil
                                                        HTTPMethod:@"GET"];
                          [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                                id result,
                                                                NSError *error) {
                              if (!error){
                                  
                                  if ([[result objectForKey:@"data"] objectForKey:@"url"]) {
                                      [fbResultData setObject:[[result objectForKey:@"data"] objectForKey:@"url"] forKey:@"picture"];
                                  }
                                  
                                  //You get all detail here in fbResultData
                                  NSLog(@"Final data of FB login********%@",fbResultData);
                                  
                                  [_userDefaults setObject:fbResultData forKey:@"facebookLogin"];
                                  
                                  [_userDefaults synchronize];
                                  
                                  [SVProgressHUD dismiss];
                                  [self showAlertForLoggedIn:fbResultData];
                                  
                              } }];
                      }
                      else {
                          NSLog(@"result:----------> %@",[error description]);
                          //                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error description] delegate:nil cancelButtonTitle:NSLocalizedString(@"DISMISS", nil) otherButtonTitle:nil];
                          // [alert showInView:self.view.window];
                         // [self showAlertForLoggedIn:[error description]];
                      }
                  }];
             }
             else{
                 [[FBSDKLoginManager new] logOut];
                 //                     [_customFaceBookButton setImage:[UIImage imageNamed:@"fb_connected"] forState:UIControlStateNormal];
             }
         }
     }];
}




-(void)fbLogin {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    [login logInWithReadPermissions: @[@"public_profile"] fromViewController:self  handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
            [login logOut];
            
        } else {
            NSLog(@"Logged in");
            [self GetData];
        }
    }];
}

 
- (void)GetData {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSString * accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, first_name, picture.type(large) ,last_name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 //NSDictionary *Result = result;
                 [_userDefaults setObject:[result objectForKey:@"name"] forKey:@"facebookLogin"];
                 [_userDefaults synchronize];
                // self.facebookLogoutButtonInstance.enabled=YES;
                 [self showAlertForLoggedIn:[result objectForKey:@"name"]];
                 NSDictionary *params = [NSMutableDictionary dictionaryWithObject:accessToken forKey:@"access_token"];
                 NSLog(@"Params %@ ",params);
                 
             } else {
                 NSLog(@"Error %@",[error description]);
             }
         }];
    } }

-(void)TwitterLogin{
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            
           // NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
          //  desc =[[NSMutableDictionary alloc] initWithDictionary:session];
            
            
            NSLog(@"signed in as %@", [session userName]);
            [self showAlertForLoggedIn:[session userName]];
            [_userDefaults setObject:[session userName] forKey:@"twitterLogin"];
            [_userDefaults synchronize];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
    
}




-(void)linkedInLogin
{
    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    // If user has already connected via linkedin in and access token is still valid then
    // No need to fetch authorizationCode and then accessToken again!
    if (linkedIn.isValidToken) {
        [SVProgressHUD showWithStatus:@"Login..."];

        linkedIn.customSubPermissions = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@",Id,email_address, first_name, last_name,phone_numbers,date_of_birth,location_name,picture_url];
        // So Fetch member info by elderyly access token
        
        [linkedIn autoFetchUserInfoWithSuccess:^(NSDictionary *userInfo) {
            // Whole User Info
            
            NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
            desc =[[NSMutableDictionary alloc] initWithDictionary:userInfo];
            [self showAlertForLoggedIn:desc];
            [SVProgressHUD dismiss];
        } failUserInfo:^(NSError *error) {
            NSLog(@"error : %@", error.userInfo.description);
        }];
    } else {
        linkedIn.cancelButtonText = @"Close"; // Or any other language But Default is Close
        NSArray *permissions = @[@(BasicProfile),
                                 @(EmailAddress),
                                 @(Share),
                                 @(CompanyAdmin)];
        
        linkedIn.showActivityIndicator = YES;
        ///#warning - Your LinkedIn App ClientId - ClientSecret - RedirectUrl - And state
        [linkedIn requestMeWithSenderViewController:self
                                           clientId:@"8115cxe5zwk8ey"
                                       clientSecret:@"5E5usdpQsK82ElIA"
                                        redirectUrl:@"https://com.appcoda.linkedin.oauth/oauth"
                                        permissions:permissions
                                              state:@"linkedin\(Int(NSDate().timeIntervalSince1970))"
                                    successUserInfo:^(NSDictionary *userInfo) {
                                        
                                        /// self.linkedInLogoutButtonInstance.hidden = !linkedIn.isValidToken;
                                        [SVProgressHUD showWithStatus:@"Login..."];
                                        
                                        NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
                                        desc =[[NSMutableDictionary alloc] initWithDictionary:userInfo];
                                        [self showAlertForLoggedIn:desc];
                                        NSLog(@"mon profile Bas ------------------------------>%@",desc);
                                        
                                        // Whole User Info
                                        NSLog(@"user Info : %@", userInfo);
                                        // You can also fetch user's those informations like below
                                        NSLog(@"job title : %@",     [LinkedInHelper sharedInstance].title);
                                        NSLog(@"company Name : %@",  [LinkedInHelper sharedInstance].companyName);
                                        NSLog(@"email address : %@", [LinkedInHelper sharedInstance].emailAddress);
                                        NSLog(@"Photo Url : %@",     [LinkedInHelper sharedInstance].photo);
                                        NSLog(@"Industry : %@",      [LinkedInHelper sharedInstance].industry);
                                    }
                                  failUserInfoBlock:^(NSError *error) {
                                      NSLog(@"error  ------------------------------> %@", error.userInfo.description);
                                       [SVProgressHUD dismiss];
                                  }
         ];
    }
}


-(void)googlePlusLogin {
    [[GIDSignIn sharedInstance] signIn];
}


-(void)showAlertForLoggedIn:(NSMutableDictionary *)dataToshow {
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Successfully Logged In" message:nil  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action=[UIAlertAction actionWithTitle:@"Thanks" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSString stringWithFormat:@"%@",_socialLoginTag] forKey:@"social_type"];
        NSMutableString *string = [NSMutableString stringWithString:urlHeader];
        
        
        if (_topSelectedTag == 1)  // linkedln
        {
            NSLog(@"Linkedln ID------------------------------>%@",self.L_ID);
            _social_type =@"Linkedln Login";
            _L_ID = [NSString stringWithFormat:@"%@",dataToshow[@"id"]];
            _email = [NSString stringWithFormat:@"%@",dataToshow[@"emailAddress"]];
            _last_name = [NSString stringWithFormat:@"%@",dataToshow[@"lastName"]];
            _first_name = [NSString stringWithFormat:@"%@ ",dataToshow[@"firstName"]];
            _name = [NSString stringWithFormat:@"%@ %@",dataToshow[@"firstName"],dataToshow[@"lastName"]];  // realname
            _picture = [NSString stringWithFormat:@"%@",dataToshow[@"pictureUrl"]];
            
            kSetDict(self.L_ID, @"L_ID");
            kSetDict(self.email, @"email");
            kSetDict(self.name, @"realname");
            kSetDict(self.first_name, @"username");
            kSetDict(self.picture, @"head_image");
            kSetDict(self.social_type, @"social_type");
            
            
            [string appendString:@"Social/linkdedln"];
            [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                if([[responseObject objectForKey:@"code"] isEqual:@200])
                {
                    
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"sess_id"] forKey:KSESSION_ID];
                    _sess_ID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"sess_id"]];
                    [[NSUserDefaults standardUserDefaults] setObject:dict[@"userid"] forKey:KUSER_ID];
                    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    delegate.windowController = nil;
                    WDTabBarViewController *tabbar = [[WDTabBarViewController alloc] init];
                    delegate.windowController = [[UINavigationController alloc] initWithRootViewController:tabbar];
                    delegate.windowController.navigationBarHidden = YES;
                    delegate.window.rootViewController = delegate.windowController;
                    
                }
                if([[responseObject objectForKey:@"code"] isEqual:@500])
                {
                }
            } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                
            }];
            
            
        }
        else if (_topSelectedTag == 2)  // Google
        {

            _social_type =@"Google Login";
            _G_ID = [NSString stringWithFormat:@"%@",dataToshow[@"userID"]];
            _email = [NSString stringWithFormat:@"%@",dataToshow[@"email"]];
            _last_name = [NSString stringWithFormat:@"%@ ",dataToshow[@"familyName"]];
            _name = [NSString stringWithFormat:@"%@",dataToshow[@"name"]];

            kSetDict(self.G_ID, @"G_ID");
            kSetDict(self.email, @"email");
            kSetDict(self.name, @"realname");
            kSetDict(self.last_name, @"username");
            kSetDict(self.social_type, @"social_type");
            
            NSLog(@"google ID------------------------------>%@",self.G_ID);


            NSLog(@"Gogle ID :------>%@ \n email:------>%@ \n name :------>%@ \n  last_name:------>%@ \n social_type :------>%@ \n  ",self.G_ID,self.email,self.name,self.last_name,self.social_type);
            
            [string appendString:@"Social/google"];
            [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                if([[responseObject objectForKey:@"code"] isEqual:@200])
                {
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"sess_id"] forKey:KSESSION_ID];
                    _sess_ID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"sess_id"]];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:self.last_name forKey:KUSERNAME];
                    [[NSUserDefaults standardUserDefaults] setObject:dict[@"userid"] forKey:KUSER_ID];
                    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    delegate.windowController = nil;
                    WDTabBarViewController *tabbar = [[WDTabBarViewController alloc] init];
                    delegate.windowController = [[UINavigationController alloc] initWithRootViewController:tabbar];
                    delegate.windowController.navigationBarHidden = YES;
                    delegate.window.rootViewController = delegate.windowController;
                    
                }
                if([[responseObject objectForKey:@"code"] isEqual:@500])
                {
                }
            } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                
            }];
            
            
        }
        else if (_topSelectedTag == 3)  //Facebook
        {
            NSLog(@"facebook ID------------------------------>%@",self.S_ID);
            _social_type =@"Facebook Login";
            _S_ID = [NSString stringWithFormat:@"%@",dataToshow[@"id"]];
            _email = [NSString stringWithFormat:@"%@",dataToshow[@"email"]];
            _gender = [NSString stringWithFormat:@"%@",dataToshow[@"gender"]];
            _last_name = [NSString stringWithFormat:@"%@ %@",dataToshow[@"last_name"],dataToshow[@"name"]];
            _name = [NSString stringWithFormat:@"%@",dataToshow[@"name"]];
            _picture = [NSString stringWithFormat:@"%@",dataToshow[@"picture"]];
            kSetDict(self.S_ID, @"S_ID");
            kSetDict(self.email, @"email");
            kSetDict(self.gender, @"sex");
            kSetDict(self.last_name, @"realname");
            kSetDict(self.name, @"username");
            kSetDict(self.picture, @"head_image");
            kSetDict(self.social_type, @"social_type");

            
            [string appendString:@"Social/index"];
            [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                if([[responseObject objectForKey:@"code"] isEqual:@200])
                {
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"sess_id"] forKey:KSESSION_ID];
                    _sess_ID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"sess_id"]];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:self.name forKey:KUSERNAME];
                    [[NSUserDefaults standardUserDefaults] setObject:dict[@"userid"] forKey:KUSER_ID];
                    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    delegate.windowController = nil;
                    WDTabBarViewController *tabbar = [[WDTabBarViewController alloc] init];
                    delegate.windowController = [[UINavigationController alloc] initWithRootViewController:tabbar];
                    delegate.windowController.navigationBarHidden = YES;
                    delegate.window.rootViewController = delegate.windowController;
                    
                }
                if([[responseObject objectForKey:@"code"] isEqual:@500])
                {
                }
            } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                
            }];
            
            
        }
        else if (_topSelectedTag == 4)  // Twitter
        {
            NSLog(@" TwitterLogin----------------------- 4 ");
            [self presentViewController:alert animated:YES completion:nil];


        }
        else if (_topSelectedTag == 5)  // Instagram
        {
            NSLog(@" instagramLogin----------------------- 5 ");
            [self presentViewController:alert animated:YES completion:nil];


        }
        else if (_topSelectedTag == 6)  // yahoo
        {
            NSLog(@" yahoo Login----------------------- 6 ");
            [self presentViewController:alert animated:YES completion:nil];

 
        }
        
        
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No, thanks"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        [alert addAction:noButton];
        
    });
    
    
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"logout");
}

- (IBAction)loginButtonClick:(id)sender {
    
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    if ([_linkedlnIsLogin isEqualToString:@"0"])
    {
        // Not login
    }
    else if ([_linkedlnIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"LinkedIn" iconName:@"linkedln" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    
    
    if ([_googleIsLogin isEqualToString:@"0"])
    {
        // Not login
    }
    else if ([_googleIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Googleplus" iconName:@"google" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    
    
    if ([_facebookIsLogin isEqualToString:@"0"])
    {
        // Not login
    }
    else if ([_facebookIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Facebook" iconName:@"facebook" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    
    
    if ([_twitterIsLogin isEqualToString:@"0"])
    {
        // Not login
    }
    else if ([_twitterIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Twitter" iconName:@"twitter" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    
    if ([_yahooIsLogin isEqualToString:@"0"])
    {
        // Not login
    }
    else if ([_yahooIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Yahoo" iconName:@"yahoo" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    
    
    if ([_instagramIsLogin isEqualToString:@"0"])
    {
        // Not login
    }
    else if ([_instagramIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Instagram" iconName:@"Instagram" glowColor:KCOLOR_CLEAR];
        [items addObject:menuItem];
    }

    
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
        _popMenu.perRowItemCount = 3;
        _popMenu.backgroundColor = KTHEME_COLOR;
    }
    if (_popMenu.isShowed) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        NSLog(@"selectedItem-------------> %@",selectedItem.title);
        if ([selectedItem.title isEqualToString:@"LinkedIn"]) {
            _topSelectedTag = 1;
             _socialLoginTag = @"linkedln";
            [weakSelf linkedInLogin];  // Ok
            
        }
        else if ([selectedItem.title isEqualToString:@"Googleplus"])
        {
            _topSelectedTag = 2;
             _socialLoginTag = @"google";
            [weakSelf googlePlusLogin];
        }
        else if ([selectedItem.title isEqualToString:@"Facebook"])
        {
            _topSelectedTag = 3;
            _socialLoginTag = @"facebook";
            [weakSelf facebookLogin];  // OK
        }
        
        
        else if ([selectedItem.title isEqualToString:@"Twitter"])
        {
            _topSelectedTag = 4;
             _socialLoginTag = @"twitter";
            [weakSelf TwitterLogin];
        }
        else if ([selectedItem.title isEqualToString:@"Instagram"])
        {
            _topSelectedTag = 5;
             _socialLoginTag = @"instagram";
            [weakSelf instagramLogin];
        }
        else if ([selectedItem.title isEqualToString:@"Yahoo"])
        {
            _topSelectedTag = 6;
             _socialLoginTag = @"yahoo";
            [weakSelf flickerLogin];
        }
        
    };
    
    [_popMenu showMenuAtView:self.view];
    
}

- (IBAction)userLogin:(id)sender {
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click login");
}

- (IBAction)userSignup:(id)sender {
    SignupViewController *vc = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click signup");
    
}

- (IBAction)studentSearch:(id)sender {
    SearchListStudentViewController *vc = [[SearchListStudentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click search student page");
}

- (IBAction)schoolSearch:(id)sender {
    
    SearchListViewController *vc = [[SearchListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click search school page");
}
-(void)flickerLogin{
    self.checkAuthOp = [[FlickrKit sharedFlickrKit] checkAuthorizationOnCompletion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self userLoggedIn:userName userID:userId];
            } else {
                [self userLoggedOut];
                FKAuthViewController *vc = [[FKAuthViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        });
    }];
    
    
}
-(void)instagramLogin{
    InstagramLoginViewController *vc = [[InstagramLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}





-(void)showingAlert:(NSString*)title :(NSString*)message{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
                UIAlertAction* noButton = [UIAlertAction
                                           actionWithTitle:@"No, thanks"
                                          style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                              //Handle no, thanks button
                                          }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@" showingAlert  login----------------------------> 2");
        [self presentViewController:alert animated:YES completion:nil];
    });
    
}






#pragma mark
#pragma mark netWork
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"manager/config"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _conig_app = [Mobile_Config objectWithKeyValues:responseObject[@"data"]];
            
            // Statement social login
            _googleIsLogin      = _conig_app.google;
            _facebookIsLogin    = _conig_app.facebook;
            _twitterIsLogin     = _conig_app.twitter;
            _instagramIsLogin   = _conig_app.instagram;
            _linkedlnIsLogin    = _conig_app.linkedln;
            _yahooIsLogin       = _conig_app.yahoo;
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
          //  [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}












@end



