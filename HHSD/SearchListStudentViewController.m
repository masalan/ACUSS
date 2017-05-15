//
//  SearchListStudentViewController.m
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SearchListStudentViewController.h"
#import "SearchStudentModel.h"
#import "SearchDetailsStudent.h"
#import "LoginViewController.h"
#import "WDTabBarViewController.h"
#import "AppDelegate.h"
#import "SignupViewController.h"

#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2
#define D 50


#define BtnH SCREEN_WIDTH/12
#define rowH SCREEN_WIDTH/2.2


@interface SearchListStudentViewController ()<UITableViewDataSource,UITableViewDelegate,
UITextFieldDelegate>
@property (nonatomic, strong) UITextField *userNameTextField,*passWDTextField;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) NSMutableArray *recordList;
@property (nonatomic, strong) SearchStudentModel *searchList;
@property (nonatomic, strong) SearchStudentModel *searchListStudent;



@end

@implementation SearchListStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.estimatedRowHeight = 89;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _recordList = [[NSMutableArray alloc] init];
    [self tableView];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchrecord"];
    if (array.count>0) {
        [_recordList addObjectsFromArray:array];
        [self.tableView reloadData];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate) name:@"SaveSearchList" object:nil];
    
    
    [self.navigationController.navigationBar setHidden:NO];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageWithColor:KTHEME_COLOR size:CGSizeMake(SCREEN_WIDTH, 1)]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [navigationBar setShadowImage:[UIImage new]];
}

-(void)didRotate {
    _isDelete = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
    [self loadNavi];
    if (_searchText) {
        [_searchText becomeFirstResponder];
    }
    self.leftBackBtn.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchText removeFromSuperview];
    [_searchBtn removeFromSuperview];
    [self.navigationController removeFromParentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - navi
- (void)loadNavi
{
    _searchText = [UITextField createTextFieldWithFrame:CGRectMake(0, 10, 194*SCREEN_WIDTH/320, 30)
                                        backgroundColor:KCOLOR_GRAY_f5f5f5
                                            borderStyle:UITextBorderStyleNone
                                            placeholder:NSLocalizedString(@"Localized_SearchListStudentViewControllert_searchText",comment:"")
                                                   text:@""
                                              textColor:KCOLOR_Black_343434
                                                   font:kAutoFont_(13)
                                          textalignment:NSTextAlignmentCenter
                                          conrnerRadius:KCORNER_RADIUS_3
                                            borderWidth:0
                                            borderColor:KCOLOR_GRAY_f5f5f5];
    _searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchText.returnKeyType = UIReturnKeySearch;
    _searchText.delegate = self;
    
    CGRect frame = [_searchText frame];
    frame.size.width = 30;
    UILabel *leftView = [UILabel createLabelWithFrame:frame
                                      backgroundColor:KCOLOR_Clear
                                            textColor:KCOLOR_GRAY_676767
                                                 font:KICON_FONT_(15)
                                        textalignment:NSTextAlignmentCenter
                                                 text:@"\U0000e662"];
    _searchText.leftViewMode = UITextFieldViewModeAlways;
    _searchText.leftView = leftView;
    
    _searchText.centerX = self.navigationController.navigationBar.centerX;
    
    _searchBtn = [UIButton createButtonwithFrame:CGRectMake(_searchText.right+10, 10, 50, 30)
                                 backgroundColor:KTHEME_COLOR
                                      titleColor:KTHEME_COLOR
                                            font:kAutoFont_(13)
                                           title:NSLocalizedString(@"Localized_SearchListViewController_searchBtn",comment:"")
                                   conrnerRadius:KCORNER_RADIUS_3
                                     borderWidth:0
                                     borderColor:nil];
    _searchBtn.centerY = _searchText.centerY;
    RACSignal *searchSignal = [self.searchText.rac_textSignal map:^id(NSString *text) {
        return @(text.length);
    }];
    RAC(_searchBtn,enabled) = [RACSignal combineLatest:@[searchSignal] reduce:^(NSNumber *length){
        return @([length intValue]>0);
    }];
    RAC(_searchBtn,backgroundColor) = [RACSignal combineLatest:@[searchSignal] reduce:^(NSNumber *length){
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *string = [self.searchText.text stringByTrimmingCharactersInSet:set];
        return ([length intValue] && ([string length]>0))>0 ? KCOLOR_GRAY_f5f5f5:KTHEME_COLOR;
    }];
    [_searchBtn addTarget:self
                   action:@selector(search)
         forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:_searchText];
    [self.navigationController.navigationBar addSubview:_searchBtn];
}

#pragma mark - init
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_searchListStudent.student.count>0) {
        return 1;
    }
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_searchListStudent.student.count>0) {
        if (section == 0) {
            return _searchListStudent.student.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchListStudent.student.count > 0)
    {
        if (indexPath.section == 0)
        {
            static NSString *cellIdentity = @"cells";
            SearchStudentCell *cells = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if (cells == nil) {
                cells = [[SearchStudentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentity];
            }
            if(_searchListStudent && _searchListStudent.student.count>0){
                [cells setInfoWith:_searchListStudent.student[indexPath.row]];
            }
            
            cells.selectionStyle = UITableViewCellSelectionStyleNone;
            return cells;
        }
    }
    
    return nil;
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return rowH;
}
/****
{
    if (_searchListStudent.student.count>0) {
        if (indexPath.section == 0) {
            return SW2-20;
        }
        else
            return SW2-20;
    }
    else
        return 44;
}
****/


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchListStudent.student.count>0) {
        return 30;
    }
    else
        return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_searchListStudent.student.count>0|| _searchListStudent.student.count>0) {
        UIView *vv = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)
                                 backgroundColor:KCOLOR_GRAY_f5f5f5];
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 30)
                                       backgroundColor:KCOLOR_Clear
                                             textColor:KCOLOR_GRAY_999999
                                                  font:kAutoFont_(13)
                                         textalignment:NSTextAlignmentLeft
                                                  text:@""];
        switch (section) {
            case 0:
                label.text = NSLocalizedString(@"Localized_SearchListViewController_Student",comment:"");
                break;
                
            case 1:
                label.text = NSLocalizedString(@"Localized_SearchListViewController_Student",comment:"");
                break;
                
            default:
                break;
        }
        
        [vv addSubview:label];
        return vv;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self UserCheckProfile];
}

/****
{
    
    if (!_searchListStudent)
    {
        if (indexPath.row == _recordList.count) {
            [_recordList removeAllObjects];
            _isDelete = YES;
            [[NSUserDefaults standardUserDefaults] setObject:_recordList forKey:@"searchrecord"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.tableView reloadData];
            
            _searchText.text = @"";
        }
        else
        {
            _searchText.text = _recordList[indexPath.row];
            [self getData];
        }
    } else
    {
        Student_Details *detailsStudent = _searchListStudent.student[indexPath.row];
        SearchDetailsStudent *vc = [[SearchDetailsStudent alloc] init];
        vc.studentId = detailsStudent.id;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SaveSearchList" object:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
****/

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self search];
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [_searchText resignFirstResponder];
    
    if (_searchText.text.length == 0 && _isDelete) {
        _searchListStudent = nil;
    }
    [self.tableView reloadData];
}

- (void)search
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *string = [self.searchText.text stringByTrimmingCharactersInSet:set];
    
    if (_searchText.text.length>0 && [string length]>0) {
        if (_recordList.count>0) {
            for (NSString *key in _recordList) {
                if (![key isEqualToString:_searchText.text]) {
                    if (_searchText.text.length>0) {
                        [_recordList addObject:_searchText.text];
                    }
                    break;
                }
            }
        }
        else {
            [_recordList addObject:_searchText.text];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:_recordList forKey:@"searchrecord"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (_searchText.text.length>0 && [string length]>0) {
        [self getData];
    }
    else if (_searchText.text.length == 0) {
        _searchListStudent = nil;
        [self.tableView reloadData];
    }
}

#pragma mark - getAllData
- (void)getData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Search/student"];
    kSetDict(_searchText.text, @"realname");
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _searchListStudent = [SearchStudentModel objectWithKeyValues:responseObject[@"data"]];
            if (_searchListStudent.student.count == 0 ) {
                [self MBShowHint:@"Try different keywords"];
                _searchListStudent = nil;
            }
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






-(void)UserCheckProfile
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Localized_SearchDetailsViewController_alertController",comment:"")
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *pseudo) {
        pseudo.placeholder = NSLocalizedString(@"Localized_SearchDetailsViewController_pseudo",comment:"");
        pseudo.textColor = [UIColor blueColor];
        pseudo.clearButtonMode = UITextFieldViewModeWhileEditing;
        pseudo.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *password) {
        password.placeholder = NSLocalizedString(@"Localized_SearchDetailsViewController_password",comment:"");
        password.textColor = [UIColor blueColor];
        password.clearButtonMode = UITextFieldViewModeWhileEditing;
        password.borderStyle = UITextBorderStyleRoundedRect;
        password.secureTextEntry = YES;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle: NSLocalizedString(@"COMMUN_OK",comment:"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        UITextField * passwordfiled = textfields[1];
        NSLog(@"%@:%@",namefield.text,passwordfiled.text);
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSMutableString *string = [NSMutableString stringWithString:urlHeader];
        [string appendString:[NSString stringWithFormat:@"user/login?mobile=%@&password=%@",namefield.text,passwordfiled.text]];
        
        [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            if([[responseObject objectForKey:@"code"] isEqual:@200])
            {
                [self MBShowHint:@"Congratulations on your successful login"];
                [[NSUserDefaults standardUserDefaults] setValue:self.userNameTextField.text forKey:KUSERNAME];
                [[NSUserDefaults standardUserDefaults] setValue:self.passWDTextField.text forKey:KPASSWORD];
                [[NSUserDefaults standardUserDefaults] setValue:responseObject[@"data"][@"sess_id"] forKey:KSESSION_ID];
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.windowController = nil;
                WDTabBarViewController *tabbar = [[WDTabBarViewController alloc] init];
                delegate.windowController = [[UINavigationController alloc] initWithRootViewController:tabbar];
                delegate.windowController.navigationBarHidden = YES;
                delegate.window.rootViewController = delegate.windowController;
            }
            if([[responseObject objectForKey:@"code"] isEqual:@500])
            {
                [self MBShowHint:responseObject[@"message"]];
            }
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            
        }];
        
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"COMMUN_cancel",comment:"") style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"later login");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Localized_SearchDetailsViewController_Signup",comment:"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController pushViewController:[[SignupViewController alloc] init] animated:YES];
        NSLog(@"Signup");
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}













@end






@implementation SearchStudentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor=KCOLOR_WHITE;
        [self addContent];
    }
    return  self;
}

-(void)addContent {
    
    if (!_avatarUser) {
        _avatarUser = [[UIImageView alloc] initWithFrame:CGRectMake(10,30, SW2/2, SW2/2)];
        _avatarUser.backgroundColor = KCOLOR_CLEAR;
        _avatarUser.layer.cornerRadius = _avatarUser.size.height/2;
        _avatarUser.layer.masksToBounds = YES;
        _avatarUser.backgroundColor = KCOLOR_CLEAR;
        _avatarUser.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
        _avatarUser.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_avatarUser ];
        
    }
    
    //_SchoolName
    if (!_fullNameUser) {
        _fullNameUser = [UILabel createLabelWithFrame:CGRectMake(_avatarUser.right+5, 5, SCREEN_WIDTH-(_avatarUser.right+30),35)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_BLUE
                                               font:kAutoFont_(18)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        _fullNameUser.numberOfLines = 2;
        [self addSubview:_fullNameUser];
    }
    // userNationalityIcon
    if (!_userNationalityIcon)
    {
        _userNationalityIcon = [UILabel createLabelWithFrame:CGRectMake(_avatarUser.right+10, _fullNameUser.bottom+1,20,20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KTHEME_COLOR
                                                 font:KICON_FONT_(11)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"\U0000e781 : "];
        [self addSubview:_userNationalityIcon];
    }
    
    
    // Flag view
    _countryCode = [[UIImageView alloc] initWithFrame:CGRectMake(_userNationalityIcon.right+2, _fullNameUser.bottom+1,20,14)];
    _countryCode.backgroundColor = KCOLOR_CLEAR;
    _countryCode.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_countryCode ];
    
    
    // userNationality
    if (!_userNationality)
    {
        _userNationality = [UILabel createLabelWithFrame:CGRectMake(_countryCode.right+1, _fullNameUser.bottom+1,(SCREEN_WIDTH-140)-31,20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_BLUE
                                                 font:kAutoFont_(11)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@""];
        [self addSubview:_userNationality];
    }
    
    // locationIcon
    if (!_locationIcon)
    {
        _locationIcon = [UILabel createLabelWithFrame:CGRectMake(_avatarUser.right+10, _userNationality.bottom+1,20,20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KTHEME_COLOR
                                                 font:KICON_FONT_(11)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"\U0000e76b : "];
        [self addSubview:_locationIcon];
    }
    
    
    
    
    
    
    // User location locationUser
    if (!_locationUser)
    {
        _locationUser = [UILabel createLabelWithFrame:CGRectMake(_locationIcon.right+3, _userNationality.bottom+1,(SCREEN_WIDTH-140)-10,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_BLUE
                                             font:kAutoFont_(11)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
        [self addSubview:_locationUser];
    }
    
    //verifyStatus
       if (!_verifyStatus) {
        _verifyStatus = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40,20,20,20)];
        _verifyStatus.backgroundColor = KCOLOR_CLEAR;
        _verifyStatus.layer.cornerRadius = _verifyStatus.size.height/2;
        _verifyStatus.layer.masksToBounds = YES;
        _verifyStatus.backgroundColor = KCOLOR_CLEAR;
        _verifyStatus.image = [UIImage imageNamed:@"0"];
        _verifyStatus.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_verifyStatus ];
        
    }
    
  
    //phoneIcon
    if (!_phoneIcon)
    {
        _phoneIcon = [UILabel createLabelWithFrame:CGRectMake(_avatarUser.right+10, _locationUser.bottom+1,20,20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KTHEME_COLOR
                                                 font:KICON_FONT_(11)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"\U0000e649 : "];
        [self addSubview:_phoneIcon];
    }
    
    // Phone Number
    if (!_MyMobile) {
        _MyMobile = [[ColorLabel alloc] initWithFrame:CGRectMake(_phoneIcon.right+3, _locationUser.bottom+1,((SCREEN_WIDTH-(_avatarUser.right+10))/2)-10,20)];
        _MyMobile.backgroundColor = KCOLOR_CLEAR;
        [self addSubview:_MyMobile];
    }
    
    if (!_signForCall)
    {        _signForCall =[ UILabel createLabelWithFrame:CGRectMake(_MyMobile.right+1, _locationUser.bottom+1,((SCREEN_WIDTH-(_avatarUser.right+10))/2)-20,BtnH)
                                     backgroundColor:KCOLOR_CALL_ME
                                           textColor:KCOLOR_WHITE
                                                font:KICON_FONT_(11)
                                       textalignment:NSTextAlignmentCenter
                                                text:NSLocalizedString(@"Localized_SearchListStudentViewController_signForCall",comment:"")
                                       conrnerRadius:8.0
                                         borderWidth:1
                                         borderColor:KCOLOR_CALL_ME];
        
        [self addSubview:_signForCall];
    }
    
    
    // Description
    if (!_detailLabel) {
        _detailLabel =[UILabel createLabelWithFrame:CGRectMake(10, _MyMobile.bottom+10,SCREEN_WIDTH-20,(SW2-((SW2/2)+30))-20)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_GRAY_999999
                                               font:kAutoFont_(16)
                                      textalignment:NSTextAlignmentCenter
                                               text:@""];
        _detailLabel.numberOfLines = 2;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_detailLabel];
        _detailLabel.hidden = YES; //hidden

    }
    
    if (!_integralLabel) {
        _integralLabel =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 120, 70, 110, 20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_GRAY_999999
                                                 font:KSYSTEM_FONT_Px_KFont(12)
                                        textalignment:NSTextAlignmentRight
                                                 text:@""];
        [self addSubview:_integralLabel];
        _integralLabel.hidden = YES; //hidden
    }
    
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                   backgroundColor:KCOLOR_Line_Color];
    [self addSubview:lineView];
}
- (void)setInfoWith:(Student_data *)student_data
{
    [_MyMobile instance:@""
          LeftStringFont:kAutoFont_(12)
         LeftStringColor:KTHEME_COLOR
         RightStringFont:kAutoFont_(20)
        RightStringColor:KTHEME_COLOR
           Right_String:[NSString stringWithFormat:@"%@ ",student_data.mobile]];
    
    if(student_data) {
        if([student_data.head_image hasPrefix:@"http"]) {
            [_avatarUser sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",student_data.head_image]] placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")] options:SDWebImageRetryFailed];
        }
        _fullNameUser.text = student_data.realname;
        _userNationality.text = student_data.country;
        _verifyStatus.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",student_data.verify]];

        
        
        
    }
    
    
    
    if ([student_data.living_in_china isEqualToString:@"0"])
    {
        _detailLabel.text = NSLocalizedString(@"Localized_SearchListStudentViewController_detailLabel",comment:"");
        _detailLabel.textColor = KCOLOR_RED;
        _detailLabel.hidden = NO; //show
    }

      // Profession
       if ([student_data.profession isEqualToString:@"0"])
        {
            _locationUser.text = @"Student";
            
        }
        else if ([student_data.profession isEqualToString:@"1"])
        {
            _locationUser.text = @"Teacher";
        }
        else if ([student_data.profession isEqualToString:@"2"])
        {
            _locationUser.text = @"Searcher";
        }
        else if ([student_data.profession isEqualToString:@"3"])
        {
            _locationUser.text = @"Visitor";
        }
        else if ([student_data.profession isEqualToString:@"4"])
        {
            _locationUser.text = @"Other";
        }
   
      
    
    else if ([student_data.living_in_china isEqualToString:@"1"])
    {
        _detailLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Localized_SearchListStudentViewController_detailLabel_living",comment:""),student_data.city_name];
        _detailLabel.textColor = KCOLOR_BLUE;
        _detailLabel.hidden = NO; //show
    }
    
    
    
    // Flag view
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@",student_data.Codecountry];
    
    if(student_data.Codecountry ) {
        _countryCode.image = [UIImage imageNamed:imagePath];
    }
    else {
        _countryCode.image = [UIImage imageNamed:@"CountryPicker.bundle/CN"];
        
    }
    
    
    
    
    
}








@end
