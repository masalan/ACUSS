//
//  LoginViewController.m
//  HHSD
//
//  Created by alain serge on 3/9/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "LoginViewController.h"
#import "WDTabBarViewController.h"
#import "AppDelegate.h"
#import "Macros.h"
#import "SignupViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "SearchListViewController.h"


#define imageStartX 60
#define textFieldStartX 25
#define d_M_logo_70 (SCREEN_WIDTH-70)/2
#define d_M_logo_80 (SCREEN_WIDTH-80)/2
#define d_M_logo_100 (SCREEN_WIDTH-100)/2
#define d_M_logo_170 (SCREEN_WIDTH-170)/2
#define d_M_logo_200 (SCREEN_WIDTH-200)/2
#define d_M_logo_250 (SCREEN_WIDTH-250)/2


#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-2*textFieldStartX

#define D 40

@interface LoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, retain) UIView *userNameTextView;
@property (nonatomic, retain) UIView *passWDView;
@property (nonatomic, retain) UITextField *passWDTextField;
@property (nonatomic, retain) UIView *centerView;
@property (nonatomic, retain) UIButton *loginUser,*signupUser;
@property (nonatomic, retain) UIImageView *logoEduMobile;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;
@property (strong, nonatomic) FYLoginTranslation* login;

@end

@implementation LoginViewController

//ScrollView action
- (TPKeyboardAvoidingScrollView *)backScrollView
{
    if(!_backScrollView)
    {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:_backScrollView];
    }
    return _backScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backScrollView];
    [self logoEduMobile];
    [self loginUser];
    [self signupUser];
    [self passWDView];
    [self userNameTextView];
    [self racInit];

    self.title = @"Login";
    self.view.backgroundColor = KTHEME_COLOR;
    
    //Hide Top bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
    
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERNAME];
    NSString *passWd = [[NSUserDefaults standardUserDefaults] objectForKey:KPASSWORD];
    if(userName && passWd)
    {
        self.userNameTextField.text = userName;
        self.passWDTextField.text = passWd;
        self.loginUser.enabled = YES;
    }
    
    
   }

// Action login button
- (void)racInit
{
    @weakify(self);
    RAC(self.loginUser, enabled) = [RACSignal
                                   combineLatest:@[
                                                   self.userNameTextField.rac_textSignal,
                                                   self.passWDTextField.rac_textSignal
                                                   ]
                                   reduce:^(NSString *tel, NSString *yanzhengma)
                                   {
                                       return @(tel.length>4 &&yanzhengma.length>4);
                                   }];
    [RACObserve(self.loginUser
                , enabled) subscribeNext:^(NSNumber *enabled) {
        @strongify(self);
        self.loginUser.backgroundColor = enabled.boolValue?KCOLOR_BLUE:KCOLOR_GRAY_Cell;
        self.loginUser.tintColor = enabled.boolValue?KCOLOR_WHITE:KCOLOR_GRAY_Cell;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.leftBackBtn.hidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES ];
    [self.navigationController.navigationBar setHidden:NO];
}


- (void) animate:(BOOL) up length:(int)length
{
    int movement = (up ? -length : length);
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    }];
}



// background Image
- (UIImageView *)logoEduMobile
{
    if(!_logoEduMobile)
    {
        _logoEduMobile = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];

        _logoEduMobile.image = [UIImage imageNamed:@"welcomePage"];
        [self.backScrollView addSubview:_logoEduMobile];
    }
    return _logoEduMobile;
}

//Email or Pseudo Fiel View
- (UIView *)userNameTextView
{
    if(!_userNameTextView)
    {
        _userNameTextView = [[UIView alloc] initWithFrame:CGRectMake(textFieldStartX,SCREEN_HEIGHT-(64+3*D+43),
                                                                     SCREEN_WIDTH - 2*textFieldStartX,
                                                                     44)];
        _userNameTextView.layer.borderWidth = 1.0;
        _userNameTextView.layer.borderColor = KCOLOR_GRAY.CGColor;
        _userNameTextView.layer.cornerRadius = 8.0;
        _userNameTextView.backgroundColor = KCOLOR_WHITE;
        
        UILabel *imageView = [UILabel createLabelWithFrame:CGRectMake(7, 10, 25, 25)
                                            backgroundColor:KCOLOR_CLEAR
                                                  textColor:KTHEME_COLOR
                                                       font:KICON_FONT_(18)
                                              textalignment:NSTextAlignmentLeft
                                                       text:@"\U0000e634"];
        
        [_userNameTextView addSubview:imageView];
        
        if(!_userNameTextField)
        {
            _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 8, SCREEN_WIDTH - 2*textFieldStartX - 40, 30)];
            _userNameTextField.delegate = self;
            _userNameTextField.tag = 0;
            _userNameTextField.clearButtonMode = YES;
            //_userNameTextField.keyboardType = UIKeyboardTypeEmailAddress;
            _userNameTextField.keyboardType  = UIKeyboardTypeEmailAddress;
            [_userNameTextField.text lowercaseString];
            _userNameTextField.textColor = KCOLOR_GRAY;
            _userNameTextView.backgroundColor = KCOLOR_WHITE;
            _userNameTextField.placeholder = @"username or mobile";
            _userNameTextField.font = [UIFont systemFontOfSize:20.0];
            _userNameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERNAME];
            [_userNameTextView addSubview:_userNameTextField];
        }
        
        [self.backScrollView addSubview:_userNameTextView];
    }
    return _userNameTextView;
}

// Password field View
- (UIView *)passWDView
{
    if(!_passWDView)
    {
        _passWDView = [[UIView alloc] initWithFrame:CGRectMake(textFieldStartX,SCREEN_HEIGHT-(64+2*D+40),
                                                               SCREEN_WIDTH - 2*textFieldStartX,
                                                               44)];
        _passWDView.layer.borderWidth = 1.0;
        _passWDView.layer.borderColor = KCOLOR_GRAY.CGColor;
        _passWDView.layer.cornerRadius = 8.0;
        _passWDView.backgroundColor = KCOLOR_WHITE;
        
        
        UILabel *imageView = [UILabel createLabelWithFrame:CGRectMake(7, 10, 25, 25)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KTHEME_COLOR
                                                      font:KICON_FONT_(18)
                                             textalignment:NSTextAlignmentLeft
                                                      text:@"\U0000e60c"];
        [_passWDView addSubview:imageView];
        
        if(!_passWDTextField)
        {
            _passWDTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 8, SCREEN_WIDTH - 2*textFieldStartX - 40, 30)];
            _passWDTextField.delegate = self;
            _passWDTextField.tag = 1;
            _passWDTextField.clearButtonMode = YES;
            _passWDTextField.secureTextEntry = YES;
            _passWDTextField.textColor = KCOLOR_GRAY;
            _passWDTextField.backgroundColor = KCOLOR_WHITE;
            _passWDTextField.placeholder = @"*************";
            _passWDTextField.font = [UIFont systemFontOfSize:20.0];
            if(![_userNameTextField.text isEqualToString:@""]) {
                _passWDTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:KPASSWORD];
            }
            
            [_passWDView addSubview:_passWDTextField];
        }
        
        [self.backScrollView addSubview:_passWDView];
    }
    
    return _passWDView;
}



// Login user
- (UIButton *)loginUser
{
    if(!_loginUser)
    {
        _loginUser = [[UIButton alloc] initWithFrame:CGRectMake(10,SCREEN_HEIGHT-(64+D+10),((SCREEN_WIDTH-20)/2)-5,D)];
        _loginUser.layer.borderWidth = 1.0;
        _loginUser.layer.borderColor = KCOLOR_CLEAR.CGColor;
        [_loginUser setBackgroundColor:KCOLOR_BLUE];
        _loginUser.layer.cornerRadius = 5.0;
        [_loginUser setTitle:@"login" forState:UIControlStateNormal];
        _loginUser.titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
        _loginUser.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_loginUser addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.backScrollView addSubview:_loginUser];
    }
    return _loginUser;
}

// SignUp user
- (UIButton *)signupUser
{
    if(!_signupUser)
    {
        _signupUser = [[UIButton alloc] initWithFrame:CGRectMake(_loginUser.right+10,SCREEN_HEIGHT-(64+D+10),((SCREEN_WIDTH-20)/2)-10,D)];
        _signupUser.layer.borderWidth = 1.0;
        _signupUser.layer.borderColor = KCOLOR_RED.CGColor;
        [_signupUser setBackgroundColor:KCOLOR_RED];
        _signupUser.layer.cornerRadius = 5.0;
        [_signupUser setTitle:@"sign up"  forState:UIControlStateNormal];
        _signupUser.titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
        _signupUser.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_signupUser addTarget:self action:@selector(inscriptionButon) forControlEvents:UIControlEventTouchUpInside];
        [self.backScrollView addSubview:_signupUser];
    }
    return _signupUser;
}

#pragma mark OhterAction

//Register User
- (void)inscriptionButon
{
    NSLog(@"Register user page");
    SignupViewController *vc = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


//Login With Pseudo Click
-(void)LoginWithPseudo

{
    NSLog(@"Login user page");
    SearchListViewController *vc = [[SearchListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




// Checking server
- (void)loginBtnClick
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.userNameTextField.text, @"mobile");
    kSetDict(self.passWDTextField.text, @"password");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"user/login"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
           // [self MBShowHint:@"Congratulations on your successful login"];
            [SVProgressHUD showWithStatus:@"Login..."];

            [[NSUserDefaults standardUserDefaults] setValue:self.userNameTextField.text forKey:KUSERNAME];
            [[NSUserDefaults standardUserDefaults] setValue:self.passWDTextField.text forKey:KPASSWORD];
            [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"data"][@"sess_id"] forKey:KSESSION_ID];
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.windowController = nil;
            WDTabBarViewController *tabbar = [[WDTabBarViewController alloc] init];
            delegate.windowController = [[UINavigationController alloc] initWithRootViewController:tabbar];
            delegate.windowController.navigationBarHidden = YES;
            delegate.window.rootViewController = delegate.windowController;
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
           // [self MBShowHint:responseObject[@"message"]];
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];

        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
    
}


- (FYLoginTranslation *)login {
    if (!_login) {
        _login = [[FYLoginTranslation alloc] initWithView:self.loginUser];
    }
    return _login;
}

-(void)finishTransitionRootVC {    
    [self performSelector:@selector(finishTransition) withObject:nil afterDelay:1];
}

- (void)finishTransition {
    [self.login stopAnimation];
}



@end

