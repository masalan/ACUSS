//
//  applyForMajor.m
//  HHSD
//
//  Created by alain serge on 4/18/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "applyForMajor.h"

#import "addMajorProgram.h"
#import "MainView_A.h"
#import "MyDatePicker.h"
#define StartX 10
#define KborderWidth 1.5
#define ADD_IMAGE_DEFALUT_IMAGE [UIImage imageNamed:@"add"]

@interface applyForMajor ()<UITextViewDelegate,MyPickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UILabel *timeLabel,*endtimeLabel;
@property (nonatomic, strong) UIButton * addressButton;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton * serviceTypeButton;
@property (nonatomic, strong) UILabel *serviceTypeLabel;
//@property (nonatomic, strong) UIButton * serviceContentButton;
@property (nonatomic, strong) UILabel *serviceContentLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *LangLabel,*yearslabel;
@property (nonatomic, strong) UITextView *thirdTextView,*feeTextView,*langTextView,*serviceContentButton,*timeButton,*endtimeButton;
@property (nonatomic, strong) UILabel *placeHoderLabel,*feeLabel,*langLabel;
@property (nonatomic, strong) UILabel *addImageView;
@property (nonatomic, strong) UIButton *submitOrderButton;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) MyPicker *picker;
@property (nonatomic, copy) NSString *topType_cateid;
@property (nonatomic, copy) NSString *secondType_cateid,*cycleID,*schoolID;
@property (nonatomic, copy) NSString *visit_time;
@property (nonatomic, assign) CGFloat keyboardRect_height;
@property (nonatomic,strong ) NSMutableArray           *imageArray;
@property (nonatomic, strong) UIView *topheader;
@property (nonatomic, strong) UILabel *schoolNameLabel,*cycleNameLabel,*majorNameLabel,*feeNameLabel;
@property (nonatomic, strong) School_Details *schoolDetail;
@property (nonatomic, assign) NSUInteger selectedBtn;
@property (nonatomic, copy) NSString *startTimeStamp, *endTimeStamp, *upToTimeStamp,*uploadImage;
@property (nonatomic, strong) propertyService_topCategory_List *propertyService_topCategory_List;
@property (nonatomic, strong) propertyService_secondCategory_List *propertyService_secondCategory_List;
@property (nonatomic, strong) Teaching_languages_List *language_List;
@property (nonatomic, strong) Duration_study_List *year_List;


@end

@implementation applyForMajor
@synthesize params;


- (instancetype)init
{
    self = [super self];
    if(self)
    {
        _topType_cateid = @"";
        _secondType_cateid = @"";
        _visit_time = @"";
        _startTimeStamp = @"";
        _endTimeStamp = @"";
        _imageArray = [NSMutableArray arrayWithObjects:ADD_IMAGE_DEFALUT_IMAGE, nil];
    }
    return self;
}


-(UIView *)topheader
{
    _topheader = [UIView createViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 145) backgroundColor:KTHEME_COLOR];
    if (!_schoolNameLabel)
    {
        _schoolNameLabel = [UILabel createLabelWithFrame:CGRectMake(10, 0,SCREEN_WIDTH-20,50)
                                         backgroundColor:KCOLOR_CLEAR
                                               textColor:KCOLOR_WHITE
                                                    font:KICON_FONT_(15)
                                           textalignment:NSTextAlignmentCenter
                                                    text:nil];
        _schoolNameLabel.numberOfLines = 2;
        [_topheader addSubview:_schoolNameLabel];
        
    }
    if (!_cycleNameLabel)
    {
        _cycleNameLabel = [UILabel createLabelWithFrame:CGRectMake(10,_schoolNameLabel.bottom,SCREEN_WIDTH-20,20)
                                         backgroundColor:KCOLOR_CLEAR
                                               textColor:KCOLOR_WHITE
                                                    font:KICON_FONT_(15)
                                           textalignment:NSTextAlignmentCenter
                                                   text:nil];
        _cycleNameLabel.numberOfLines = 2;
        [_topheader addSubview:_cycleNameLabel];
    }
    if (!_majorNameLabel)
    {
        _majorNameLabel = [UILabel createLabelWithFrame:CGRectMake(10,_cycleNameLabel.bottom,SCREEN_WIDTH-20,30)
                                        backgroundColor:KCOLOR_CLEAR
                                              textColor:KCOLOR_WHITE
                                                   font:KICON_FONT_(12)
                                          textalignment:NSTextAlignmentCenter
                                                   text:nil];
        _majorNameLabel.numberOfLines = 2;
        [_topheader addSubview:_majorNameLabel];
    }
    
    if (!_feeNameLabel)
    {
        _feeNameLabel = [UILabel createLabelWithFrame:CGRectMake(10,_majorNameLabel.bottom,SCREEN_WIDTH-20,20)
                                        backgroundColor:KCOLOR_CLEAR
                                              textColor:KCOLOR_WHITE
                                                   font:KICON_FONT_(15)
                                          textalignment:NSTextAlignmentCenter
                                                 text:nil];
        _feeNameLabel.numberOfLines = 2;
        [_topheader addSubview:_feeNameLabel];
    }
    
    [self.backScrollView addSubview:_topheader];
    return _topheader;
}

// My name
- (UITextView *)serviceContentButton
{
    if(!_serviceContentButton )
    {
        _serviceContentButton = [[UITextView alloc] initWithFrame:CGRectMake(StartX,150, SCREEN_WIDTH - StartX*2, 44)];
        _serviceContentButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _serviceContentButton.layer.borderWidth = KborderWidth;
        _serviceContentButton.textColor = KCOLOR_Black_343434;
        _serviceContentButton.font = kAutoFont_(14);
        _serviceContentButton.layer.borderWidth = 1;
        _serviceContentButton.layer.cornerRadius = 8;
        
        if(!_serviceContentLabel)
        {
            _serviceContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(StartX, 2, SCREEN_WIDTH-StartX*2, 35)];
            _serviceContentLabel.textAlignment = NSTextAlignmentCenter;
            _serviceContentLabel.textColor= KTHEME_COLOR;
            _serviceContentLabel.font = kAutoFont_(15);
            _serviceContentLabel.numberOfLines = 4;
            [_serviceContentButton addSubview:_serviceContentLabel];

        }
        _serviceContentButton.delegate = self;
        [self.backScrollView addSubview:_serviceContentButton];
        
    }
    return _serviceContentButton;
}


//birthday
- (UITextView *)timeButton
{
    if(!_timeButton )
    {
        _timeButton = [[UITextView alloc] initWithFrame:CGRectMake(StartX,199, SCREEN_WIDTH - StartX*2, 44)];
        _timeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _timeButton.layer.borderWidth = KborderWidth;
        _timeButton.textColor = KCOLOR_Black_343434;
        _timeButton.font = kAutoFont_(14);
        _timeButton.layer.borderWidth = 1;
        _timeButton.layer.cornerRadius = 8;
        
        if(!_yearslabel)
        {
            _yearslabel = [[UILabel alloc] initWithFrame:CGRectMake(StartX, 2, SCREEN_WIDTH-StartX*2, 35)];
            _yearslabel.textAlignment = NSTextAlignmentCenter;
            _yearslabel.textColor= KTHEME_COLOR;
            _yearslabel.font = kAutoFont_(15);
            _yearslabel.numberOfLines = 4;
            [_timeButton addSubview:_yearslabel];
            
        }
        _timeButton.delegate = self;
        [self.backScrollView addSubview:_timeButton];
        
    }
    return _timeButton;
}


// My phone
- (UITextView *)endtimeButton
{
    if(!_endtimeButton )
    {
        _endtimeButton = [[UITextView alloc] initWithFrame:CGRectMake(StartX,248  , SCREEN_WIDTH - StartX*2, 44)];
        _endtimeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _endtimeButton.layer.borderWidth = KborderWidth;
        _endtimeButton.textColor = KCOLOR_Black_343434;
        _endtimeButton.font = kAutoFont_(14);
        _endtimeButton.layer.borderWidth = 1;
        _endtimeButton.layer.cornerRadius = 8;
        
        if(!_LangLabel)
        {
            _LangLabel = [[UILabel alloc] initWithFrame:CGRectMake(StartX, 2, SCREEN_WIDTH-StartX*2, 35)];
            _LangLabel.textAlignment = NSTextAlignmentCenter;
            _LangLabel.textColor= KTHEME_COLOR;
            _LangLabel.font = kAutoFont_(15);
            _LangLabel.numberOfLines = 4;
            [_endtimeButton addSubview:_LangLabel];
            
        }
        _endtimeButton.delegate = self;
        [self.backScrollView addSubview:_endtimeButton];
        
    }
    return _endtimeButton;
}


//feeTextView

- (UITextView *)feeTextView
{
    if(!_feeTextView )
    {
        _feeTextView = [[UITextView alloc] initWithFrame:CGRectMake(StartX,297  , SCREEN_WIDTH - StartX*2, 44)];
        _feeTextView.layer.borderColor = KTHEME_COLOR.CGColor;
        _feeTextView.layer.borderWidth = KborderWidth;
        _feeTextView.textColor = KCOLOR_Black_343434;
        _feeTextView.font = kAutoFont_(14);
        _feeTextView.textContentType = UITextContentTypeTelephoneNumber;
        _feeTextView.layer.borderWidth = 1;
        _feeTextView.layer.cornerRadius = 8;
        
        if(!_feeLabel)
        {
            _feeLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH-80, 35)];
            _feeLabel.text = @"Mother tongue";
            _feeLabel.textAlignment = NSTextAlignmentCenter;
            
            _feeLabel.textColor= KCOLOR_Line_Color;
            _feeLabel.font = kAutoFont_(12);
            [_feeTextView addSubview:_feeLabel];
            _feeLabel.numberOfLines = 4;
        }
        _feeTextView.delegate = self;
        [self.backScrollView addSubview:_feeTextView];
        
    }
    return _feeTextView;
}


- (UIButton *)serviceTypeButton
{
    if(!_serviceTypeButton)
    {
        _serviceTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,346, SCREEN_WIDTH - StartX*2, 44)];
        _serviceTypeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _serviceTypeButton.layer.borderWidth = KborderWidth;
        _serviceTypeButton.backgroundColor =KCOLOR_WHITE;
        
        _serviceTypeButton.layer.borderWidth = 1;
        _serviceTypeButton.layer.cornerRadius = 8;
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_serviceTypeButton.size.width  - 28, 12, 21, 21) backgroundColor:KCOLOR_WHITE textColor:KCOLOR_Line_Color font:KICON_FONT_(15) textalignment:NSTextAlignmentCenter text:@"\U0000e684"];
        label.centerY = _serviceTypeButton.size.height/2;
        [_serviceTypeButton addSubview:label];
        
        _serviceTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _serviceTypeButton.size.width - 40, 30)];
        _serviceTypeLabel.text = @"Program actual cycle";
        _serviceTypeLabel.textColor = KCOLOR_Line_Color;
        _serviceTypeLabel.font = kAutoFont_(14);
        _serviceTypeLabel.centerY = _serviceTypeButton.size.height/2;
        _serviceTypeLabel.textAlignment = NSTextAlignmentCenter;
        
        _serviceTypeButton.tag = 3;
        
        [_serviceTypeButton addTarget:self action:@selector(programCycleSchool) forControlEvents:UIControlEventTouchUpInside];
        [_serviceTypeButton addSubview:_serviceTypeLabel];
        [self.backScrollView addSubview:_serviceTypeButton];
    }
    return _serviceTypeButton;
}




// major
- (UITextView *)thirdTextView
{
    if(!_thirdTextView )
    {
        _thirdTextView = [[UITextView alloc] initWithFrame:CGRectMake(StartX,395, SCREEN_WIDTH - 2*StartX,44)];
        _thirdTextView.layer.borderColor = KTHEME_COLOR.CGColor;
        _thirdTextView.layer.borderWidth = KborderWidth;
        _thirdTextView.textColor = KCOLOR_Black_343434;
        _thirdTextView.font = kAutoFont_(14);
        
        
        _thirdTextView.layer.borderWidth = 1;
        _thirdTextView.layer.cornerRadius =8;
        
        
        if(!_placeHoderLabel)
        {
            _placeHoderLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH-80, 35)];
            _placeHoderLabel.text = @" Your actual major";
            _placeHoderLabel.textAlignment = NSTextAlignmentCenter;
            
            _placeHoderLabel.textColor= KCOLOR_Line_Color;
            _placeHoderLabel.font = kAutoFont_(12);
            [_thirdTextView addSubview:_placeHoderLabel];
            _placeHoderLabel.numberOfLines = 4;
        }
        _thirdTextView.delegate = self;
        [self.backScrollView addSubview:_thirdTextView];
        
    }
    return _thirdTextView;
}


- (UILabel *)addImageView
{
    if(!_addImageView)
    {
        UILabel *text = [UILabel createLabelWithFrame:CGRectMake(StartX,439, SCREEN_WIDTH-StartX*2,50)
                                      backgroundColor:KCOLOR_Clear
                                            textColor:KCOLOR_WHITE
                                                 font:KICON_FONT_(9)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"I hereby certify that all the above information is true and correct to the best of my knowledge and belief.I consent to this information being verified by you Check contacting me or to my  University  releasing any such information as requested."];
        text.numberOfLines = 4;
        
        _addImageView.backgroundColor = KCOLOR_WHITE;
        _addImageView.userInteractionEnabled = YES;
        [self.backScrollView addSubview:_addImageView];
        [self.backScrollView addSubview:text];
    }
    return _addImageView;
}

- (UIButton *)submitOrderButton
{
    if(!_submitOrderButton)
    {
        _submitOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _submitOrderButton.frame = CGRectMake(StartX,SCREEN_HEIGHT-64-50, SCREEN_WIDTH - StartX *2, 44);
        _submitOrderButton.layer.cornerRadius = 8.0;
        [_submitOrderButton setTitle:@"Valid" forState:UIControlStateNormal];
        [_submitOrderButton setTitleColor:KCOLOR_WHITE forState:UIControlStateNormal ];
        _submitOrderButton.centerX = SCREEN_WIDTH/2;
        _submitOrderButton.backgroundColor = KCOLOR_BLUE;
        [_submitOrderButton addTarget:self action:@selector(postAlldatas) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_submitOrderButton];
        
    }
    return _submitOrderButton;
}
- (UIScrollView *)backScrollView
{
    if(!_backScrollView)
    {
        _backScrollView = [UIScrollView createScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
                                                  backgroundColor:KTHEME_COLOR
                                                      contentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+20)];
        if (iPhone4) {
            _backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+120);
        }
        _backScrollView.scrollEnabled = YES;
        _backScrollView.delegate = self;
        
        [self.view addSubview:_backScrollView];
    }
    
    return _backScrollView;
}

- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.SID, @"id");  // Major ID
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/quick_apply_view"];//server
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.schoolDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _schoolDetail = [School_Details objectWithKeyValues:responseObject[@"data"]];
            

            if (_schoolDetail.fullName) {
                _serviceContentLabel.text = [NSString stringWithFormat:@"%@",_schoolDetail.fullName];
            }else{
                _serviceContentLabel.text = [NSString stringWithFormat:@""];
            }

            
            //birthday
            if (_schoolDetail.birthday) {
                _yearslabel.text = [PublicMethod getYMDUsingCreatedTimestamp:_schoolDetail.birthday];
            }else{
                _yearslabel.text = [NSString stringWithFormat:@""];
            }

            // phone
            if (_schoolDetail.phoneNumber) {
                _LangLabel.text = [NSString stringWithFormat:@"%@",_schoolDetail.phoneNumber];
            }else{
                _LangLabel.text = [NSString stringWithFormat:@""];
            }
            
            // name School
            if (_schoolDetail.nameSchool) {
                _schoolNameLabel.text = [NSString stringWithFormat:@"%@",_schoolDetail.nameSchool];
            }else{
                _schoolNameLabel.text = [NSString stringWithFormat:@""];
            }
            
            // Cycle
            if (_schoolDetail.cat_name) {
                _cycleNameLabel.text = [NSString stringWithFormat:@"%@",_schoolDetail.cat_name];
            }else{
                _cycleNameLabel.text = [NSString stringWithFormat:@""];
            }
            
            // Course Name
            if (_schoolDetail.CourseName) {
                _majorNameLabel.text = [NSString stringWithFormat:@"%@",_schoolDetail.CourseName];
            }else{
                _majorNameLabel.text = [NSString stringWithFormat:@""];
            }
            
            // Tuition
            if (_schoolDetail.fee) {
                _feeNameLabel.text = [NSString stringWithFormat:@"RMB %@ / Year",_schoolDetail.fee];
            }else{
                _feeNameLabel.text = [NSString stringWithFormat:@""];
            }
            
            
            _cycleID = [NSString stringWithFormat:@"%@",_schoolDetail.cycle_id];
            _schoolID = [NSString stringWithFormat:@"%@",_schoolDetail.school_id];
            
            
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Quick Apply";
    self.view.backgroundColor = KTHEME_COLOR;
    [self backScrollView];
    
    [self timeButton];
    [self serviceContentButton];
    [self endtimeButton];
    
    
    [self addressButton];
    [self serviceTypeButton];
    
    [self textLabel];
    [self thirdTextView];
    [self addImageView];
    [self submitOrderButton];
    [self feeTextView];
    [self topheader];
    [self getAllData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    params = [[NSMutableDictionary alloc] init];
}

#pragma mark
#pragma mark ----- OtherAction -----
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark
#pragma mark ----- UITextViewDelegate -----

- (void)scrollViewDidScroll:(UIScrollView *)scrollView                                          // any offset changes
{
    [self.view endEditing:YES];
}

// Get Program cycle by School
- (void)programCycleSchool
{
    DLog(@"Program cycle ");
    
    [self HiddenKeyboard];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/index"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if(!_propertyService_topCategory_List)
            {
                _propertyService_topCategory_List = [propertyService_topCategory_List objectWithKeyValues:responseObject];
                
            }else
            {
                _propertyService_topCategory_List = nil;
                _propertyService_topCategory_List = [propertyService_topCategory_List objectWithKeyValues:responseObject];
            }
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            [_propertyService_topCategory_List.data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                propertyService_topCategory *tmp = obj;
                [tmpArray addObject:tmp.cat_name];
            }];
            if(!_picker)
            {
                _picker = [[MyPicker alloc] init];
                _picker.delegate = self;
            }
            _picker.pickerTag = 0;
            [_picker showWithTitle:@"Your Program cycle " nameArray:tmpArray];
            
        }
        else
        {
            [ProgressHUD showError:responseObject[@"message"]];
        }
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}


//Majors by program cycle
- (void)listMajorByProgram
{
    // school name
}



- (void)LanguageOfStudy
{
    // language
}

- (void)DurationOfStudy
{
    DLog(@"duration Of Study");
    [self HiddenKeyboard];
   // NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"schools/duration_year"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if(!_year_List)
            {
                _year_List = [Duration_study_List objectWithKeyValues:responseObject];
                
            }else
            {
                _year_List = nil;
                _year_List = [Duration_study_List objectWithKeyValues:responseObject];
            }
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            [_year_List.data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Duration_details *tmp = obj;
                [tmpArray addObject:tmp.years];
            }];
            if(!_picker)
            {
                _picker = [[MyPicker alloc] init];
                _picker.delegate = self;
            }
            _picker.pickerTag = 3;
            [_picker showWithTitle:@"Duration of study (Year)" nameArray:tmpArray];
            
        }
        else
        {
            [ProgressHUD showError:responseObject[@"message"]];
        }
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}
#pragma mark pcikerDelegate
-(void)myPicker:(MyPicker *)picker didPickRow:(NSInteger)row
{
}

- (void)myPicker:(MyPicker *)picker willPickRow:(NSInteger)row
{
    if(picker.pickerTag == 0)
    {
        propertyService_topCategory *tmp = _propertyService_topCategory_List.data[row];
        _serviceTypeLabel.text = tmp.cat_name;
        _serviceTypeLabel.textColor = KTHEME_COLOR;
        _topType_cateid = tmp.id;  // take id
        [picker close];
        
    }
    
    
    if(picker.pickerTag == 3)
    {
        Duration_details *tmp = _year_List.data[row];
        _yearslabel.text = tmp.years;  // Duration of study
        _yearslabel.textColor = KTHEME_COLOR;
        [picker close];
    }
    
}

- (void)postAlldatas
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =  @"Please wait...";
    
    
    [params setObject:self.schoolNameLabel.text forKey:@"nameSchool"];
    [params setObject:self.cycleNameLabel.text forKey:@"cycleName"];
    [params setObject:self.majorNameLabel.text forKey:@"majorName"];
    [params setObject:self.feeNameLabel.text forKey:@"tuitionMajor"];
    [params setObject:self.serviceContentLabel.text forKey:@"studentName"];  // name
    [params setObject:self.yearslabel.text forKey:@"studentBirthday"];           // birthday
    [params setObject:self.LangLabel.text forKey:@"studentMobilePhone"];            // phone
    [params setObject:self.feeTextView.text forKey:@"studentMotherTongue"];             // studentMotherTongue
    [params setObject:self.serviceTypeLabel.text forKey:@"studentActualCycle"];       // cycle
    [params setObject:self.thirdTextView.text forKey:@"studentActualMajor"];      // major
    [params setObject:self.SID forKey:@"major_id"];   // Major ID
    [params setObject:self.cycleID forKey:@"cycle_id"];   // cycle ID
    [params setObject:self.schoolID forKey:@"school_id"];   // school ID

    NSLog(@"ID----->%@  cycleID----->%@  schoolID----->%@   ",self.SID,self.cycleID,self.schoolID);

    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/quick_apply"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [hud hideAnimated:YES afterDelay:0.3];
            [self MBShowSuccess:@"Succes"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [hud hideAnimated:YES afterDelay:0.3];
        
    }];
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placeHoderLabel.text = @"say something";
    }else{
        _placeHoderLabel.text = @"";
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGFloat passOffest;
    CGRect rec = [textView convertRect:textView.bounds toView:self.view];
    passOffest = rec.origin.y - (SCREEN_HEIGHT-self.keyboardRect_height-textView.height);
    
    if (passOffest > 0) {
        self.view.frame = [self animation: -passOffest];
    }
    
    
    [UIView commitAnimations];
}

-(CGRect)animation: (float) frame
{
    NSTimeInterval textAnimation = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:textAnimation];
    
    CGRect theframe = CGRectMake(0.0f, frame, SCREEN_WIDTH, self.view.frame.size.height);
    
    return theframe;
}
#pragma mark - notification

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.keyboardRect_height = keyboardRect.size.height;
                     }
                     completion:^(BOOL finished) {}];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self HiddenKeyboard];
                     }
                     completion:^(BOOL finished) {}];
}

- (void)HiddenKeyboard
{
    CGFloat y = KNAVGATION_BAR_HEIGHT;
    self.view.frame = [self animation:y];
    [UIView commitAnimations];
    [_thirdTextView resignFirstResponder];
    [_feeTextView resignFirstResponder];
    
    
}
@end
