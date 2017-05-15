//
//  CountryViewController.m
//  HHSD
//
//  Created by alain serge on 3/30/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//



#import "CountryViewController.h"
#define StartX 10
#define KborderWidth 1.5
@interface CountryViewController ()<UITextViewDelegate,MyPickerDelegate>
@property (nonatomic, strong) UIButton * serviceTypeButton;
@property (nonatomic, strong) UILabel *serviceTypeLabel;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) MyPicker *picker;
@property (nonatomic, assign) CGFloat keyboardRect_height;
@property (nonatomic, strong) UIButton *submitOrderButton;

@property (nonatomic, copy) NSString *topType_cateid;
@property (nonatomic, copy) NSString *country_id;
@property (nonatomic, strong) All_Countries_List *all_countries;
@property (nonatomic, strong) Countries_List_view *country_details;


@end

@implementation CountryViewController

//_backScrollView
- (UIScrollView *)backScrollView
{
    if(!_backScrollView)
    {
        _backScrollView = [UIScrollView createScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
                                                  backgroundColor:KCOLOR_WHITE
                                                      contentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+20)];
        _backScrollView.backgroundColor = KTHEME_COLOR;
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
    self.view.backgroundColor = KTHEME_COLOR;
    [self backScrollView];
    [self serviceTypeButton];
    [self selectCountryList];
    [self submitOrderButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    UIButton *leftBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 30)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(15)
                                                  title:@"OK"];
    [leftBtn addTarget:self action:@selector(saveMyCountryname) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// select Btn country
- (UIButton *)serviceTypeButton
{
    if(!_serviceTypeButton)
    {
        _serviceTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(StartX,20 , SCREEN_WIDTH - StartX*2, 44)];
        _serviceTypeButton.layer.borderColor = KCOLOR_WHITE.CGColor;
        _serviceTypeButton.layer.borderWidth = KborderWidth;
        _serviceTypeButton.backgroundColor = KCOLOR_WHITE;
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(_serviceTypeButton.size.width  - 30, 12, 21, 21)
                                       backgroundColor:KCOLOR_CLEAR
                                             textColor:KCOLOR_Line_Color
                                                  font:KICON_FONT_(15)
                                         textalignment:NSTextAlignmentCenter
                                                  text:@"\U0000e684"];
        label.centerY = _serviceTypeButton.size.height/2;
        [_serviceTypeButton addSubview:label];
        
        _serviceTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _serviceTypeButton.size.width - 40, 30)];
        _serviceTypeLabel.text = @"Select your country";
        _serviceTypeLabel.textColor = KCOLOR_Line_Color;
        _serviceTypeLabel.font = kAutoFont_(14);
        _serviceTypeLabel.centerY = _serviceTypeButton.size.height/2;
        
        [_serviceTypeButton addTarget:self action:@selector(selectCountryList) forControlEvents:UIControlEventTouchUpInside];
        [_serviceTypeButton addSubview:_serviceTypeLabel];
        [self.backScrollView addSubview:_serviceTypeButton];
    }
    return _serviceTypeButton;
}

// Get country List
- (void)selectCountryList
{
    DLog(@"Get country List ");
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Country/index"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if(!_all_countries)
            {
                _all_countries = [All_Countries_List objectWithKeyValues:responseObject];
                
            }else
            {
                _all_countries = nil;
                _all_countries = [All_Countries_List objectWithKeyValues:responseObject];
            }
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            [_all_countries.data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Countries_List_view *tmp = obj;
                [tmpArray addObject:tmp.country];
            }];
            if(!_picker)
            {
                _picker = [[MyPicker alloc] init];
                _picker.delegate = self;
            }
            _picker.pickerTag = 0;
            [_picker showWithTitle:@"My country " nameArray:tmpArray];
            
        }
        else
        {
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
        Countries_List_view *tmp = _all_countries.data[row];
        _serviceTypeLabel.text = tmp.country;
        _serviceTypeLabel.textColor = KTHEME_COLOR;
        _country_id = tmp.id;
        [picker close];
        
        
    }
    
}





- (void)saveMyCountryname
{
    DLog(@"country save");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.serviceTypeLabel.text, @"nationality");  // Ok
    kSetDict(self.serviceTypeLabel.text, @"country");  // Ok
    [params setObject:_country_id forKey:@"country_id"];// cycle ID
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"user/nationaly_signup"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:Ksignup_last_getAllData object:self];
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





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





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



@end
