//
//  SignupViewController.m
//  HHSD
//
//  Created by alain serge on 3/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SignupViewController.h"
#import "MyPicker.h"
#import "MyDatePicker.h"
#import "MBProgressHUD.h"
#import "ProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "signup_last.h"

#define imageStartX 60
#define textFieldStartX 25
#define d_M_logo_70 (SCREEN_WIDTH-70)/2
#define d_M_logo_80 (SCREEN_WIDTH-80)/2
#define d_M_logo_100 (SCREEN_WIDTH-100)/2
#define d_M_logo_170 (SCREEN_WIDTH-170)/2
#define d_M_logo_200 (SCREEN_WIDTH-200)/2
#define d_M_logo_250 (SCREEN_WIDTH-250)/2
#define StartX 10
#define KborderWidth 1.5
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define W3 SCREEN_WIDTH/3
#define W33 (SCREEN_WIDTH/3)+15

#define WW3 SCREEN_WIDTH-((SCREEN_WIDTH/3)+25)

#define WW SCREEN_WIDTH-40


#define TL SCREEN_WIDTH-2*textFieldStartX
#define H2 SCREEN_HEIGHT/6
#define btnTitle_X 8
#define D 40
#define  UserAgree  @"By registering, you agree to the privacy policy and terms of service. "


@interface SignupViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITextFieldDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong)UITextField *telTextField,*pseudoTextField,*passTextField,*passAgainTextField,*emailTextField,*realnameTextField;
@property (nonatomic, retain) UIView *backView,*ContentView,*FootView;
@property (nonatomic, strong) UIButton *nextStep;
@property (nonatomic, strong)NSNotificationCenter *noticShow;
@property (nonatomic, strong)NSNotificationCenter *noticHide;
@property (nonatomic, copy) NSString *sess_ID;

@end

@implementation SignupViewController

-(void)initInfo {
    _isSelected = YES;
}

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

-(UIView *)ContentView
{
    if (!_ContentView)
    {   
        _ContentView = [UIView createViewWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 250) backgroundColor:KCOLOR_CLEAR];
        _ContentView.backgroundColor = KCOLOR_CLEAR;
        
        //userbame Label
        UIView *lineTop = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) backgroundColor:KCOLOR_WHITE];
        [_ContentView addSubview:lineTop];
        
        if(!_pseudoTextField) {
            _pseudoTextField = [[UITextField alloc] initWithFrame:CGRectMake(KMARGIN_20,lineTop.bottom+1, WW, 49)];
            _pseudoTextField.placeholder = @"Enter your username ";
            [_pseudoTextField setValue:KCOLOR_WHITE forKeyPath:@"_placeholderLabel.textColor"];
            _pseudoTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            _pseudoTextField.adjustsFontSizeToFitWidth = YES;
            [_pseudoTextField.text lowercaseString];
            _pseudoTextField.tag = 0;
            _pseudoTextField.delegate = self;
            _pseudoTextField.textColor = KCOLOR_WHITE;
            _pseudoTextField.font = [UIFont systemFontOfSize:16];
            [_ContentView addSubview:_pseudoTextField];
        }
        
        //mobile Label
        UIView *line1 = [UIView createViewWithFrame:CGRectMake(KMARGIN_20, _pseudoTextField.bottom, WW, 0.5) backgroundColor:KCOLOR_WHITE];
        [_ContentView addSubview:line1];
        
        if (!_telTextField) {
            _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(KMARGIN_20,line1.bottom, WW, 49)];
            _telTextField.placeholder = @"Enter your phone number";
            [_telTextField setValue:KCOLOR_WHITE forKeyPath:@"_placeholderLabel.textColor"];
            _telTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            _telTextField.adjustsFontSizeToFitWidth = YES;
            _telTextField.textContentType = UITextContentTypeTelephoneNumber;
            _telTextField.tag = 1;
            _telTextField.delegate = self;
            _telTextField.textColor = KCOLOR_WHITE;
            _telTextField.font = [UIFont systemFontOfSize:16];
            [_ContentView addSubview:_telTextField];
        }
        
        //password Label
        UIView *line2 = [UIView createViewWithFrame:CGRectMake(KMARGIN_20,_telTextField.bottom,WW, 0.5) backgroundColor:KCOLOR_WHITE];
        [_ContentView addSubview:line2];
        
        if(!_passTextField) {
            _passTextField = [[UITextField alloc] initWithFrame:CGRectMake(KMARGIN_20,line2.bottom, WW, 49)];
            _passTextField.placeholder = @"Enter your password";
            [_passTextField setValue:KCOLOR_WHITE forKeyPath:@"_placeholderLabel.textColor"];
            _passTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            
            _passTextField.adjustsFontSizeToFitWidth = YES;
            _passTextField.tag = 2;
            _passTextField.delegate = self;
            _passTextField.textColor = KCOLOR_WHITE;
            _passTextField.font = [UIFont systemFontOfSize:16];
            [_ContentView addSubview:_passTextField];
        }
        
        // Confirm Password Label
        UIView *line3 = [UIView createViewWithFrame:CGRectMake(KMARGIN_20,_passTextField.bottom,WW, 0.5) backgroundColor:KCOLOR_WHITE];
        [_ContentView addSubview:line3];
        
        
        if(!_passAgainTextField) {
            _passAgainTextField = [[UITextField alloc] initWithFrame:CGRectMake(KMARGIN_20,line3.bottom, WW, 49)];
            _passAgainTextField.placeholder = @"confirme your password";
            [_passAgainTextField setValue:KCOLOR_WHITE forKeyPath:@"_placeholderLabel.textColor"];
            _passAgainTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            _passAgainTextField.adjustsFontSizeToFitWidth = YES;
            _passAgainTextField.tag = 3;
            _passAgainTextField.delegate = self;
            _passAgainTextField.textColor = KCOLOR_WHITE;
            _passAgainTextField.font = [UIFont systemFontOfSize:16];
            [_ContentView addSubview:_passAgainTextField];
        }
        
        
        // Email Label
        UIView *line4 = [UIView createViewWithFrame:CGRectMake(KMARGIN_20, _passAgainTextField.bottom,WW, 0.5) backgroundColor:KCOLOR_WHITE];
        [_ContentView addSubview:line4];
        
        
        if(!_emailTextField) {
            _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(KMARGIN_20, line4.bottom, WW, 49)];
            _emailTextField.placeholder = @"Enter your email address";
            [_emailTextField setValue:KCOLOR_WHITE forKeyPath:@"_placeholderLabel.textColor"];
            _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            _emailTextField.adjustsFontSizeToFitWidth = YES;
            _emailTextField.textContentType = UITextContentTypeEmailAddress;
            _emailTextField.tag = 4;
            _emailTextField.delegate = self;
            _emailTextField.textColor = KCOLOR_WHITE;
            _emailTextField.font = [UIFont systemFontOfSize:16];
            [_ContentView addSubview:_emailTextField];
        }
        
        UIView *lineBottom = [UIView createViewWithFrame:CGRectMake(0,_emailTextField.bottom, SCREEN_WIDTH, 0.5) backgroundColor:KCOLOR_GRAY_e5e5e5];
        [_ContentView addSubview:lineBottom];
        
        
        
        [self.backScrollView addSubview:_ContentView];
    }
    return _ContentView;
}

-(UIView *)FootView
{
    
    if (!_FootView)
    {
        _FootView = [[UIView alloc] initWithFrame:CGRectMake(0,_ContentView.bottom+34, SCREEN_WIDTH, 80)];
        _FootView.backgroundColor = KCOLOR_CLEAR;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnTitle_X, 10, 30, 30)];
        [btn  setTitle:@"\U0000e643"  forState:UIControlStateSelected];
        [btn  setTitle:@"\U0000e64e "  forState: UIControlStateNormal];
        [btn setTintColor:KCOLOR_WHITE];
        btn.titleLabel.font = KICON_FONT_(20);
        btn.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        btn.selected = YES;
        [btn addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_FootView addSubview:btn];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(btnTitle_X + 31, 10,SCREEN_WIDTH-2*(btnTitle_X + 39),40)];
        textLabel.numberOfLines =3;
        textLabel.text = UserAgree;
        textLabel.font = [UIFont systemFontOfSize:14.0];
        textLabel.textColor = KCOLOR_WHITE;
        [_FootView addSubview:textLabel];
        
        _nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextStep.frame = CGRectMake(27, textLabel.bottom + 10, SCREEN_WIDTH - 27 *2, 44);
        _nextStep.layer.cornerRadius = 8.0;
        [_nextStep setTitle:@"Next" forState:UIControlStateNormal];
        [_nextStep setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal ];
        _nextStep.centerX = SCREEN_WIDTH/2;
        _nextStep.backgroundColor = KCOLOR_BLUE;
        [_nextStep addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];

        [_FootView addSubview:_nextStep];
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        [_FootView addGestureRecognizer:singleTap];
        
        [self.backScrollView addSubview:_FootView];
    }
    return _FootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backScrollView];
    [self ContentView];
    [self FootView];
    
    self.title = @"Sign up";
    
    self.view.backgroundColor = KTHEME_COLOR;
    
    
}

-(void)handleSingleTap {
    [self keyBoardHid];
}

- (void)btnSelected:(UIButton *)btn {
    btn.selected = !btn.selected;
    _isSelected = btn.selected;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//MARK:Next step
- (void)nextStepBtnClick {
    [self removeWithKeyboardNotice];
    
    
    if([_pseudoTextField.text isEqualToString:@""])
    {
        [ProgressHUD showError:@"Your username shoud be more than 4 letters"];
        return;
    }
    
    //if(!(_telTextField.text.length == 11))
    if([_telTextField.text isEqualToString:@""])
    {
        [ProgressHUD showError:NSLocalizedString(@"Localized_phone_CANT_BE_EMPTY",comment:"")];
        return ;
    }
    
    if(_passAgainTextField.text.length == 0 || _passTextField == 0 ) {
        [ProgressHUD showError:NSLocalizedString(@"Localized_pwd_CANT_BE_EMPTY",comment:"")];
        return ;
    }
    
    if(![_passTextField.text isEqualToString:_passAgainTextField.text]) {
        [ProgressHUD showError:@"两次密码输入不一致"];
        return ;
    }
    
    if([_emailTextField.text isEqualToString:@""])
    {
        [ProgressHUD showError:@"enter your email"];
        return ;
    }
    
    if(!_isSelected){
        [ProgressHUD showError:@"请勾选使用协议"];
        return ;
    }
    [self saveDataUser];
}




- (void)saveDataUser
{
    DLog(@"Add data");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_pseudoTextField.text forKey:@"username"];
    [params setObject:_telTextField.text forKey:@"mobile"];
    [params setObject:_passTextField.text forKey:@"password"];
    [params setObject:_emailTextField.text forKey:@"email"];
    
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_isSelected] forKey:@"identity"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User/signup"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [self MBShowSuccess:@"Succes"];

        
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"data"]];
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"data"][@"sess_id"] forKey:KSESSION_ID];
            _sess_ID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"sess_id"]];
            
            [[NSUserDefaults standardUserDefaults] setObject:_pseudoTextField.text forKey:KUSERNAME];
            [[NSUserDefaults standardUserDefaults] setObject:_passTextField.text forKey:KPASSWORD];
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"userid"] forKey:KUSER_ID];

            
            signup_last *vc = [[signup_last alloc] init];
            vc.sess_ID = _sess_ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
    
}

#pragma mark uitextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField.tag == 1){
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    if (textField.tag == 4) {
        if (!iPhone6Plus) {
            _noticShow = [NSNotificationCenter defaultCenter];
            _noticHide = [NSNotificationCenter defaultCenter];
            [_noticHide addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
            [_noticHide addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        }
    }
    return YES;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField.tag == 1) {
        if( ![self validateNumber:string]) {
            //[self showMBHint:@"请输入正确的手机号"];
            //  [self MBProgressHUDShow:@"请输入正确的手机号" time:1.0];
            return NO;
        }
    }
    if (textField == self.telTextField) {
        if (string.length == 0) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 12) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.tag == 4) {
        [self removeWithKeyboardNotice];
    }
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self keyBoardHid];
}

-(void)keyBoardHid{
    
    [_pseudoTextField resignFirstResponder];
    [_telTextField resignFirstResponder];
    [_passTextField resignFirstResponder];
    [_passAgainTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    [_realnameTextField resignFirstResponder];
    
}

-(void)removeWithKeyboardNotice {
    if (_noticShow) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    if (_noticHide) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    if (self.view.frame.origin.y != 64) {
        [self.view setFrame:CGRectMake(0, 64, SCREEN_WIDTH, KSCREEN_HEIGHT-64)];
    }
}

#pragma mark - 实现notification
- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    //CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         if (iPhone6) {
                             [self.view setFrame:CGRectMake(0, -30, SCREEN_WIDTH, KSCREEN_HEIGHT-64)];
                         }
                         else {
                             [self.view setFrame:CGRectMake(0, -50, SCREEN_WIDTH, KSCREEN_HEIGHT-64)];
                         }
                     }
                     completion:^(BOOL finished) {}];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.view setFrame:CGRectMake(0, 64, SCREEN_WIDTH, KSCREEN_HEIGHT-64)];
                     }
                     completion:^(BOOL finished) {}];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





@end
