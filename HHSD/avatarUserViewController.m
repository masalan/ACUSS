//
//  avatarUserViewController.m
//  HHSD
//
//  Created by alain serge on 3/24/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "avatarUserViewController.h"
#import "MyImagePicker.h"
#import "VPImageCropperViewController.h"
#import "MyPicker.h"
#import "MyDatePicker.h"

@interface avatarUserViewController ()<MyImagePickerDelegate,VPImageCropperDelegate>
@property (nonatomic, strong) UIImageView *iconImageView,*IconeCamera;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *headBtn;
@property (nonatomic, strong) MyImagePicker *imagePicker;
@property (nonatomic, strong) Student_Details *personCenter_MyData;

@end

@implementation avatarUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self topView];
    [self getAllData];

    UIButton *leftBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 30)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(15)
                                                  title:@"OK"];
    [leftBtn addTarget:self action:@selector(savaMyAvatar) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getAllData];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES ];
}


- (UIView *)topView
{
    if(!_topView)
    {
        _topView = [UIView createViewWithFrame:CGRectMake(0,(SCREEN_HEIGHT/2)-150, SCREEN_WIDTH, 150)
                               backgroundColor:KTHEME_COLOR];
        UIImageView *backImageView = [UIImageView createImageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)
                                                           backgroundColor:KTHEME_COLOR
                                                                     image:[UIImage imageNamed:@"AboutMe_MyResource"]];
        [_topView addSubview:backImageView];
        
        if(!_iconImageView)
        {
            _iconImageView = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 15, 120, 120)];
            _iconImageView.centerX = SCREEN_WIDTH/2;
            _iconImageView.centerY = _topView.height /2 - 10;
            _iconImageView.backgroundColor = KCOLOR_WHITE;
            _iconImageView.layer.borderColor = KCOLOR_WHITE.CGColor;
            _iconImageView.layer.borderWidth = 3.0;
            _iconImageView.layer.cornerRadius = _iconImageView.frame.size.height/2;
            _iconImageView.layer.masksToBounds = YES;
            _iconImageView.userInteractionEnabled = YES;
            _iconImageView.image = [UIImage imageNamed:@"headIcon-3"];
            [self.topView addSubview:_iconImageView];
            
            UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(0, _iconImageView.height - 23, 120, 20)
                                               backgroundColor:KCOLOR_BLACK
                                                     textColor:KCOLOR_WHITE
                                                          font:KICON_FONT_(15)
                                                 textalignment:NSTextAlignmentCenter
                                                          text:@"\U0000e603"];
            nameLabel.alpha = 0.7;
            [_iconImageView addSubview:nameLabel];
            
           
        }
        
        // IconeCamera
        if(!_IconeCamera)
        {
            _IconeCamera = [[UIImageView alloc]  initWithFrame:CGRectMake(_iconImageView.frame.size.width + _iconImageView.frame.origin.x- 20,
                                                                          30,
                                                                          25,
                                                                          25)];
            _IconeCamera.backgroundColor = KCOLOR_WHITE;
            _IconeCamera.layer.borderColor = KCOLOR_WHITE.CGColor;
            _IconeCamera.layer.borderWidth = 3.0;
            _IconeCamera.layer.cornerRadius = _IconeCamera.frame.size.height/2;
            _IconeCamera.layer.masksToBounds = YES;
            _IconeCamera.userInteractionEnabled = YES;
            _IconeCamera.image = [UIImage imageNamed:@"camera"];
            [self.topView addSubview:_IconeCamera];
        }
        
        
        
        
        
        
        if(!_headBtn)
        {
            _headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            _headBtn.layer.masksToBounds = YES;
            _headBtn.backgroundColor  = KCOLOR_WHITE;
            [_headBtn setBackgroundColor:KCOLOR_CLEAR];
            [_headBtn addTarget:self action:@selector(avatarModify) forControlEvents:UIControlEventTouchUpInside];
            
            [self.topView addSubview:_headBtn];
        }
        [self.view addSubview:self.topView];

    }
    return _topView;
}

#pragma mark
#pragma mark othetAction
#pragma mark OtherAction
- (void)avatarModify
{
    
    if (!_imagePicker) {
        _imagePicker = [[MyImagePicker alloc]initWithTitle:@"select Avatar" forController:self delegate:self];
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
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [_iconImageView setImage:editedImage];
        //        _isSendImage = YES;
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark
#pragma mark- barButtonClick
- (void)savaMyAvatar
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Please wait!";
    
    NSData* data = UIImageJPEGRepresentation(_iconImageView.image, 0.1);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.sess_id, @"sess_id");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User/avatar_user"];
    
    //imageData
    NSMutableArray *dataArray = [NSMutableArray array];
    
    
    
    [dataArray addObject:data];
    
    [[NetWork shareInstance] netWorkWithUrl:string
                                     params:params dataArray:dataArray
                                   fileName:@"avatar_user" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       if([[responseObject objectForKey:@"code"] isEqual:@200])
                                       {
                                           [[NSNotificationCenter defaultCenter] postNotificationName:KMainView_D_getAllData object:self];
                                           [hud hideAnimated:YES afterDelay:0.5];
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }
                                       else
                                       {
                                           [hud hideAnimated:YES afterDelay:0.5];
                                           
                                       }
                                   } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                                       hud.mode = MBProgressHUDModeText;
                                       hud.label.text = PromptMessage;
                                       [hud hideAnimated:YES afterDelay:0.5];
                                       
                                   }];
}



#pragma mark
#pragma mark ----- getAllData -----
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
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_personCenter_MyData.avatar_user]]
                              placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")]];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {

        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {

    }];
}












@end
