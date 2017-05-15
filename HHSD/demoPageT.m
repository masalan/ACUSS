//
//  demoPageT.m
//  HHSD
//
//  Created by alain serge on 3/25/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "demoPageT.h"
#import "MyImagePicker.h"
#import "MyDatePicker.h"
#import "VPImageCropperViewController.h"

#define SW2 SCREEN_WIDTH/2
#define SW3 SCREEN_WIDTH/3

@interface demoPageT()<MyImagePickerDelegate,MyDatePickerDelegate,VPImageCropperDelegate>
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *topView,*viewImg;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIButton *birthDay;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *sexView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) MyImagePicker *imagePicker;
@property (nonatomic, strong) MyDatePicker *datePicker;
@property (nonatomic, strong) Student_Details *personCenter_MyData;
@property (nonatomic, copy) NSString *birthdayString;

@end
@implementation demoPageT
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
        _viewImg = [UIView createViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SW2) backgroundColor:KCOLOR_CLEAR];
        
        {
            _iconImageView = [UIImageView createImageViewWithFrame:CGRectMake(0, 17, SW3, SW3)
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
            [btn addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
            [_iconImageView addSubview:btn];
            _iconImageView.userInteractionEnabled = YES;
            [_viewImg addSubview:_iconImageView];
        }
        
        [self.view addSubview:_viewImg];
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
                                                    text:@"\U0000e75c Full name"];
        [_topView addSubview:nicheng];
        
        if(!_nameTextField)
        {
            _nameTextField = [UITextField createTextFieldWithFrame:CGRectMake(20, 25, SCREEN_WIDTH - 40, 44)
                                                   backgroundColor:KCOLOR_WHITE
                                                       borderStyle:UITextBorderStyleRoundedRect
                                                       placeholder:@""
                                                              text:@""
                                                         textColor:KCOLOR_Black_343434
                                                              font:KSYSTEM_FONT_(15)
                                                     textalignment:NSTextAlignmentLeft];
            _nameTextField.layer.borderWidth = 1.0;
            _nameTextField.layer.borderColor = KCOLOR_Line_Color.CGColor;
            _nameTextField.layer.cornerRadius = 5.0;
            _nameTextField.text = _myData.fullName;
            [_topView addSubview:_nameTextField];
        }
    }
    return _topView;
}
- (UIView *)centerView
{
    if(!_centerView)
    {
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.bottom, SCREEN_WIDTH, 80)];
        _centerView.backgroundColor = KCOLOR_WHITE;
        [self.view addSubview:_centerView];
        UILabel *nicheng = [UILabel createLabelWithFrame:CGRectMake(20, 0, 100, 20)
                                         backgroundColor:KCOLOR_WHITE
                                               textColor:KCOLOR_Black_343434
                                                    font:KSYSTEM_FONT_(15)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@"Gender"];
        [_centerView addSubview:nicheng];
        if(!_sexView)
        {
            _sexView = [UIView createViewWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 44)
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
                [btn addTarget:self action:@selector(sexBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_sexView addSubview:btn];
            }];
            [_centerView addSubview:_sexView];
        }
    }
    return _centerView;
}
- (UIView *)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _centerView.bottom, SCREEN_WIDTH, 80)];
        _bottomView.backgroundColor = KCOLOR_WHITE;
        UILabel *nicheng = [UILabel createLabelWithFrame:CGRectMake(20, 0, 100, 20)
                                         backgroundColor:KCOLOR_WHITE
                                               textColor:KCOLOR_Black_343434
                                                    font:KICON_FONT_(15)
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
        [self.view addSubview:_bottomView];
        
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料修改";
    self.view.backgroundColor = KCOLOR_WHITE;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Ok" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick)];
    
    [self getAllData];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
            //[self iconImageView];
            [self topView];
            [self centerView];
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
- (void)barButtonClickk
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Please wait!";
    
    NSData* data = UIImageJPEGRepresentation(_iconImageView.image, 0.1);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.sess_id, @"sess_id");
    
    
    if(!(_nameTextField.text.length>0))
    {
        [ProgressHUD showError:@"昵称不能为空"];
        return ;
    }
    if(!(_birthDay.titleLabel.text.length>0))
    {
        [ProgressHUD showError:@"生日不能为空"];
        return ;
    }
    
    kSetDict(_nameTextField.text, @"fullName");
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_selectedBtn.tag] forKey:@"gender"];
    kSetDict(_birthdayString, @"birthday");
    
    NSLog(@"sex--------------->%ld",(long)_selectedBtn.tag);
    
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User/edit_user"];
    
    //imageData
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:data];
    [[NetWork shareInstance] netWorkWithUrl:string
                                     params:params dataArray:dataArray
                                   fileName:@"avatar_user" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
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
                   hud.label.text = responseObject[@"message"];
                   [hud hideAnimated:YES afterDelay:1.0];
               }
           } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
               hud.mode = MBProgressHUDModeText;
               hud.label.text = PromptMessage;
               [hud hideAnimated:YES afterDelay:1.0];
               
           }];
}


- (void)barButtonClick
{
    DLog(@"保存");
    NSData *jsonData = UIImageJPEGRepresentation(_iconImageView.image, 0.1);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    if(!(_nameTextField.text.length>0))
    {
        [ProgressHUD showError:@"昵称不能为空"];
        return ;
    }
    if(!(_birthDay.titleLabel.text.length>0))
    {
        [ProgressHUD showError:@"生日不能为空"];
        return ;
    }
    kSetDict(_nameTextField.text, @"fullName");
    [params setObject:[NSString stringWithFormat:@"%ld",(long)_selectedBtn.tag] forKey:@"gender"];
    kSetDict(_birthdayString, @"birthday");
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
              hud.label.text = @"恭喜你,保存成功";
              [hud hideAnimated:YES afterDelay:1.0];
              [[NSNotificationCenter defaultCenter] postNotificationName:KMainView_D_getAllData object:self];
              [self.navigationController popViewControllerAnimated:YES];
          }
          else
          {
              hud.mode = MBProgressHUDModeText;
              hud.label.text = responseObject[@"message"];
              [hud hideAnimated:YES afterDelay:2.0];
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          hud.mode = MBProgressHUDModeText;
          hud.label.text = @"数据请求失败,请重试";
          [hud hideAnimated:YES afterDelay:2.0];
      }];
}














- (void)iconClick
{
    DLog(@"头像");
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




@end
