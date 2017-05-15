//
//  settingMyViewController.m
//  HHSD
//
//  Created by alain serge on 3/27/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//
#define StartX 20

#import "settingMyViewController.h"
#import "LoginViewController.h"
#import "MyImagePicker.h"
#import "MyDatePicker.h"
#import "VPImageCropperViewController.h"
#import "MainPageViewController.h"


#define distance (SCREEN_HEIGHT/2)+20
#define avatar (SCREEN_WIDTH/2)-20
#define LabelWidth SCREEN_WIDTH/3-imageView.right-15
#define SW2 SCREEN_WIDTH/2
#define SW3 SCREEN_WIDTH/3

#define SH2 SCREEN_HEIGHT/2
#define SH3 SCREEN_HEIGHT/3



@interface settingMyViewController ()<MyImagePickerDelegate,MyDatePickerDelegate,VPImageCropperDelegate>
@property (nonatomic, retain) UIButton *tuiChuBtn,*logOutBtn;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;
@property (nonatomic, strong) UITextField *nameTextField,*bioTextField;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *topView,*nameView,*sexViewBg,*viewImg,*bottomView,*sexView,*centerView,*hiddenView,*hiddenStatus,*bioView;
@property (nonatomic, copy) NSString *birthdayString;
@property (nonatomic, strong) UIButton *selectedBtn,*birthDay,*hiddenSelectedBtn;
@property (nonatomic, strong) MyImagePicker *imagePicker;
@property (nonatomic, strong) MyDatePicker *datePicker;
@property (nonatomic, strong) Student_Details *personCenter_MyData;
@property (nonatomic, strong) UILabel *bioLabelText;

@end

@implementation settingMyViewController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _birthdayString = @"";
    }
    return self;
}



//ScrollView action
- (TPKeyboardAvoidingScrollView *)backScrollView
{
    if(!_backScrollView)
    {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120)];
        [self.view addSubview:_backScrollView];
    }
    return _backScrollView;
}


// avatar
-(UIView *)viewImg
{
    if (!_viewImg)
    {
        _viewImg = [UIView createViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SW2) backgroundColor:KCOLOR_CLEAR];
        
        if (!_iconImageView) {
            _iconImageView = [UIImageView createImageViewWithFrame:CGRectMake(0, 5, SW3, SW3)
                                                   backgroundColor:KCOLOR_WHITE
                                                             image:nil];
            _iconImageView.layer.borderColor = KCOLOR_WHITE.CGColor;
            _iconImageView.layer.borderWidth = 1.5;
            _iconImageView.layer.cornerRadius = _iconImageView.width/2;
            _iconImageView.backgroundColor = KCOLOR_CLEAR;
            _iconImageView.centerX = SCREEN_WIDTH/2;
            _iconImageView.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_myData.avatar_user]]
                              placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")]];
            UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(0, 17, SW3, SW3)
                                            backgroundColor:KCOLOR_CLEAR image:nil];
            [btn setTitle:nil forState:UIControlStateNormal];
            [btn setTitleColor:KCOLOR_CLEAR forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(addAvatarUserClic) forControlEvents:UIControlEventTouchUpInside];
            [_iconImageView addSubview:btn];
            _iconImageView.userInteractionEnabled = YES;
            [_viewImg addSubview:_iconImageView];
        }
        
        [self.backScrollView addSubview:_viewImg];
    }
    
    return _viewImg;
}

// name
- (UIView *)nameView
{
    if(!_nameView)
    {
        _nameView = [[UIView alloc] initWithFrame:CGRectMake(0, _viewImg.bottom-30, SCREEN_WIDTH, 50)];
        _nameView.backgroundColor = KCOLOR_CLEAR;
       
        
        
        if(!_nameTextField)
        {
            _nameTextField = [UITextField createTextFieldWithFrame:CGRectMake(10,2, SCREEN_WIDTH -20, 40)
                                                   backgroundColor:KCOLOR_WHITE
                                                       borderStyle:UITextBorderStyleRoundedRect
                                                       placeholder:@""
                                                              text:@""
                                                         textColor:KCOLOR_Black_343434
                                                              font:KSYSTEM_FONT_(13)
                                                     textalignment:NSTextAlignmentLeft];
            _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            _nameTextField.layer.borderWidth = 1.0;
            _nameTextField.layer.borderColor = KCOLOR_Line_Color.CGColor;
            _nameTextField.layer.cornerRadius = 5.0;
            _nameTextField.text = _myData.fullName;
            [_nameView addSubview:_nameTextField];
        }
        [self.backScrollView addSubview:_nameView];
    }
    return _nameView;
}
// Sex
- (UIView *)sexViewBg
{
    if(!_sexViewBg)
    {
        _sexViewBg = [[UIView alloc] initWithFrame:CGRectMake(0, _nameView.bottom, SCREEN_WIDTH,70)];
        _sexViewBg.backgroundColor = KCOLOR_CLEAR;

        UILabel *sexViewBgTitle = [UILabel createLabelWithFrame:CGRectMake(20, 0, 100, 20)
                                         backgroundColor:KCOLOR_CLEAR
                                               textColor:KCOLOR_WHITE
                                                    font:KSYSTEM_FONT_(10)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@"Gender"];
        [_sexViewBg addSubview:sexViewBgTitle];
        if(!_sexView)
        {
            _sexView = [UIView createViewWithFrame:CGRectMake(0, sexViewBgTitle.bottom+3, SCREEN_WIDTH, 44)
                                   backgroundColor:KCOLOR_GRAY_f5f5f5];
            NSArray *array = [NSArray arrayWithObjects:@"\U0000e6bf",@"\U0000e60f",@"\U0000e690", nil];
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(SCREEN_WIDTH/array.count * idx, 0, SCREEN_WIDTH/array.count, _sexView.height)
                                                backgroundColor:KCOLOR_GRAY_f5f5f5
                                                          image:nil];
                btn.titleLabel.font = KICON_FONT_(19);
                
                [btn setTitleColor:KTHEME_COLOR forState:UIControlStateNormal];
                [btn setTitleColor:KCOLOR_WHITE  forState:UIControlStateSelected];
                [btn setTitle:array[idx] forState:UIControlStateNormal];
                btn.tag = idx;
                btn.selected = NO;
                if(idx == [_myData.gender integerValue])
                {
                    _selectedBtn = btn;
                }
                [btn addTarget:self action:@selector(UserEditSexBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_sexView addSubview:btn];
            }];
            [_sexViewBg addSubview:_sexView];
        }
        [self.backScrollView addSubview:_sexViewBg];
    }
    return _sexViewBg;
}

// hidden my profile
- (UIView *)hiddenView
{
    if(!_hiddenView)
    {
        _hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, _sexViewBg.bottom, SCREEN_WIDTH, 80)];
        _hiddenView.backgroundColor = KCOLOR_CLEAR;
        
        UILabel *hiddenViewTitle = [UILabel createLabelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 20)
                                         backgroundColor:KCOLOR_CLEAR
                                               textColor:KCOLOR_WHITE
                                                    font:KSYSTEM_FONT_(10)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@"Hidden my profile for"];
        [_hiddenView addSubview:hiddenViewTitle];
        
        if (!_hiddenStatus) {
            _hiddenStatus = [UIView createViewWithFrame:CGRectMake(0,hiddenViewTitle.bottom, SCREEN_WIDTH, 44)
                                        backgroundColor:KCOLOR_GRAY_f5f5f5];
            
            NSArray *arrayData = [NSArray arrayWithObjects:@"\U0000e781",@"\U0000e780 Search",@"\U0000e690 Everyone", nil];
            [arrayData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UIButton *btnHidden = [UIButton createButtonwithFrame:CGRectMake(SCREEN_WIDTH/arrayData.count * idx, 0, SCREEN_WIDTH/arrayData.count, _hiddenStatus.height)
                                                      backgroundColor:KCOLOR_GRAY_f5f5f5
                                                                image:nil];
                btnHidden.titleLabel.font = KICON_FONT_(14);
                
                [btnHidden setTitleColor:KTHEME_COLOR forState:UIControlStateNormal];
                [btnHidden setTitleColor:KCOLOR_WHITE  forState:UIControlStateSelected];
                [btnHidden setTitle:arrayData[idx] forState:UIControlStateNormal];
                btnHidden.tag = idx;
                btnHidden.selected = NO;
                if(idx == [_myData.hiddenNote integerValue])
                {
                    _hiddenSelectedBtn = btnHidden;
                }
                [btnHidden addTarget:self action:@selector(UserEditHiddenBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_hiddenStatus addSubview:btnHidden];
            }];
            [_hiddenView addSubview:_hiddenStatus];
        }
        
        [self.backScrollView addSubview:_hiddenView];
    }
    return _hiddenView;
}

// Bio
// bioView

- (UIView *)bioView
{
    if(!_bioView)
    {
        _bioView = [[UIView alloc] initWithFrame:CGRectMake(0, _hiddenView.bottom, SCREEN_WIDTH, ((SH3-40)/2)+30)];
        _bioView.backgroundColor = KCOLOR_CLEAR;
        
        
        UILabel *bioViewTitle = [UILabel createLabelWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 20)
                                         backgroundColor:KCOLOR_CLEAR
                                               textColor:KCOLOR_WHITE
                                                    font:KICON_FONT_(13)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@"\U0000e75c My biography"];
        [_bioView addSubview:bioViewTitle];
        
        if(!_bioTextField)
        {
            _bioTextField = [UITextField createTextFieldWithFrame:CGRectMake(20,bioViewTitle.bottom+2, SCREEN_WIDTH - 40,(SH3-40)/2)
                                                   backgroundColor:KCOLOR_WHITE
                                                       borderStyle:UITextBorderStyleRoundedRect
                                                       placeholder:_myData.info
                                                              text:@""
                                                         textColor:KCOLOR_Black_343434
                                                              font:KSYSTEM_FONT_(15)
                                                     textalignment:NSTextAlignmentLeft];
            _bioTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
            _bioTextField.layer.borderWidth = 1.0;
            _bioTextField.layer.borderColor = KCOLOR_Line_Color.CGColor;
            _bioTextField.layer.cornerRadius = 5.0;
            _bioTextField.text = _myData.info;
            [_bioView addSubview:_bioTextField];
        }
 
        
        
        [self.backScrollView addSubview:_bioView];
    }
    return _bioView;
}

// Birthday
- (UIView *)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _bioView.bottom, SCREEN_WIDTH,70)];
        _bottomView.backgroundColor = KCOLOR_CLEAR;
        UILabel *nicheng = [UILabel createLabelWithFrame:CGRectMake(20, 0, 100, 20)
                                         backgroundColor:KCOLOR_CLEAR
                                               textColor:KCOLOR_WHITE
                                                    font:KICON_FONT_(11)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@"\U0000e771  birthday"];
        [_bottomView addSubview:nicheng];
        if(!_birthDay)
        {
            _birthDay = [UIButton createButtonwithFrame:CGRectMake(20, 25, SCREEN_WIDTH - 40, 44)
                                        backgroundColor:KCOLOR_WHITE image:nil];
            _birthDay.layer.borderColor = KCOLOR_Line_Color.CGColor;
            _birthDay.layer.borderWidth = 1.0;
            _birthDay.layer.cornerRadius = 5.0;
            [_birthDay setTitleColor:KCOLOR_Black_343434 forState:UIControlStateNormal];
            [_birthDay setTitle:[PublicMethod getYMDUsingCreatedTimestamp:_myData.birthday] forState:UIControlStateNormal];
            [_birthDay addTarget:self action:@selector(birthDayButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView addSubview:_birthDay];
            
            
        }
        [self.backScrollView addSubview:_bottomView];
        
    }
    return _bottomView;
}


#pragma mark
#pragma mark ----- otherAction -----
- (void)UserEditSexBtn:(UIButton *)sender
{
    _selectedBtn.selected = NO;
    _selectedBtn.backgroundColor = KCOLOR_GRAY_f5f5f5;
    sender.backgroundColor = KTHEME_COLOR;
    sender.selected = YES;
    _selectedBtn = sender;
}

- (void)UserEditHiddenBtn:(UIButton *)sender
{
    _hiddenSelectedBtn.selected = NO;
    _hiddenSelectedBtn.backgroundColor = KCOLOR_GRAY_f5f5f5;
    sender.backgroundColor = KTHEME_COLOR;
    sender.selected = YES;
    _hiddenSelectedBtn = sender;
}

- (void)saveSettingBtnClikc
{
    DLog(@"sava setting");
    NSData *jsonData = UIImageJPEGRepresentation(_iconImageView.image, 0.1);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    if(!(_nameTextField.text.length>0))
    {
        [ProgressHUD showError:@"Fullname can not be empty"];
        return ;
    }
    if(!(_birthDay.titleLabel.text.length>0))
    {
        [ProgressHUD showError:@"Birthday can not be empty"];
        return ;
    }
    kSetDict(_nameTextField.text, @"fullName");
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_selectedBtn.tag] forKey:@"gender"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_hiddenSelectedBtn.tag] forKey:@"hiddenNote"];
    kSetDict(_bioTextField.text, @"info");
    kSetDict(_birthdayString, @"birthday");
    
    
    NSLog(@"hidden---------------------------------------> %ld",(long)_hiddenSelectedBtn.tag);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:10.0];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User/edit_user"];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:string parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:jsonData name:@"avatar_user" fileName:@"xx.jpg" mimeType:@"image/*"];
     }
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if([responseObject[@"code"] isEqual:@200])
          {
              hud.mode = MBProgressHUDModeText;
              hud.label.text = @"done!";
              [hud hideAnimated:YES afterDelay:1.0];
             // [[NSNotificationCenter defaultCenter] postNotificationName:KMainView_D_getAllData object:self];
              [self.navigationController popViewControllerAnimated:YES];
          }
          else
          {
              hud.mode = MBProgressHUDModeText;
              hud.label.text = responseObject[@"message"];
              [hud hideAnimated:YES afterDelay:1.0];
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          hud.mode = MBProgressHUDModeText;
          hud.label.text = @"try again!";
          [hud hideAnimated:YES afterDelay:1.0];
      }];
}



// Save data Btn
- (UIButton *)logOutBtn
{
    if(!_logOutBtn)
    {
        _logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logOutBtn.frame = CGRectMake(StartX,SCREEN_HEIGHT - 44 -64-5, SCREEN_WIDTH - 2*StartX , 44);
        _logOutBtn.layer.borderColor = [UIColor colorWithHex:@"#052aa7 "].CGColor;
        _logOutBtn.layer.borderWidth = 0.7;
        _logOutBtn.layer.cornerRadius = 5.0;
        _logOutBtn.backgroundColor = [UIColor colorWithHex:@"#052aa7 "];
        [_logOutBtn setTitle:@"Update" forState:UIControlStateNormal];
        _logOutBtn.titleLabel.font =KICON_FONT_(15);
        [_logOutBtn setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal ];
        _logOutBtn.centerX = SCREEN_WIDTH/2;
        [_logOutBtn addTarget:self action:@selector(saveSettingBtnClikc) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_logOutBtn];

    }
    return _logOutBtn;
}


//  #052aa7
- (void)viewDidLoad {
    [super viewDidLoad];
    [self logOutBtn];
    [self backScrollView];
    [self getAllData];
    self.title=@"Setting";
    
    
    
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self action:@selector(deconnexionClick)];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark
#pragma mark netWork
// Logout Btn Click
-(void)deconnexionClick
{
    NSLog(@"click log out");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Please wait!";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"user/login_out"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:Klogin_status];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KSESSION_ID];
            [hud hideAnimated:YES afterDelay:0.3];
           // LoginViewController *VC = [[LoginViewController alloc] init];
            MainPageViewController *VC = [[MainPageViewController alloc] init];
            UINavigationController *naVc = [[UINavigationController alloc] initWithRootViewController:VC];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = naVc;
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
            [hud hideAnimated:YES afterDelay:0.3];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}


// get data from server

- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User_infos/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _personCenter_MyData = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            _myData = _personCenter_MyData;
            [self viewImg];
            [self nameView];
            [self sexViewBg];
            [self hiddenView];
            [self bioView];
            [self bottomView];

            _selectedBtn.backgroundColor = KTHEME_COLOR;
            _selectedBtn.selected = YES;
            
            
            _hiddenSelectedBtn.backgroundColor = KTHEME_COLOR;
            _hiddenSelectedBtn.selected = YES;
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [ProgressHUD showError:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}




- (void)addAvatarUserClic
{
    DLog(@"Avatar");
    if (!_imagePicker) {
        _imagePicker = [[MyImagePicker alloc] initWithTitle:@"choose" forController:self delegate:self];
    }else{
        [_imagePicker show];
    }
}
-(void)myImagePickerDidSlectedImage:(UIImage *)image info:(NSDictionary *)info
{
    if(image)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 裁剪
            VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image
                                                                                                  cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
            imgEditorVC.delegate = self;
            [self presentViewController:imgEditorVC animated:YES completion:^{
                // TO DO
            }];
        });
        
    }
}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    _iconImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)birthDayButtonClick
{
    if (!_datePicker) {
        _datePicker = [[MyDatePicker alloc]init];
        _datePicker.delegate = self;
        [_datePicker showWithDatePickerMode:UIDatePickerModeDate];
    }else{
        [_datePicker open];
    }
}
#pragma mark myDatePicker
-(void)myDatePickerDidSelectedDate:(NSDate *)selectedDate
{
    NSString *dataString = [PublicMethod getDateUsingDate:selectedDate];
    _birthdayString = [PublicMethod getCreateTimeWithDate:selectedDate];
    dataString = [dataString substringToIndex:10];
    [_birthDay setTitle:dataString forState:UIControlStateNormal];
    
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
    
    [_nameTextField resignFirstResponder];
    [_bioLabelText resignFirstResponder];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}





#pragma mark - notification

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                     }
                     completion:^(BOOL finished) {}];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.view setFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HEIGHT-64)];
                     }
                     completion:^(BOOL finished) {}];
}




@end
