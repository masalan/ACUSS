//
//  ecoleSearch.m
//  HHSD
//
//  Created by alain serge on 4/12/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "ecoleSearch.h"
#import "MainView_C.h"
#import "SearchModel.h"
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2

#define D 50

@interface ecoleSearch ()<UITableViewDataSource,UITableViewDelegate,
UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) NSMutableArray *recordList;
@property (nonatomic, strong) SearchModel *searchList;

@end

@implementation ecoleSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchText removeFromSuperview];
    [_searchBtn removeFromSuperview];
}

#pragma mark - navi
- (void)loadNavi
{
    _searchText = [UITextField createTextFieldWithFrame:CGRectMake(0, 10, 194*SCREEN_WIDTH/320, 30)
                                        backgroundColor:KCOLOR_GRAY_f5f5f5
                                            borderStyle:UITextBorderStyleNone
                                            placeholder:NSLocalizedString(@"Localized_SearchListViewController_searchText",comment:"")
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
    _searchText.leftViewMode = UITextFieldViewModeAlways;  //左边距为15pix
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
    if (_searchList.school.count>0) {
        return 1;
    }
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_searchList.school.count>0) {
        if (section == 0) {
            return _searchList.school.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchList.school.count > 0)
    {
        if (indexPath.section == 0)
        {
            static NSString *cellIdentity = @"cells";
            ecolesCell *cells = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if (cells == nil) {
                cells = [[ecolesCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentity];
            }
            if(_searchList && _searchList.school.count>0){
                [cells setInfoWith:_searchList.school[indexPath.row]];
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
    if (_searchList.school.count>0) {
        if (indexPath.section == 0) {
            return SW2;
        }
        else
            return SW2;
    }
    else
        return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchList.school.count>0) {
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
    if (_searchList.school.count>0|| _searchList.school.count>0) {
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
                label.text = NSLocalizedString(@"Localized_SearchListViewController_school",comment:"");
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
    School_Details *detailsSchool = _searchList.school[indexPath.row];
    MainView_C *vc = [[MainView_C alloc] init];
    vc.schoolId = detailsSchool.id;
    School_data *stats = _searchList.school[indexPath.row];
    NSString *hidden;
    hidden = stats.hidden;
    
    if ([hidden isEqualToString:@"1"])  // its coming soon
    {
        
    } else if ([hidden isEqualToString:@"0"])  // open new page
    {
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}


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
        _searchList = nil;
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
        _searchList = nil;
        [self.tableView reloadData];
    }
}

#pragma mark - getAllData
- (void)getData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Search/search_school"];
    kSetDict(_searchText.text, @"nameSchool");
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _searchList = [SearchModel objectWithKeyValues:responseObject[@"data"]];
            if (_searchList.school.count == 0 ) {
                [self MBShowHint:@"Try different keywords"];
                _searchList = nil;
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

@end






@implementation ecolesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor=KCOLOR_WHITE;
        [self addContent];
    }
    return  self;
}

-(void)addContent {
    
    
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SW2/2, SW2/2)];
        _logoImageView.backgroundColor = KCOLOR_CLEAR;
        _logoImageView.layer.cornerRadius = _logoImageView.size.height/2;
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.backgroundColor = KCOLOR_CLEAR;
        _logoImageView.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_logoImageView ];
    }
    
    //maintenance
    
    
    if (!_maintenance) {
        _maintenance = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70,45,50,50)];
        _maintenance.backgroundColor = KCOLOR_CLEAR;
        _maintenance.layer.cornerRadius = _maintenance.size.height/2;
        _maintenance.layer.masksToBounds = YES;
        _maintenance.backgroundColor = KCOLOR_CLEAR;
        _maintenance.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_maintenance ];
    }
    
    //_SchoolName
    if (!_SchoolName) {
        _SchoolName = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, 5, SCREEN_WIDTH-(_logoImageView.right+30),45)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_BLUE
                                               font:kAutoFont_(18)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        _SchoolName.numberOfLines = 3;
        [self addSubview:_SchoolName];
    }
    // Province
    if (!_province)
    {
        _province = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, _SchoolName.bottom+1,(SCREEN_WIDTH-140)/2,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_Black_343434
                                             font:kAutoFont_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
        [self addSubview:_province];
    }
    // City Name
    if (!_cityName)
    {
        _cityName = [UILabel createLabelWithFrame:CGRectMake(_province.right+5, _SchoolName.bottom+1,(SCREEN_WIDTH-135)/2,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_Black_343434
                                             font:kAutoFont_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
        [self addSubview:_cityName];
    }
    // Foreigner students total
    
    if (!_effective) {
        _effective = [[ColorLabel alloc] initWithFrame:CGRectMake(_logoImageView.right+10, _cityName.bottom+1,SCREEN_WIDTH-(_logoImageView.right+50),20)];
        _effective.backgroundColor = KCOLOR_CLEAR;
        [self addSubview:_effective];
    }
    
    
    // Description
    if (!_detailLabel) {
        _detailLabel =[UILabel createLabelWithFrame:CGRectMake(10, _effective.bottom+5,SCREEN_WIDTH-20,SW2-((SW2/2)+30))
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_GRAY_999999
                                               font:kAutoFont_(10)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        _detailLabel.numberOfLines = 12;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_detailLabel];
    }
    
    if (!_integralLabel) {
        _integralLabel =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 120, 70, 110, 20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_GRAY_999999
                                                 font:kAutoFont_(12)
                                        textalignment:NSTextAlignmentRight
                                                 text:@""];
        [self addSubview:_integralLabel];
        _integralLabel.hidden = YES; //hidden
    }
    
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                   backgroundColor:KCOLOR_Line_Color];
    [self addSubview:lineView];
}

- (void)setInfoWith:(School_data *)school_data {
    [_effective instance:NSLocalizedString(@"Localized_SearchListViewController_effective",comment:"")
          LeftStringFont:kAutoFont_(12)
         LeftStringColor:KTHEME_COLOR
         RightStringFont:kAutoFont_(20)
        RightStringColor:KTHEME_COLOR
            Right_String:[NSString stringWithFormat:@"%@ ",school_data.effective]];
    
    if(school_data) {
        if([school_data.photo hasPrefix:@"http"]) {
            [_logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",school_data.photo]] placeholderImage:[UIImage imageNamed:@"netPlaceHoder"] options:SDWebImageRetryFailed];
        }
        _SchoolName.text = school_data.nameSchool;
        _province.text = school_data.province;
        _cityName.text = school_data.cityName;
        _detailLabel.text = school_data.details;
        
        
        
        if ([school_data.hidden isEqualToString:@"1"])
        {
            _maintenance.image = [UIImage imageNamed:@"maintenance"];
            
        } else if ([school_data.hidden isEqualToString:@"0"])
        {
            _maintenance.image = [UIImage imageNamed:@""];
            
        }
        
        
    }
}
@end
