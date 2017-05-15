//
//  signup_last.m
//  HHSD
//
//  Created by alain serge on 3/21/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "signup_last.h"
#import "MyImagePicker.h"
#import "VPImageCropperViewController.h"
#import "MyPicker.h"
#import "MyDatePicker.h"
#import "SignupProfileCell.h"
#import "WDTabBarViewController.h"
#import "AppDelegate.h"
#import "OccupationViewController.h"
#import "fullNameViewController.h"
#import "nationalityViewController.h"
#import "CountryViewController.h"

@interface signup_last ()<MyImagePickerDelegate,VPImageCropperDelegate,UITableViewDataSource,UITableViewDelegate, MyDatePickerDelegate,MyPickerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Student_Details *personCenter_MyData;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *headBtn;
@property (nonatomic, strong) MyImagePicker *imagePicker;
@property (nonatomic, strong) UIButton *tuiChuBtn,*valideBtn;
@property (nonatomic, strong) MyDatePicker *datePicker;
@property (nonatomic, copy) NSString *birthdayString;
@property (nonatomic, strong) MyPicker *picker;


@end

@implementation signup_last

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Confirm your Profile";
    self.view.backgroundColor = KTHEME_COLOR;
    
    [self tableView];
    [self valideBtn];
    self.leftBackBtn.hidden = NO;

    //Hide Top bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
    
    
    __weak typeof(self) weakself = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakself getAllData];
    }];
    
    //[self.tableView.header beginRefreshing];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getAllData];
    self.leftBackBtn.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES ];
}


#pragma mark
#pragma mark sex
- (void)sexBtnclick
{
    if(!_picker)
    {
        _picker = [[MyPicker alloc] init];
        _picker.delegate = self;
    }
    _picker.pickerTag = 0;
    [_picker showWithTitle:@"sex" nameArray:@[@"boy",@"girl",@"other"]];
}

-(void)myPicker:(MyPicker *)picker didPickRow:(NSInteger)row
{
}

-(void)myPicker:(MyPicker *)picker willPickRow:(NSInteger)row
{
    [picker close];
    _personCenter_MyData.sex = [NSString stringWithFormat:@"%ld",(long)row];
    [self.tableView reloadData];
}

#pragma mark
#pragma mark birthDay
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
-(void)myDatePickerDidSelectedDate:(NSDate *)selectedDate {
    NSTimeInterval timeSelect = [selectedDate timeIntervalSince1970];
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    NSTimeInterval timeNow = [localeDate timeIntervalSince1970];
    
    if (timeSelect - timeNow > 0) {
        [ProgressHUD showError:@"enter your birthday"];
        return;
    }
    NSString *dataString = [PublicMethod getCreateTimeWithDate:selectedDate];
    _personCenter_MyData.birthday = [dataString copy];
    [self.tableView reloadData];
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return 6;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)
                                   backgroundColor:KTHEME_COLOR];
    return backView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celliden = @"MyProfileCell";
    SignupProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:celliden];
    if (!cell) {
        cell = [[SignupProfileCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:celliden];
    }
    
    cell.backgroundColor = KCOLOR_WHITE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self topView];
                    [cell addSubview:_topView];
                }
                    break;
                case 1:
                {
                    cell.titleLabel.text = @"\U0000e75c fullname";
                    cell.titleLabel.tintColor =KCOLOR_RED;
                    if (_personCenter_MyData.realname) {
                        cell.contentLabel.text = _personCenter_MyData.realname;
                    }else{
                        cell.contentLabel.text = @"";
                    }

                }
                    break;
                case 2:
                {
                    cell.titleLabel.text = @"Gender";
                    cell.titleLabel.tintColor =KCOLOR_BLUE;

                    if([_personCenter_MyData.sex isEqualToString:@"0"])
                    {
                        cell.contentLabel.text = @"\U0000e6bf";
                        
                    }else if ([_personCenter_MyData.sex isEqualToString:@"1"])
                    {
                        cell.contentLabel.text = @"\U0000e60f";
                    }else if ([_personCenter_MyData.sex isEqualToString:@"2"])
                    {
                        cell.contentLabel.text = @"\U0000e690";
                    }
                }
                    break;
                case 3:
                {
                    cell.titleLabel.text = @"\U0000e771  birthday";
                    cell.titleLabel.tintColor =KCOLOR_GREEN;
                    if (_personCenter_MyData.birthday) {
                        cell.contentLabel.text = [PublicMethod getYMDUsingCreatedTimestamp:_personCenter_MyData.birthday];
                    }else{
                        cell.contentLabel.text = @"";
                    }
                    

                }
                    break;
                    
                case 4:
                {
                    cell.titleLabel.text = @"\U0000e751 Occupation";
                    cell.titleLabel.tintColor =KTHEME_COLOR;

                    
                    if([_personCenter_MyData.profession isEqualToString:@"0"])
                    {
                        cell.contentLabel.text = @"Student";
                        
                    }
                    else if ([_personCenter_MyData.profession isEqualToString:@"1"])
                    {
                        cell.contentLabel.text = @"Teacher";
                    }
                    else if ([_personCenter_MyData.profession isEqualToString:@"2"])
                    {
                        cell.contentLabel.text = @"Searcher";
                    }
                    else if ([_personCenter_MyData.profession isEqualToString:@"3"])
                    {
                        cell.contentLabel.text = @"Visitor";
                    }
                    else if ([_personCenter_MyData.profession isEqualToString:@"4"])
                    {
                        cell.contentLabel.text = @"Other";
                    }
                }
                    break;
                    
                case 5:
                {
                    cell.titleLabel.text = @"\U0000e781  My country";
                    
                    if (_personCenter_MyData.country) {
                        cell.contentLabel.text = _personCenter_MyData.country;
                    }else{
                        cell.contentLabel.text = @"";
                    }

                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        
        default:
            break;
    }
    
    
    return cell;
    
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0 && indexPath.row ==0)
    {
        return 150;
    }
    return sss;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    // avatar
                }
                    break;
                case 1:
                {
                    fullNameViewController *vc = [[fullNameViewController alloc] init];
                    vc.sess_id = _sess_ID;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                {
                    [self sexBtnclick];
                }
                    break;
                case 3:
                {
                    [self birthDayButtonClick];
                }
                    break;
                    
                case 4:
                {
                    OccupationViewController *vc = [[OccupationViewController alloc] init];
                    vc.sess_id = _sess_ID;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case 5:
                {
                    CountryViewController *vc = [[CountryViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
                default:
            break;
    }
}
#pragma mark
#pragma mark othetAction
#pragma mark OtherAction
- (void)headBtnClick
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
#pragma mark UIViewInit
- (UIView *)topView
{
    if(!_topView)
    {
        _topView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)
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
            
            [_iconImageView bk_whenTapped:^{
                [self headBtnClick];
            }];
        }
        if(!_headBtn)
        {
            _headBtn = [[UIButton alloc] initWithFrame:CGRectMake(_iconImageView.frame.size.width + _iconImageView.frame.origin.x- 20,
                                                                  30,
                                                                  25,
                                                                  25)];
            _headBtn.layer.cornerRadius =_headBtn.frame.size.height/2;
            _headBtn.layer.masksToBounds = YES;
            _headBtn.backgroundColor  = KCOLOR_WHITE;
            [_headBtn setBackgroundImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
            [_headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            [self.topView addSubview:_headBtn];
        }
    }
    return _topView;
}
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64-64)
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = KTHEME_COLOR;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.hidden = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIButton *)valideBtn
{
    if(!_valideBtn)
    {
        _valideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _valideBtn.frame = CGRectMake(20,SCREEN_HEIGHT - 64 - 44 - 20, SCREEN_WIDTH - 2*20 , 44);
        _valideBtn.layer.borderColor = [UIColor colorWithHex:@"#041193 "].CGColor;
        _valideBtn.layer.borderWidth = 0.7;
        _valideBtn.layer.cornerRadius = 5.0;
        _valideBtn.backgroundColor = [UIColor colorWithHex:@"#041193 "];
        [_valideBtn setTitle:@"Finish" forState:UIControlStateNormal];
        _valideBtn.titleLabel.font =[UIFont boldSystemFontOfSize:20];
        [_valideBtn setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal ];
        _valideBtn.centerX = SCREEN_WIDTH/2;
        [self.view addSubview:_valideBtn];
        [_valideBtn addTarget:self action:@selector(valideClickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _valideBtn;
}

#pragma mark
#pragma mark- barButtonClick
- (void)valideClickBtn
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Please wait!";
    
    NSData* data = UIImageJPEGRepresentation(_iconImageView.image, 0.1);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_personCenter_MyData.birthday forKey:@"birthday"];
    [params setObject:_personCenter_MyData.sex forKey:@"sex"];


    kSetDict(self.sess_id, @"sess_id");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User/update_basic"];
    
    //imageData
    NSMutableArray *dataArray = [NSMutableArray array];
    
       [dataArray addObject:data];
    
    [[NetWork shareInstance] netWorkWithUrl:string
                                     params:params dataArray:dataArray
                                   fileName:@"head_image" sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       if([[responseObject objectForKey:@"code"] isEqual:@200])
                                       {
                                           [self MBShowHint:@"Congratulations on your successful login"];
                                           AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                           delegate.windowController = nil;
                                           WDTabBarViewController *tabbar = [[WDTabBarViewController alloc] init];
                                           delegate.windowController = [[UINavigationController alloc] initWithRootViewController:tabbar];
                                           delegate.windowController.navigationBarHidden = YES;
                                           delegate.window.rootViewController = delegate.windowController;
                                           
                                       }
                                       else
                                       {
                                           [hud hideAnimated:YES afterDelay:1.0];
                                           
                                       }
                                   } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                                       hud.mode = MBProgressHUDModeText;
                                       hud.label.text = PromptMessage;
                                       [hud hideAnimated:YES afterDelay:1.0];
                                       
                                   }];
}



#pragma mark
#pragma mark ----- getAllData -----
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User_infos/basic_infos"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.tableView.header endRefreshing];
        _personCenter_MyData = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _tableView.hidden = NO;
            _personCenter_MyData = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_personCenter_MyData.head_image]]
                              placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")]];
            [self.tableView reloadData];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView.header endRefreshing];
    }];
}










@end
