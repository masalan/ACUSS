//
//  addMajorProgram.m
//  HHSD
//
//  Created by alain serge on 4/7/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "addMajorProgram.h"
#import "MainView_A.h"
#import "MyDatePicker.h"
#define StartX 10
#define KborderWidth 1.5
#define ADD_IMAGE_DEFALUT_IMAGE [UIImage imageNamed:@"add"]

@interface addMajorProgram ()<UITextViewDelegate,MyPickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UIButton * timeButton,*endtimeButton;
@property (nonatomic, strong) UILabel *timeLabel,*endtimeLabel;
@property (nonatomic, strong) UIButton * addressButton;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton * serviceTypeButton;
@property (nonatomic, strong) UILabel *serviceTypeLabel;
@property (nonatomic, strong) UIButton * serviceContentButton;
@property (nonatomic, strong) UILabel *serviceContentLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *LangLabel,*yearslabel;
@property (nonatomic, strong) UITextView *thirdTextView,*feeTextView,*langTextView;
@property (nonatomic, strong) UILabel *placeHoderLabel,*feeLabel,*langLabel;
@property (nonatomic, strong) UILabel *addImageView;
@property (nonatomic, strong) UIButton *submitOrderButton;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) MyPicker *picker;
@property (nonatomic, copy) NSString *topType_cateid;
@property (nonatomic, copy) NSString *secondType_cateid;
@property (nonatomic, copy) NSString *visit_time;
@property (nonatomic, assign) CGFloat keyboardRect_height;
@property (nonatomic,strong ) NSMutableArray           *imageArray;
@property (nonatomic, strong) School_Details *schoolDetail;

@property (nonatomic, assign) NSUInteger selectedBtn;
@property (nonatomic, copy) NSString *startTimeStamp, *endTimeStamp, *upToTimeStamp;

@property (nonatomic, strong) propertyService_topCategory_List *propertyService_topCategory_List;
@property (nonatomic, strong) propertyService_secondCategory_List *propertyService_secondCategory_List;


@property (nonatomic, strong) Teaching_languages_List *language_List;
@property (nonatomic, strong) Duration_study_List *year_List;


@end

@implementation addMajorProgram

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



// name school
- (UIButton *)serviceContentButton
{
    if(!_serviceContentButton)
    {
        _serviceContentButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,5 , SCREEN_WIDTH - StartX*2, 44)];
        _serviceContentButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _serviceContentButton.layer.borderWidth = KborderWidth;
        _serviceContentButton.layer.borderWidth = 1;
        _serviceContentButton.layer.cornerRadius = 8;

        
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_serviceContentButton.size.width  - 28, 12, 21, 21) backgroundColor:KCOLOR_WHITE textColor:KCOLOR_Line_Color font:KICON_FONT_(15) textalignment:NSTextAlignmentCenter text:@"\U0000e684"];
        label.centerY = _serviceContentButton.size.height/2;
        [_serviceContentButton addSubview:label];
        
        _serviceContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _serviceContentButton.size.width - 40, 30)];
        _serviceContentLabel.numberOfLines =3;
        _serviceContentLabel.text = @"Course Name";
        _serviceContentLabel.textColor = KCOLOR_Line_Color;
        _serviceContentLabel.font = kAutoFont_(12);
        _serviceContentLabel.centerY = _serviceContentButton.size.height/2;
        _serviceContentLabel.textAlignment = NSTextAlignmentCenter;

        _serviceContentButton.tag = 0;
        [_serviceContentButton addTarget:self action:@selector(listMajorByProgram) forControlEvents:UIControlEventTouchUpInside];
        [_serviceContentButton addSubview:_serviceContentLabel];
        [self.backScrollView addSubview:_serviceContentButton];
    }
    return _serviceContentButton;
}


//Duration of study
- (UIButton *)timeButton
{
    if(!_timeButton)
    {
        _timeButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,54, SCREEN_WIDTH - StartX*2, 44)];
        _timeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _timeButton.layer.borderWidth = KborderWidth;
        _timeButton.layer.borderWidth = 1;
        _timeButton.layer.cornerRadius = 8;
        
        UILabel *imageView = [UILabel createLabelWithFrame:CGRectMake(10, 2, 40, 40)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KTHEME_COLOR
                                                      font:KICON_FONT_(17)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@"\U0000e641"];
        
        imageView.layer.cornerRadius = imageView.size.height/2;
        imageView.centerY = _timeButton.size.height/2;
        [_timeButton addSubview:imageView];

        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_timeButton.size.width  - 28, 12, 21, 21) backgroundColor:KCOLOR_WHITE textColor:KCOLOR_Line_Color font:KICON_FONT_(15) textalignment:NSTextAlignmentCenter text:@"\U0000e684"];
        label.centerY = _timeButton.size.height/2;
        [_timeButton addSubview:label];
        
        
        _yearslabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.size.width + 20, 2, 250, 35)];
        _yearslabel.text = @"Duration of study";
        _yearslabel.textColor = KCOLOR_Line_Color;
        _yearslabel.font = [UIFont systemFontOfSize:15.5];
        _yearslabel.centerY = _timeButton.size.height/2;
        _yearslabel.textAlignment = NSTextAlignmentLeft;

        _timeButton.tag = 1;
        [_timeButton addTarget:self action:@selector(DurationOfStudy) forControlEvents:UIControlEventTouchUpInside];
        [_timeButton addSubview:_yearslabel];
        
        [self.backScrollView addSubview:_timeButton];
    }
    return _timeButton;
}//LangLabel,*yearslabel

//Language of study

-(UIButton *)endtimeButton{
    
    if (!_endtimeButton) {
        _endtimeButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,103  , SCREEN_WIDTH - StartX*2, 44)];
        _endtimeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _endtimeButton.layer.borderWidth = KborderWidth;
        _endtimeButton.layer.borderWidth = 1;
        _endtimeButton.layer.cornerRadius = 8;
        
        UILabel *imageView = [UILabel createLabelWithFrame:CGRectMake(10, 2, 40, 40)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KTHEME_COLOR
                                                      font:KICON_FONT_(17)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@"\U0000e641"];
        
        imageView.layer.cornerRadius = imageView.size.height/2;
        imageView.centerY = _endtimeButton.size.height/2;
        
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_endtimeButton.size.width  - 28, 12, 21, 21) backgroundColor:KCOLOR_WHITE textColor:KCOLOR_Line_Color font:KICON_FONT_(15) textalignment:NSTextAlignmentCenter text:@"\U0000e684"];
        label.centerY = _endtimeButton.size.height/2;
        [_endtimeButton addSubview:label];
        
        // endtimeLabel
        _LangLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.size.width + 20, 4, 250, 35)];
        _LangLabel.text = @"Teaching Language";
        _LangLabel.textColor = KCOLOR_Line_Color;
        _LangLabel.font = [UIFont systemFontOfSize:15.5];
        _LangLabel.centerY = _endtimeButton.size.height/2;
        _LangLabel.textAlignment = NSTextAlignmentLeft;

        _endtimeButton.tag = 2;
        [_endtimeButton addTarget:self action:@selector(LanguageOfStudy) forControlEvents:UIControlEventTouchUpInside];
        [_endtimeButton addSubview:imageView];
        [_endtimeButton addSubview:_LangLabel];
        
        [self.backScrollView addSubview:_endtimeButton];
    }
    return _endtimeButton;
}



//feeTextView

- (UITextView *)feeTextView
{
    if(!_feeTextView )
    {
        _feeTextView = [[UITextView alloc] initWithFrame:CGRectMake(StartX,152  , SCREEN_WIDTH - StartX*2, 44)];
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
            _feeLabel.text = @"major fee";
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
        _serviceTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,201, SCREEN_WIDTH - StartX*2, 44)];
        _serviceTypeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _serviceTypeButton.layer.borderWidth = KborderWidth;
        
        _serviceTypeButton.layer.borderWidth = 1;
        _serviceTypeButton.layer.cornerRadius = 8;
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_serviceTypeButton.size.width  - 28, 12, 21, 21) backgroundColor:KCOLOR_WHITE textColor:KCOLOR_Line_Color font:KICON_FONT_(15) textalignment:NSTextAlignmentCenter text:@"\U0000e684"];
        label.centerY = _serviceTypeButton.size.height/2;
        [_serviceTypeButton addSubview:label];
        
        _serviceTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _serviceTypeButton.size.width - 40, 30)];
        _serviceTypeLabel.text = @"Program cycle";
        _serviceTypeLabel.textColor = KCOLOR_Line_Color;
        _serviceTypeLabel.font = kAutoFont_(14);
        _serviceTypeLabel.centerY = _serviceTypeButton.size.height/2;
        _serviceTypeLabel.textAlignment = NSTextAlignmentLeft;

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
        _thirdTextView = [[UITextView alloc] initWithFrame:CGRectMake(StartX,250, SCREEN_WIDTH - 2*StartX,44)];
        _thirdTextView.layer.borderColor = KTHEME_COLOR.CGColor;
        _thirdTextView.layer.borderWidth = KborderWidth;
        _thirdTextView.textColor = KCOLOR_Black_343434;
        _thirdTextView.font = kAutoFont_(14);
        
        
        _thirdTextView.layer.borderWidth = 1;
        _thirdTextView.layer.cornerRadius =8;
        
        
        if(!_placeHoderLabel)
        {
            _placeHoderLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH-80, 35)];
            _placeHoderLabel.text = @" Your major";
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
        UILabel *text = [UILabel createLabelWithFrame:CGRectMake(StartX,306, SCREEN_WIDTH-StartX*2,50)
                                      backgroundColor:KCOLOR_Clear
                                            textColor:KCOLOR_GRAY_Cell
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
        [_submitOrderButton setTitle:@"valid" forState:UIControlStateNormal];
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
                                                  backgroundColor:KCOLOR_WHITE
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"add Major";
    self.view.backgroundColor = KTHEME_COLOR;
    [self backScrollView];
    [self timeButton];
    [self addressButton];
    [self serviceTypeButton];
    [self serviceContentButton];
    [self endtimeButton];
    [self textLabel];
    [self thirdTextView];
    [self addImageView];
    [self submitOrderButton];
    [self feeTextView];
    
    
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
    DLog(@"School name ");
    [self HiddenKeyboard];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"schools/all_university"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if(!_propertyService_secondCategory_List)
            {
                _propertyService_secondCategory_List = [propertyService_secondCategory_List objectWithKeyValues:responseObject];
                
            }else
            {
                _propertyService_secondCategory_List = nil;
                _propertyService_secondCategory_List = [propertyService_secondCategory_List objectWithKeyValues:responseObject];
            }
            NSMutableArray *tmpArray = [NSMutableArray array];
            [_propertyService_secondCategory_List.data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                propertyService_secondCategory *tmp = obj;
                [tmpArray addObject:tmp.nameSchool];
            }];
            if(!_picker)
            {
                _picker = [[MyPicker alloc] init];
                _picker.delegate = self;
            }
            _picker.pickerTag = 1;
            [_picker showWithTitle:@"Your Programs cylce" nameArray:tmpArray];
            
        }
        else
        {
            [ProgressHUD showError:responseObject[@"message"]];
        }
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}



- (void)LanguageOfStudy
{
    DLog(@"Language Of Study");
    [self HiddenKeyboard];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"schools/teaching_language"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if(!_language_List)
            {
                _language_List = [Teaching_languages_List objectWithKeyValues:responseObject];
                
            }else
            {
                _language_List = nil;
                _language_List = [Teaching_languages_List objectWithKeyValues:responseObject];
            }
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            [_language_List.data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Teaching_language_details *tmp = obj;
                [tmpArray addObject:tmp.language];
            }];
            if(!_picker)
            {
                _picker = [[MyPicker alloc] init];
                _picker.delegate = self;
            }
            _picker.pickerTag = 2;
            [_picker showWithTitle:@"Teaching Language" nameArray:tmpArray];
        }
        else
        {
            [ProgressHUD showError:responseObject[@"message"]];
        }
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)DurationOfStudy
{
    DLog(@"duration Of Study");
    [self HiddenKeyboard];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
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
    if(picker.pickerTag == 1)
    {
        propertyService_secondCategory *tmp = _propertyService_secondCategory_List.data[row];
        _serviceContentLabel.text = tmp.nameSchool;  // School name
        _serviceContentLabel.textColor = KTHEME_COLOR;
        _secondType_cateid = tmp.id;
        [picker close];
    }
    
    if(picker.pickerTag == 3)
    {
        Duration_details *tmp = _year_List.data[row];
        _yearslabel.text = tmp.years;  // Duration of study
        _yearslabel.textColor = KTHEME_COLOR;
        [picker close];
    }
    
    if(picker.pickerTag == 2)
    {
        Teaching_language_details *tmp = _language_List.data[row];
        _LangLabel.text = tmp.language;  // Teaching Language
        _LangLabel.textColor = KTHEME_COLOR;
        [picker close];
    }
}

- (void)postAlldatas
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =  @"Please wait...";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.feeTextView.text forKey:@"fee"];// Tuition Fee
    [params setObject:self.yearslabel.text forKey:@"duration"];//  Duration of study
    [params setObject:self.LangLabel.text forKey:@"language"];  // Teaching Language
    [params setObject:self.topType_cateid forKey:@"cycle_id"]; // Cycle id
    [params setObject:self.secondType_cateid forKey:@"school_id"];  // University id
    [params setObject:self.thirdTextView.text forKey:@"CourseName"]; // Major name
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
     [string appendString:@"Manager/add_major"];
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
