//
//  AddMyBackground.m
//  HHSD
//
//  Created by alain serge on 3/26/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "AddMyBackground.h"

#import "demoPageT.h"
#import "MyImagePicker.h"
#import "VPImageCropperViewController.h"

#define SW2 SCREEN_WIDTH/2
#define SW3 SCREEN_WIDTH/3
#define distance (SCREEN_HEIGHT/2)+20
#define avatar (SCREEN_WIDTH/2)-20
#define LabelWidth SCREEN_WIDTH/3-imageView.right-15


@interface AddMyBackground()<MyImagePickerDelegate,VPImageCropperDelegate>
@property (nonatomic, strong) UIImageView *iconImageView,*bgImg;
@property (nonatomic, strong) UIView *topView,*viewImg;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIButton *birthDay;
@property (nonatomic, strong) UIView *sexView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) MyImagePicker *imagePicker;
@property (nonatomic, strong) Student_Details *personCenter_MyData;
@property (nonatomic, copy) NSString *birthdayString;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;


@end
@implementation AddMyBackground
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _birthdayString = @"";
    }
    return self;
}

-(UIView *)viewImg
{
    if (!_viewImg)
    {
        _viewImg = [UIView createViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,distance) backgroundColor:KCOLOR_RED];
        
        {
            UILabel *IconAdd = [UILabel createLabelWithFrame:CGRectMake(SW2-20,(distance/2)-20,40, 40)
                                             backgroundColor:KCOLOR_CLEAR
                                                   textColor:KCOLOR_WHITE
                                                        font:KICON_FONT_(20)
                                               textalignment:NSTextAlignmentLeft
                                                        text:@"\U0000e6db"];
            [_viewImg addSubview:IconAdd];
            
            _iconImageView = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, distance)
                                                   backgroundColor:KCOLOR_WHITE
                                                             image:nil];
            _iconImageView.backgroundColor = KCOLOR_CLEAR;
            
            _iconImageView.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_myData.bg_image]]
                              placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")]];
            UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(0, 0, SCREEN_WIDTH, distance)
                                            backgroundColor:KCOLOR_CLEAR image:nil];
            [btn setTitle:nil forState:UIControlStateNormal];
            [btn setTitleColor:KCOLOR_CLEAR forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
            [_iconImageView addSubview:btn];
            _iconImageView.userInteractionEnabled = YES;
            [_viewImg addSubview:_iconImageView];
        }
        
        [self.backScrollView  addSubview:_viewImg];
    }
    
    return _viewImg;
}


- (UIView *)topView
{
    if(!_topView)
    {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, _viewImg.bottom, SCREEN_WIDTH, 80)];
        _topView.backgroundColor = KCOLOR_WHITE;
        [self.view addSubview:_topView];
        UILabel *nicheng = [UILabel createLabelWithFrame:CGRectMake(20, 0, 100, 20)
                                         backgroundColor:KCOLOR_WHITE
                                               textColor:KCOLOR_Black_343434
                                                    font:KICON_FONT_(15)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@"\U0000e6db name"];
        [_topView addSubview:nicheng];
        
        if(!_nameTextField)
        {
            _nameTextField = [UITextField createTextFieldWithFrame:CGRectMake(20, 25, SCREEN_WIDTH - 40, 44)
                                                   backgroundColor:KCOLOR_WHITE
                                                       borderStyle:UITextBorderStyleRoundedRect
                                                       placeholder:@"Background image Name"
                                                              text:@""
                                                         textColor:KCOLOR_Black_343434
                                                              font:KSYSTEM_FONT_(15)
                                                     textalignment:NSTextAlignmentLeft];
            _nameTextField.layer.borderWidth = 1.0;
            _nameTextField.layer.borderColor = KCOLOR_Line_Color.CGColor;
            _nameTextField.layer.cornerRadius = 5.0;
            //_nameTextField.text = _myData.fullName;
            [_topView addSubview:_nameTextField];
        }
        [self.backScrollView  addSubview:_topView];

    }
    return _topView;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backScrollView];

    
    self.title = @"Add background";
    self.view.backgroundColor = KCOLOR_WHITE;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Ok" style:UIBarButtonItemStylePlain target:self action:@selector(saveBgImage)];
    
    [self getAllData];
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
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}




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
            [self topView];
            [self bottomView];
            _selectedBtn.backgroundColor = KTHEME_COLOR;
            _selectedBtn.selected = YES;
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [ProgressHUD showError:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}




#pragma mark
#pragma mark ----- otherAction -----
- (void)sexBtnClick:(UIButton *)sender
{
    _selectedBtn.selected = NO;
    _selectedBtn.backgroundColor = KCOLOR_GRAY_f5f5f5;
    sender.backgroundColor = KTHEME_COLOR;
    sender.selected = YES;
    _selectedBtn = sender;
}


- (void)saveBgImage
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Please wait!";
    
    NSData* data = UIImageJPEGRepresentation(_iconImageView.image, 0.1);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.sess_id, @"sess_id");
    
    [params setObject:_nameTextField.text forKey:@"name"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_selectedBtn.tag] forKey:@"is_open"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Background/add_bg"];
    //imageData
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:data];
    [[NetWork shareInstance] netWorkWithUrl:string
                                     params:params dataArray:dataArray
                                   fileName:@"bg_image" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
           if([[responseObject objectForKey:@"code"] isEqual:@200])
           {
               [[NSNotificationCenter defaultCenter] postNotificationName:KMainView_D_getAllData object:self];
               [self MBShowSuccess:@"Succes"];
               [hud hideAnimated:YES afterDelay:0.5];
               [self.navigationController popViewControllerAnimated:YES];
           }
           else
           {
               hud.mode = MBProgressHUDModeText;
               hud.label.text  = responseObject[@"message"];
               [hud hideAnimated:YES afterDelay:1.0];
           }
       } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
           hud.mode = MBProgressHUDModeText;
           hud.label.text  = PromptMessage;
           [hud hideAnimated:YES afterDelay:1.0];
           
       }];
}





- (void)iconClick
{
    DLog(@"");
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

@end
