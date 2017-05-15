//
//  userAddGraduteMajor.m
//  HHSD
//
//  Created by alain serge on 3/29/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "userAddGraduteMajor.h"
#import "MainView_A.h"
#import "MyDatePicker.h"
#define StartX 10
#define KborderWidth 1.5
#define ADD_IMAGE_DEFALUT_IMAGE [UIImage imageNamed:@"add"]

@interface userAddGraduteMajor ()<UITextViewDelegate,MyDatePickerDelegate,MyPickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UIButton * timeButton,*endtimeButton;
@property (nonatomic, strong) UILabel *timeLabel,*endtimeLabel;
@property (nonatomic, strong) UIButton * addressButton;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton * serviceTypeButton;
@property (nonatomic, strong) UILabel *serviceTypeLabel;
@property (nonatomic, strong) UIButton * serviceContentButton;
@property (nonatomic, strong) UILabel *serviceContentLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UITextView *thirdTextView;
@property (nonatomic, strong) UILabel *placeHoderLabel;
@property (nonatomic, strong) UILabel *addImageView;
@property (nonatomic, strong) UIButton *submitOrderButton;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) MyDatePicker *datePicker;
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


@end

@implementation userAddGraduteMajor
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
- (UIButton *)addressButton
{
    if(!_addressButton)
    {
        _addressButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,5 , SCREEN_WIDTH - StartX*2, 44)];
        _addressButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _addressButton.layer.borderWidth = KborderWidth;
        _addressButton.backgroundColor = KTHEME_COLOR;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(_addressButton.size.width  - 30, 12, 21, 21)];
        image.image = [UIImage imageNamed:@"add1"];
        image.centerY = _addressButton.size.height/2;
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _addressButton.size.width - 40,40)];
        _addressLabel.numberOfLines = 3;
        _addressLabel.text = @" ";
        _addressLabel.textColor = KCOLOR_WHITE;
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        _addressLabel.font = kAutoFont_(13);
        _addressLabel.centerY = _addressButton.size.height/2;
        [_addressButton addSubview:image];
        [_addressButton addSubview:_addressLabel];
        
        [self.backScrollView addSubview:_addressButton];
    }
    return _addressButton;
}

//Start study
- (UIButton *)timeButton
{
    if(!_timeButton)
    {
        _timeButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,55 , SCREEN_WIDTH - StartX*2, 50)];
        _timeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _timeButton.layer.borderWidth = KborderWidth;
        
        UILabel *imageView = [UILabel createLabelWithFrame:CGRectMake(10, 2, 40, 40)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KTHEME_COLOR
                                                 font:KICON_FONT_(17)
                                        textalignment:NSTextAlignmentCenter
                                                 text:@"\U0000e641"];
        
        imageView.layer.cornerRadius = imageView.size.height/2;
        imageView.centerY = _timeButton.size.height/2;
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.size.width + 20, 4, 250, 45)];
        _timeLabel.text = @"Start study";
        _timeLabel.textColor = KCOLOR_Line_Color;
        _timeLabel.font = [UIFont systemFontOfSize:15.5];
        _timeLabel.centerY = _timeButton.size.height/2;
        
        _timeButton.tag = 0;
        [_timeButton addTarget:self action:@selector(startStudyTime:) forControlEvents:UIControlEventTouchUpInside];
        [_timeButton addSubview:imageView];
        [_timeButton addSubview:_timeLabel];
        
        [self.backScrollView addSubview:_timeButton];
    }
    return _timeButton;
}

//End study

-(UIButton *)endtimeButton{
    
    if (!_endtimeButton) {
        _endtimeButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,110  , SCREEN_WIDTH - StartX*2, 50)];
        _endtimeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _endtimeButton.layer.borderWidth = KborderWidth;
        
        UILabel *imageView = [UILabel createLabelWithFrame:CGRectMake(10, 2, 40, 40)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KTHEME_COLOR
                                                      font:KICON_FONT_(17)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@"\U0000e641"];
        
        imageView.layer.cornerRadius = imageView.size.height/2;
        imageView.centerY = _endtimeButton.size.height/2;
        
        // endtimeLabel
        _endtimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.size.width + 20, 4, 250, 45)];
        _endtimeLabel.text = @"End study";
        _endtimeLabel.textColor = KCOLOR_Line_Color;
        _endtimeLabel.font = [UIFont systemFontOfSize:15.5];
        _endtimeLabel.centerY = _endtimeButton.size.height/2;
        
        _endtimeButton.tag = 1;
        [_endtimeButton addTarget:self action:@selector(startStudyTime:) forControlEvents:UIControlEventTouchUpInside];
        [_endtimeButton addSubview:imageView];
        [_endtimeButton addSubview:_endtimeLabel];
        
         [self.backScrollView addSubview:_endtimeButton];
    }
        return _endtimeButton;
}

- (UIButton *)serviceTypeButton
{
    if(!_serviceTypeButton)
    {
        _serviceTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,164 , SCREEN_WIDTH - StartX*2, 44)];
        _serviceTypeButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _serviceTypeButton.layer.borderWidth = KborderWidth;
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_serviceTypeButton.size.width  - 28, 12, 21, 21) backgroundColor:KCOLOR_WHITE textColor:KCOLOR_Line_Color font:KICON_FONT_(15) textalignment:NSTextAlignmentCenter text:@"\U0000e684"];
        label.centerY = _serviceTypeButton.size.height/2;
        [_serviceTypeButton addSubview:label];
        
        _serviceTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _serviceTypeButton.size.width - 40, 30)];
        _serviceTypeLabel.text = @"Program cycle";
        _serviceTypeLabel.textColor = KCOLOR_Line_Color;
        _serviceTypeLabel.font = kAutoFont_(14);
        _serviceTypeLabel.centerY = _serviceTypeButton.size.height/2;
        
        [_serviceTypeButton addTarget:self action:@selector(programCycleSchool) forControlEvents:UIControlEventTouchUpInside];
        [_serviceTypeButton addSubview:_serviceTypeLabel];
        [self.backScrollView addSubview:_serviceTypeButton];
    }
    return _serviceTypeButton;
}
- (UIButton *)serviceContentButton
{
    if(!_serviceContentButton)
    {
        _serviceContentButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX, _serviceTypeButton.size.height + _serviceTypeButton.origin.y +5 , SCREEN_WIDTH - StartX*2, 44)];
        _serviceContentButton.layer.borderColor = KTHEME_COLOR.CGColor;
        _serviceContentButton.layer.borderWidth = KborderWidth;
        
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_serviceTypeButton.size.width  - 28, 12, 21, 21) backgroundColor:KCOLOR_WHITE textColor:KCOLOR_Line_Color font:KICON_FONT_(15) textalignment:NSTextAlignmentCenter text:@"\U0000e684"];
        label.centerY = _serviceTypeButton.size.height/2;
        [_serviceContentButton addSubview:label];
        
        _serviceContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _serviceContentButton.size.width - 40, 30)];
        _serviceContentLabel.numberOfLines =3;
        _serviceContentLabel.text = @"Your major";
        _serviceContentLabel.textColor = KCOLOR_Line_Color;
        _serviceContentLabel.font = kAutoFont_(12);
        _serviceContentLabel.centerY = _serviceContentButton.size.height/2;
        
        [_serviceContentButton addTarget:self action:@selector(listMajorByProgram) forControlEvents:UIControlEventTouchUpInside];
        [_serviceContentButton addSubview:_serviceContentLabel];
        [self.backScrollView addSubview:_serviceContentButton];
    }
    return _serviceContentButton;
}

- (UITextView *)thirdTextView
{
    if(!_thirdTextView )
    {
        _thirdTextView = [[UITextView alloc] initWithFrame:CGRectMake(StartX,_serviceContentButton.size.height+ _serviceContentButton.origin.y + 5, SCREEN_WIDTH - 2*StartX,65)];
        _thirdTextView.layer.borderColor = KTHEME_COLOR.CGColor;
        _thirdTextView.layer.borderWidth = KborderWidth;
        _thirdTextView.textColor = KCOLOR_Black_343434;
        _thirdTextView.font = kAutoFont_(14);
        
        if(!_placeHoderLabel)
        {
            _placeHoderLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, SCREEN_WIDTH-80, 60)];
            _placeHoderLabel.text = @" say something about that school or major";
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
        UILabel *text = [UILabel createLabelWithFrame:CGRectMake(StartX, _thirdTextView.bottom+10, SCREEN_WIDTH-StartX*2,50)
                                      backgroundColor:KCOLOR_Clear
                                            textColor:KCOLOR_Black_343434
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
       // _submitOrderButton.frame = CGRectMake(StartX, SCREEN_HEIGHT-KNAVGATION_BAR_HEIGHT-64-45, SCREEN_WIDTH - StartX *2, 44);
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
    self.title = @"add graduate";
    self.view.backgroundColor = KCOLOR_WHITE;
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


#pragma mark
#pragma mark ----- getAllData -----

// School details
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    kSetDict(self.SID, @"id");  // School ID

    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/detail"];//server
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.schoolDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _schoolDetail = [School_Details objectWithKeyValues:responseObject[@"data"]];
            
            if (_schoolDetail.nameSchool) {
                _addressLabel.text = _schoolDetail.nameSchool;
            }else{
                 _addressLabel.text = @"";
            }
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
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


- (void)startStudyTime:(UIButton *)sender
{
    DLog(@"select time");
    if([self.thirdTextView isFirstResponder])
    {
        [self.view endEditing:YES];
        return;
    }
    _selectedBtn = sender.tag;
    if (!_datePicker) {
        _datePicker = [[MyDatePicker alloc] init];
        _datePicker.delegate = self;

    }else{
        [_datePicker open];
    }
    _datePicker.datePicker.maximumDate = nil;

    switch (_selectedBtn) {
        case 0:
        {
            _datePicker.datePicker.date = [NSDate date];

        }
//        {
//            _datePicker.datePicker.maximumDate = [NSDate date];
//            if ([_startTimeStamp length]>0) {
//                _datePicker.datePicker.date = [PublicMethod
//                                               getDateWithCreatedTimestamp:_startTimeStamp];
//            }
//            else
//            {
//                _datePicker.datePicker.date = [NSDate date];
//            }
//        }
            break;
        case 1:
        {
            _datePicker.datePicker.date = [NSDate date];

        }
//        {
//            _datePicker.datePicker.minimumDate = [PublicMethod getDateWithCreatedTimestamp:_startTimeStamp];
//            if ([_endTimeStamp length]>0) {
//                _datePicker.datePicker.date = [PublicMethod
//                                               getDateWithCreatedTimestamp:_endTimeStamp];
//            }
//            else
//            {
//                _datePicker.datePicker.date = [NSDate date];
//            }
//        }
            break;
        default:
            break;
    }
}

#pragma mark myDatePicker
-(void)myDatePickerDidSelectedDate:(NSDate *)selectedDate
{
    switch (_selectedBtn) {
        case 0:{
            _timeLabel.textColor = KCOLOR_BLUE_0210C3;
            _startTimeStamp = [NSString stringWithFormat:@"%@",[PublicMethod getCreateTimeWithDate:selectedDate]];
            _timeLabel.text = [PublicMethod getDateUsingDate:selectedDate];

            
        }
            break;
        case 1:
        {
            _endtimeLabel.textColor = KCOLOR_RED;
            _endTimeStamp = [NSString stringWithFormat:@"%@",[PublicMethod getCreateTimeWithDate:selectedDate]];
            _endtimeLabel.text =[PublicMethod getDateUsingDate:selectedDate];
        }
            break;
        default:
            break;
    }
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
    
    if([self.thirdTextView isFirstResponder])
    {
        [self.view endEditing:YES];
        return ;
    }
    
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
    [self HiddenKeyboard];
    
    DLog(@"My Majors");
    if([_topType_cateid isEqualToString:@""])
    {
        [ProgressHUD showError:@"Your major program" Interaction:NO];
        return ;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:self.sess_id forKey:@"sess_id"];
    [params setObject:self.topType_cateid forKey:@"cycle_id"];// cycle ID
    kSetDict(self.SID, @"school_id");  // School ID
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/majors_list"];
    
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
                 [tmpArray addObject:tmp.CourseName];
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
        _serviceContentLabel.text = tmp.CourseName;
        _serviceContentLabel.textColor = KTHEME_COLOR;
        _secondType_cateid = tmp.id;
        [picker close];
    }
}
- (void)postAlldatas
{
    DLog(@"post");
    if([_startTimeStamp isEqualToString:@""])
    {
        [ProgressHUD showError:@"start study date" Interaction:NO];
        return ;
    }
    if([_endTimeStamp isEqualToString:@""])
    {
        [ProgressHUD showError:@"end study date" Interaction:NO];
        return ;
    }
    
    if([self.topType_cateid isEqualToString:@""])
    {
        [ProgressHUD showError:@"Your Progrm cycle" Interaction:NO];
        return ;
    }
    if([_secondType_cateid isEqualToString:@""])
    {
        [ProgressHUD showError:@"Your  Major" Interaction:NO];
        return ;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:self.sess_id forKey:@"sess_id"];
    [params setObject:self.addressLabel.text forKey:@"school_name"];  // University name
    kSetDict(self.SID, @"school_id");  // School ID
    [params setObject:self.startTimeStamp forKey:@"start_study"];// start time
    [params setObject:self.endTimeStamp forKey:@"end_study"];// end time
    [params setObject:self.serviceTypeLabel.text forKey:@"p_name"];  // Cycle name
    [params setObject:self.topType_cateid forKey:@"p_id"]; // Cycle id
    [params setObject:self.serviceContentLabel.text forKey:@"major_name"];  // Major name
    [params setObject:self.thirdTextView.text forKey:@"message"]; // description

    
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Students/add_graduate"];
    
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [self MBShowSuccess:@"Succes"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
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
    
}
@end
