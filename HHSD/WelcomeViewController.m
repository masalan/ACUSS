//
//  WelcomeViewController.m
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "WelcomeViewController.h"
#import "SearchListViewController.h"
#import "SearchListStudentViewController.h"
#import "LoginViewController.h"
#import "WDTabBarViewController.h"
#import "AppDelegate.h"
#import "SignupViewController.h"


#import "WDTabBarViewController.h"
#import "AppDelegate.h"
#import "Macros.h"


#import <linkedin-sdk/LISDK.h>
#import <TwitterKit/TwitterKit.h>
#import "LinkedInHelper.h"
#import "InstagramLoginViewController.h"
#import "FKAuthViewController.h"
#import "AppDelegate.h"

#import "SCTwitter.h"


#define SCAlert(title,msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW5 (SCREEN_WIDTH/5)-10
#define D 50

@interface WelcomeViewController ()
@property (nonatomic, retain) UIView *MainView,*userBtn,*socialLogin;
@property (nonatomic, retain) UIImageView *topImageView;
@property (nonatomic, retain) UIButton *loginBtn,*facebookBtn,*loginAction,*signupAction,*serchStudentsBtn,*serchSchoolsBtn;
@property (nonatomic, retain) UILabel *titleName;
@property (nonatomic, strong) UITextField *userNameTextField,*passWDTextField;
@property (nonatomic, retain) UIButton *facebookBtnLogin,*twitterBtnLogin,*linkedlnBtnLogin,*googleBtnLogin;


@property (nonatomic,strong) NSUserDefaults * userDefaults;
@property (nonatomic, retain) FKFlickrNetworkOperation *todaysInterestingOp;
@property (nonatomic, retain) FKFlickrNetworkOperation *myPhotostreamOp;
@property (nonatomic, retain) FKDUNetworkOperation *completeAuthOp;
@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;
@property (nonatomic, retain) FKImageUploadNetworkOperation *uploadOp;
@property (nonatomic, retain) NSString *userID,*sess_ID;



@property (nonatomic, strong) GIDSignInButton *btnGMLogin;
@property (nonatomic, strong) FBSDKLoginButton *btnFBLogin;

@property (nonatomic, assign) NSUInteger topSelectedTag;
@property (nonatomic, assign) NSString *socialLoginTag,*S_ID,*L_ID,*email,*gender,*last_name,*first_name,*name,*picture,*phone,*location;

@property (nonatomic, assign) NSMutableArray *profileUser;



@end

@implementation WelcomeViewController

-(instancetype)init
{
    self =[super init];
    if (self) {
        _topSelectedTag = 2;
        _socialLoginTag = @"Facebook";
    }
    return self;
}




-(void)googlePlusLogin{
    //[[GIDSignIn sharedInstance] signIn];
    
    [self.btnGMLogin sendActionsForControlEvents:UIControlEventTouchUpInside];

    // self.googlePlusLogoutButtonInstance.enabled=YES;
    
    
}
- (void)startLocating:(NSNotification *)notification {
    
    NSDictionary *dict = [notification userInfo];
    NSLog(@"DIct values %@",dict);
    if ([[dict objectForKey:@"full_name"] isEqualToString:@""]) {
    }
    else{
        [self showAlertForLoggedIn:[dict objectForKey:@"full_name"]];
        
    }
    
}





#pragma mark - Linkedln Action
-(void)linkedlnBtnClickLogin
{

    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    // If user has already connected via linkedin in and access token is still valid then
    // No need to fetch authorizationCode and then accessToken again!
    if (linkedIn.isValidToken) {
        
  linkedIn.customSubPermissions = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@",Id,email_address, first_name, last_name,phone_numbers,date_of_birth,location_name,picture_url];
          // So Fetch member info by elderyly access token
        [SVProgressHUD showWithStatus:@"Login..."];

        [linkedIn autoFetchUserInfoWithSuccess:^(NSDictionary *userInfo) {
            // Whole User Info
            
            NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
            desc =[[NSMutableDictionary alloc] initWithDictionary:userInfo];
            //NSLog(@"mon profile ------------------------------>%@",desc);
            
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
                                        
   // NSString * desc = [NSString stringWithFormat:@"first name : %@\n last name : %@",userInfo[@"firstName"], userInfo[@"lastName"] ];
   // [self showAlertForLoggedIn:desc];
                                        NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
                                        desc =[[NSMutableDictionary alloc] initWithDictionary:userInfo];
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
                                      NSLog(@"error : %@", error.userInfo.description);
                                     // self.linkedInLogoutButtonInstance.hidden = !linkedIn.isValidToken;
               }
         ];
    }
}



#pragma mark - Twitter Action
-(void)TwitterLogin{
    
}

-(void)TwitterLoginBtnClick
{
    [SVProgressHUD showWithStatus:@"Login..."];
    [SCTwitter loginViewControler:self callback:^(BOOL success, id result){
        [SVProgressHUD dismiss];
        if (success) {
            NSLog(@"Login is Success -  %i", success);
            SCAlert(@"Alert", @"Success");
        }
    }];
}



#pragma mark - Auth
- (void) userAuthenticateCallback:(NSNotification *)notification {
    
}


- (void) userLoggedIn:(NSString *)username userID:(NSString *)userID {
    self.userID = userID;
    //[self showAlertForLoggedIn:username];
    [_userDefaults setObject:username forKey:@"flickerLogin"];
    [_userDefaults synchronize];
    //self.flickerLogoutButtonInstance.enabled=YES;
    // [self.flickerLogoutButtonInstance setTitle:@"Logout" forState:UIControlStateNormal];
    //self.authLabel.text = [NSString stringWithFormat:@"You are logged in as %@", username];
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
    
        [alert addAction:yesButton];
    //[alert addAction:noButton];
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
    
}




-(void)flickerLogin{
    
}




// Background Images
- (UIImageView *)topImageView {
        if(!_topImageView)
    {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _topImageView.centerX = SCREEN_WIDTH/2;
        _topImageView.image = [UIImage imageNamed:@"welcomePage"];
        [self.view addSubview:_topImageView];

    }
    
    return _topImageView;
}

-(UILabel *)titleName
{
    if (!_titleName)
    {
        self.titleName = [UILabel  createLabelWithFrame:CGRectMake(2*textFieldStartX,10,TL,2*D)
                                        backgroundColor:KCOLOR_CLEAR
                                              textColor:KCOLOR_WHITE
                                                   font:OSWALD_BOLD_(18)
                                          textalignment:NSTextAlignmentCenter
                                                   text:NSLocalizedString(@"Localized_WelcomeViewController_title",comment:"")
                                          conrnerRadius:8.0
                                            borderWidth:1.0
                                            borderColor:KCOLOR_CLEAR];
        self.titleName.numberOfLines = 3;
        [self.view addSubview:_titleName];
        
    }
    return _titleName;
}

//  signupAction

-(UIButton *)loginAction
{
    if(!_loginAction) {
        _loginAction = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-60,SCREEN_HEIGHT-(H4+85),30,30)];
        _loginAction.layer.borderWidth = 1.0;
        _loginAction.layer.cornerRadius = _loginAction.height/2;
        [_loginAction setTitle:@"\U0000e6f1" forState:UIControlStateNormal];
        _loginAction.layer.borderColor = KCOLOR_WHITE.CGColor;
        [_loginAction setBackgroundColor:KTHEME_COLOR];
        [_loginAction setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal];
        _loginAction.titleLabel.font = KICON_FONT_(20);
        _loginAction.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_loginAction addTarget:self action:@selector(LoginViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginAction];
    }
    return _loginAction;
}

// facebookBtn OK
-(UIButton *)facebookBtn
{
    if(!_facebookBtn) {
        _facebookBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-15,SCREEN_HEIGHT-(H4+85),30,30)];
        _facebookBtn.layer.borderWidth = 1.0;
        _facebookBtn.layer.cornerRadius = _facebookBtn.height/2;
        [_facebookBtn setTitle:@"\U0000e659" forState:UIControlStateNormal];
        _facebookBtn.layer.borderColor = KCOLOR_WHITE.CGColor;
        [_facebookBtn setBackgroundColor:KTHEME_COLOR];
        [_facebookBtn setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal];
        _facebookBtn.titleLabel.font = KICON_FONT_(20);
        _facebookBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_facebookBtn addTarget:self action:@selector(facebookBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_facebookBtn];
    }
    return _facebookBtn;
}

-(UIButton *)signupAction
{
    if(!_signupAction) {
        _signupAction = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)+30,SCREEN_HEIGHT-(H4+85),30,30)];
        _signupAction.layer.borderWidth = 1.0;
        _signupAction.layer.cornerRadius = _signupAction.height/2;
        [_signupAction setTitle:@"\U0000e603" forState:UIControlStateNormal];
        _signupAction.layer.borderColor = KCOLOR_WHITE.CGColor;
        [_signupAction setBackgroundColor:KTHEME_COLOR];
        [_signupAction setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal];
        _signupAction.titleLabel.font = KICON_FONT_(20);
        _signupAction.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_signupAction addTarget:self action:@selector(SignupViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_signupAction];
    }
    return _signupAction;
}

//socialLogin
-(UIView *)socialLogin
{
    
    if (!_socialLogin) {
        
        self.socialLogin = [UIView createViewWithFrame:CGRectMake(0,SCREEN_HEIGHT-(H4+35), SCREEN_WIDTH,55)
                                   backgroundColor:KCOLOR_CLEAR];
        
 
        //twitter
        if(!_twitterBtnLogin) {
            _twitterBtnLogin = [[UIButton alloc] initWithFrame:CGRectMake(SW5,5, 40,40)];
            _twitterBtnLogin.layer.cornerRadius = _twitterBtnLogin.height/2;
            [_twitterBtnLogin setImage:[UIImage imageNamed:@"6000"]  forState:UIControlStateNormal];
            //[_twitterBtnLogin setImage:[UIImage imageNamed:@"twitter"]  forState:UIControlStateNormal];
            _twitterBtnLogin.contentMode = UIViewContentModeScaleToFill;
            _twitterBtnLogin.layer.borderColor = KCOLOR_CLEAR.CGColor;
            [_twitterBtnLogin setBackgroundColor:KCOLOR_CLEAR];
            _twitterBtnLogin.tag = 1;
            //[_twitterBtnLogin addTarget:self action:@selector(TwitterLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self.socialLogin addSubview:_twitterBtnLogin];
        }
        
        //facebook  Ok
        if(!_facebookBtnLogin) {
            _facebookBtnLogin = [[UIButton alloc] initWithFrame:CGRectMake(_twitterBtnLogin.right+10,5, 40,40)];
            _facebookBtnLogin.layer.cornerRadius = _facebookBtnLogin.height/2;
            [_facebookBtnLogin setImage:[UIImage imageNamed:@"facebook"]  forState:UIControlStateNormal];
            _facebookBtnLogin.contentMode = UIViewContentModeScaleToFill;
            _facebookBtnLogin.layer.borderColor = KCOLOR_CLEAR.CGColor;
            [_facebookBtnLogin setBackgroundColor:KCOLOR_CLEAR];
           // [_facebookBtnLogin addTarget:self action:@selector(facebookBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [_facebookBtnLogin addTarget:self action:@selector(socialButtonViewClick:) forControlEvents:UIControlEventTouchUpInside];

            _facebookBtnLogin.tag = 2;
            [self.socialLogin addSubview:_facebookBtnLogin];
        }
        //linkedln  OK
        if(!_linkedlnBtnLogin) {
            _linkedlnBtnLogin = [[UIButton alloc] initWithFrame:CGRectMake(_facebookBtnLogin.right+10,5, 40,40)];
            _linkedlnBtnLogin.layer.cornerRadius = _linkedlnBtnLogin.height/2;
            [_linkedlnBtnLogin setImage:[UIImage imageNamed:@"linkedln"]  forState:UIControlStateNormal];
            _linkedlnBtnLogin.contentMode = UIViewContentModeScaleToFill;
            _linkedlnBtnLogin.layer.borderColor = KCOLOR_CLEAR.CGColor;
            [_linkedlnBtnLogin setBackgroundColor:KCOLOR_CLEAR];
            [_linkedlnBtnLogin addTarget:self action:@selector(socialButtonViewClick:) forControlEvents:UIControlEventTouchUpInside];
            _linkedlnBtnLogin.tag = 3;
            [self.socialLogin addSubview:_linkedlnBtnLogin];
        }
        
        
        //google
        if(!_googleBtnLogin) {
            _googleBtnLogin = [[UIButton alloc] initWithFrame:CGRectMake(_linkedlnBtnLogin.right+10,5, 40,40)];
            _googleBtnLogin.layer.cornerRadius = _googleBtnLogin.height/2;
            [_googleBtnLogin setImage:[UIImage imageNamed:@"60000"]  forState:UIControlStateNormal];
           // [_googleBtnLogin setImage:[UIImage imageNamed:@"google"]  forState:UIControlStateNormal];
            _googleBtnLogin.contentMode = UIViewContentModeScaleToFill;
            _googleBtnLogin.layer.borderColor = KCOLOR_CLEAR.CGColor;
            [_googleBtnLogin setBackgroundColor:KCOLOR_CLEAR];
            //[_googleBtnLogin addTarget:self action:@selector(googlePlusLogin) forControlEvents:UIControlEventTouchUpInside];
            _googleBtnLogin.tag = 4;
            [self.socialLogin addSubview:_googleBtnLogin];
        }
        
        
        
        [self.view addSubview:self.socialLogin];
    }
    
    return _socialLogin;
}


- (void)socialButtonViewClick:(UIButton *)sender
{
    
    sender.selected = YES;
    
    if (sender.tag == 2)
    {
        _socialLoginTag = @"facebook";
        _topSelectedTag = 2;
         [self facebookLogin];

    }
    else if (sender.tag == 3)
    {
        _socialLoginTag = @"linkedln";
        _topSelectedTag = 3;
        [self linkedlnBtnClickLogin];

    }
    
    

}


// View Btn
-(UIView *)userBtn
{
    if (!_userBtn)
    {
        self.userBtn = [UIView createViewWithFrame:CGRectMake(0,SCREEN_HEIGHT-H4, SCREEN_WIDTH,H4)
                                   backgroundColor:KCOLOR_CLEAR];
        // Btn Search School
        if(!_serchSchoolsBtn) {
            _serchSchoolsBtn = [[UIButton alloc] initWithFrame:CGRectMake(textFieldStartX,_serchSchoolsBtn.bottom+((H4-D)/6)+5, SCREEN_WIDTH-2*textFieldStartX,D)];
            _serchSchoolsBtn.layer.borderWidth = 1.0;
            _serchSchoolsBtn.layer.cornerRadius = 8.0;
            [_serchSchoolsBtn setTitle:NSLocalizedString(@"Localized_WelcomeViewController_loginBtn",comment:"") forState:UIControlStateNormal];
            _serchSchoolsBtn.layer.borderColor = KCOLOR_RED.CGColor;
            [_serchSchoolsBtn setBackgroundColor:KCOLOR_RED];
            [_serchSchoolsBtn setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal];
            _serchSchoolsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:21.0];
            _serchSchoolsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [_serchSchoolsBtn addTarget:self action:@selector(SearchSchool) forControlEvents:UIControlEventTouchUpInside];
            [self.userBtn addSubview:_serchSchoolsBtn];
        }
        
        
        // Btn Search Student
        if(!self.serchStudentsBtn) {
            self.serchStudentsBtn = [[UIButton alloc] initWithFrame:CGRectMake(textFieldStartX,_serchSchoolsBtn.bottom+3, SCREEN_WIDTH-2*textFieldStartX,D)];
            self.serchStudentsBtn.layer.borderWidth = 1.0;
            self.serchStudentsBtn.layer.cornerRadius = 8.0;
            [self.serchStudentsBtn setTitle:NSLocalizedString(@"Localized_WelcomeViewController_SignUpBtn",comment:"") forState:UIControlStateNormal];
            self.serchStudentsBtn.layer.borderColor = KCOLOR_BLUE.CGColor;
            [self.serchStudentsBtn setBackgroundColor:KCOLOR_BLUE];
            [self.serchStudentsBtn setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal];
            self.serchStudentsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:21.0];
            self.serchStudentsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.serchStudentsBtn addTarget:self action:@selector(SearchStudent) forControlEvents:UIControlEventTouchUpInside];
            [self.userBtn addSubview:self.serchStudentsBtn];
        }
        
        [self.view addSubview:self.userBtn];
    }
    
    return _userBtn;
}

-(void)LoginViewController
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click login");
}



-(void)SignupViewController
{
    SignupViewController *vc = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click signup");
}

-(void)SearchSchool
{
    SearchListViewController *vc = [[SearchListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click search school page");
}

-(void)SearchStudent
{
    SearchListStudentViewController *vc = [[SearchListStudentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click search student page");
}


-(void)logOutuserPage
{
    WelcomeViewController *vc = [[WelcomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@" click search student page");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userDefaults=[NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLocating:) name:@"ForceUpdateLocation" object:nil]; // don't forget the ":"
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticateCallback:) name:@"UserAuthCallbackNotification" object:nil];
    
    [self topImageView];
    [self loginAction];
    [self signupAction];
    [self facebookBtn];
    [self userBtn];
    [self titleName];
    [self socialLogin];
    self.view.backgroundColor = KTHEME_COLOR;
    [self.navigationController.navigationBar setHidden:YES];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageWithColor:KTHEME_COLOR size:CGSizeMake(SCREEN_WIDTH, 1)]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [navigationBar setShadowImage:[UIImage new]];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERNAME];
    NSString *passWd = [[NSUserDefaults standardUserDefaults] objectForKey:KPASSWORD];
    if(userName && passWd)
    {
        self.userNameTextField.text = userName;
        self.passWDTextField.text = passWd;
    }
    
    
    // facebook Login
//    self.btnFBLogin = [[FBSDKLoginButton alloc] init];
//    [self.view addSubview:self.btnFBLogin];
//    self.btnFBLogin.delegate = self;
//    [self.btnFBLogin setHidden:YES];
    
    
    // Google Login
    self.btnGMLogin = [[GIDSignInButton alloc] init];
    [self.view addSubview:self.btnGMLogin];
    [self.btnGMLogin setHidden:YES];
    
    
    [GIDSignIn sharedInstance].uiDelegate = self;

    
    _name = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERNAME];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


-(void)showAlertForLoggedIn:(NSMutableDictionary *)dataToshow {
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Successfully Logged In" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSString stringWithFormat:@"%@",_socialLoginTag] forKey:@"social_type"];
        NSMutableString *string = [NSMutableString stringWithString:urlHeader];
        if (_topSelectedTag == 2)
        {
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
            NSLog(@"facebook ID------------------------------>%@",self.S_ID);

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
            
            
        } else if (_topSelectedTag == 3)
        {
            
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
            
            
            
            
            NSMutableDictionary *descLocal =  [NSMutableDictionary dictionary];
            descLocal =[[NSMutableDictionary alloc] initWithDictionary:dataToshow[@"location"]];
            
           NSLog(@"Linkedln ID------------------------------>%@",self.L_ID);


            
            [string appendString:@"Social/linkdedln"];
            [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                if([[responseObject objectForKey:@"code"] isEqual:@200])
                {
                    // [self presentViewController:alert animated:YES completion:nil];
                    
                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"sess_id"] forKey:KSESSION_ID];
                    _sess_ID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"sess_id"]];
                    
                   // [[NSUserDefaults standardUserDefaults] setObject:self.name forKey:KUSERNAME];
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
        
        
    });
    
    
}


-(void)facebookLogin
{
    
    __block  NSMutableDictionary *fbResultData;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
             [[FBSDKLoginManager new] logOut];
         } else {
             NSLog(@"Logged in OK");
              [SVProgressHUD showWithStatus:@"Login..."];
             
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
                          NSLog(@"result: %@",[error description]);
                          //                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error description] delegate:nil cancelButtonTitle:NSLocalizedString(@"DISMISS", nil) otherButtonTitle:nil];
                          // [alert showInView:self.view.window];
                          [self showAlertForLoggedIn:[error description]];
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


@end
