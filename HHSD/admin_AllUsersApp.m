//
//  admin_AllUsersApp.m
//  HHSD
//
//  Created by alain serge on 5/11/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "admin_AllUsersApp.h"
#import "MainView_C.h"
#import "SWTableViewCell.h"
#import "IMQuickSearch.h"
#import "userAddGraduteMajor.h"
#import "MainView_C.h"
#define kNumberOfObjects 200
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2
#define SW3 SCREEN_WIDTH/3

#define D 50
#import "CityViewSelectCell.h"
#import "ecoleSearch.h"
#import "SearchModel.h"
#import "UsersModel.h"
#import "MJRefreshGifHeader.h"
#import "GYHHeadeRefreshController.h"

#import "NOOrderView.h"

@interface admin_AllUsersApp ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,SWTableViewCellDelegate,MyUsersListDelegate>
{
    int _page;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *recordList;
@property (nonatomic, strong) IMQuickSearch *QuickSearch;
@property (nonatomic, strong) NSArray *People;
@property (nonatomic, strong) NSArray *Animals;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) NSArray *FilteredResults;
@property (nonatomic, retain) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, retain) NSString *Islike;
@property (nonatomic, retain) NSString *hidden;
@property (nonatomic, retain) NSString *SID;
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) All_Province_List *province_list;
@property (nonatomic, strong) Province_List_details *province_details;
@property (nonatomic, strong) NOOrderView *orderView;
@property (nonatomic , assign)int                           count;

@property (nonatomic, strong) All_Users_list *usersList;
@property (nonatomic, strong) All_Users_list *allusers_list;



@end

@implementation admin_AllUsersApp

- (NOOrderView *)orderView {
    if(!_orderView) {
        _orderView = [[NOOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.view addSubview:_orderView];
        _orderView.titleLabel.text = @"Error Loading";
        _orderView.orderLabel.text = @"\U0000e601";
    }
    return _orderView;
}
- (instancetype)init
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    return self;
}

#pragma mark - init
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = KCOLOR_CLEAR;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];  // hide separtor line
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Users";
    
    _page = 1;
    [self tableView];
    [self getAllData:NO];
    [self initUI];
    
    [self addSearchBtnRight];
    
}


- (void)initUI
{
    IMP_BLOCK_SELF(admin_AllUsersApp);
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        block_self.count = 0;
        [block_self getAllData:NO];
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.header = header;
    [header beginRefreshing];
    
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [block_self getAllData:YES];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    DLog(@"%@",self.title);
}

-(void)addSearchBtnRight {
    UIButton *barButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    [barButton setTitle:@"\U0000e662" forState:UIControlStateNormal];
    barButton.titleLabel.font = KICON_FONT_(20);
    [barButton addTarget:self action:@selector(ecoleSearch) forControlEvents:UIControlEventTouchUpInside];
    [barButton setTitleColor:[PublicMethod getNaviBarItemColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

// serach clikc
-(void)ecoleSearch
{
    ecoleSearch *vc = [[ecoleSearch alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark
#pragma mark otherAction
- (void)rightNavBtnClick:(UIButton *)sender
{
    DLog(@"City click");
    sender.selected = !sender.selected;
    if(sender.selected)
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44);
        } completion:^(BOOL finished) {
            
        }];
    }else
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.collectionView.frame = CGRectMake(0, - SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44);
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark
#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (SW2-60)+90;
    }
    else{
        return SW2-60;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    School_Details *detailsSchool = _searchList.school[indexPath.row];
//    MainView_C *vc = [[MainView_C alloc] init];
//    vc.schoolId = detailsSchool.id;
//    
//    School_data *stats = _searchList.school[indexPath.row];
//    NSString *hidden;
//    hidden = stats.hidden;
//    
//    if ([hidden isEqualToString:@"1"])  // its coming soon
//    {
//        
//    } else if ([hidden isEqualToString:@"0"])  // open new page
//    {
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }
//    
    
    
}

- (void)setClickView
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    //[params setObject:tmp.SID forKey:@"id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Schools/addView"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
    
}


-(void)addItem:(UIButton*) sender
{
    
}






#pragma mark
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"cells";
    adminAllUsersListCell *cells = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cells == nil) {
        cells = [[adminAllUsersListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellIdentity];
    }
    if (_allusers_list.users.count >0) {
        Users_view_data *mode =_allusers_list.users[indexPath.row];
        [cells setInfoWith:mode];
    }
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    Users_view_data *tmp =  _allusers_list.users[indexPath.row];
    _hidden = [NSString stringWithFormat:@"%@",tmp.deleted];
    
    // Delted/ Live
    if ([_hidden isEqualToString:@"1"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:KCOLOR_RED  title:@"Deleted"];
    }
    else if ([_hidden isEqualToString:@"0"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:KCOLOR_BLUE title:@"Live"];
    }
    [cells setRightUtilityButtons:rightUtilityButtons WithButtonWidth:80.0];

    cells.delegate = self;
    cells.tag = indexPath.row;
    return cells;
}



#pragma mark
#pragma mark ----- SWCellDelegate -----
// click event on right utility button
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    ;
    
    
    NSLog(@" Like click");
    Users_view_data *tmp =  _allusers_list.users[cell.tag];

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    [params setObject:tmp.id forKey:@"id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Manager/delete_user"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            //[_allusers_list.users removeObjectAtIndex:tmp.indexPath.row];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:tmp.indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}





// AllSchoolListCell
#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_allusers_list.users.count>0) {
        return 1;
    }
    else
        return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _allusers_list.users.count;
      //return  self.usersList.users.count;
    //All_Users_list
}

#pragma mark - getAllData
//- (void)getAllData
- (void)getAllData:(BOOL)more
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (more) {
        _page++;
    }
    NSString *currentPage = [NSString stringWithFormat:@"%d",_page];
    kSetDict(currentPage, @"page");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"manager/users"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            
            _allusers_list = [All_Users_list objectWithKeyValues:responseObject[@"data"]];
            if (_allusers_list.users.count == 0 ) {
                [self orderView];
                self.orderView.hidden = NO;
            }
            [self.tableView reloadData];
            [self tableView ];
            
            if (_allusers_list.users.count<15)
            {
                [self.tableView.footer noticeNoMoreData];
            }
            
           }else
          {
            _allusers_list = nil;
            _allusers_list = [All_Users_list objectWithKeyValues:responseObject[@"data"]];
            
            
            [self.tableView reloadData];
            [self tableView ];
            if([[responseObject objectForKey:@"code"] isEqual:@500])
            {
                [self orderView];
                self.orderView.hidden = NO;
            }else
            {
                [self orderView];
                self.orderView.hidden = NO;
            }
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self orderView];
            self.orderView.hidden = NO;
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}



#pragma mark
#pragma mark getAllData
// get province select
/*****
- (void)getCityData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Schools/provinces"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.collectionView = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            self.province_list = [All_Province_List objectWithKeyValues:responseObject[@"data"]];
            [self.collectionView reloadData];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView.header endRefreshing];
    }];
    
}



- (void)AddViewActionBtnClick:(Users_view_data *)mode;
{
    DLog(@"cell Click");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(mode.id, @"id");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"schools/addView"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[mode.indexPath copy], nil] withRowAnimation:UITableViewRowAnimationFade];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
    
}


*****/





@end











@implementation adminAllUsersListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor=KCOLOR_WHITE;
        [self addContent];
    }
    return  self;
}

-(void)addContent {
    _logoImageView = [[UIImageView alloc] init];
    _maintenance = [[UIImageView alloc] init];
    _fbook = [[UIImageView alloc] init];
    _google = [[UIImageView alloc] init];
    _linkedln = [[UIImageView alloc] init];
    _countryCode = [[UIImageView alloc] init];
    _province = [[UILabel alloc] init];
    _cityTypeIcone = [[UIImageView alloc] init];
     _userAdressIcone = [[UILabel alloc] init];
    _userAdressIconeNow = [[UILabel alloc] init];
    _cityTypeName = [[UILabel alloc] init];
    _climateTypeIcone = [[UIImageView alloc] init];
    _userIconeLocationChina = [[UILabel alloc] init];
    _climateTypeName = [[UILabel alloc] init];
    _livingTypeIcone = [[UIImageView alloc] init];
    _userLocationChina = [[UILabel alloc] init];
    _livingTypeName = [[UILabel alloc] init];
    _lineOne = [[UILabel alloc] init];
    _lineTwo = [[UILabel alloc] init];
    _iconeUserSex = [[UILabel alloc] init];
    _SchoolName = [[UILabel alloc] init];
    _cityName = [[UILabel alloc] init];
    _detailLabel = [[UILabel alloc] init];
    _integralLabel = [[UILabel alloc] init];
    _userFullname = [[UILabel alloc] init];
    _userBirthday = [[UILabel alloc] init];
    _userMobile = [[UILabel alloc] init];
    
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SW2/2, SW2/2)];
    _logoImageView.backgroundColor = KCOLOR_WHITE;
    _logoImageView.layer.cornerRadius = _logoImageView.size.height/2;
    _logoImageView.layer.masksToBounds = YES;
    _logoImageView.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.cellScrollView addSubview:_logoImageView ];
    
    
    // smallAvatar
    
    //maintenance
    _maintenance = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50,45,30,30)];
    _maintenance.backgroundColor = KCOLOR_CLEAR;
    _maintenance.layer.cornerRadius = _maintenance.size.height/2;
    _maintenance.layer.masksToBounds = YES;
    _maintenance.backgroundColor = KCOLOR_CLEAR;
    _maintenance.contentMode = UIViewContentModeScaleAspectFill;
    [self.cellScrollView addSubview:_maintenance ];
    
    
   
    
   
    // name Icone
   _iconeUserSex  = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10,13,20,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KTHEME_COLOR
                                             font:KICON_FONT_(15)
                                    textalignment:NSTextAlignmentLeft
                                             text:@"\U0000e634"];
    [self.cellScrollView addSubview:_iconeUserSex];
    
    
    // userFullname
        _userFullname = [UILabel createLabelWithFrame:CGRectMake(_iconeUserSex.right+5,10,SCREEN_WIDTH-(((SW2/2)+10)+50),30)
                              backgroundColor:KCOLOR_CLEAR
                                    textColor:KTHEME_COLOR
                                         font:kAutoFont_(13)
                                textalignment:NSTextAlignmentLeft
                                         text:@""];
    _userFullname.numberOfLines= 2;
    [self.cellScrollView addSubview:_userFullname];
    
    
    
    // Birthday Icone
    UILabel *birthdayIcone  = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10,_userFullname.bottom+2,20,20)
                                        backgroundColor:KCOLOR_CLEAR
                                              textColor:KTHEME_COLOR
                                                   font:KICON_FONT_(15)
                                          textalignment:NSTextAlignmentLeft
                                                   text:@"\U0000e771"];
    [self.cellScrollView addSubview:birthdayIcone];
    
    // userBirthday
    _userBirthday = [UILabel createLabelWithFrame:CGRectMake(birthdayIcone.right+5,_userFullname.bottom,(SCREEN_WIDTH-(((SW2/2)+10)+50))/2.8,30)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KTHEME_COLOR
                                             font:kAutoFont_(10)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
    [self.cellScrollView addSubview:_userBirthday];
    
    // mobile Icone
    UILabel *mobileIcone  = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10,_userBirthday.bottom+2,20,20)
                                            backgroundColor:KCOLOR_CLEAR
                                                  textColor:KTHEME_COLOR
                                                       font:KICON_FONT_(15)
                                              textalignment:NSTextAlignmentLeft
                                                       text:@"\U0000e624"];
    [self.cellScrollView addSubview:mobileIcone];
    
    
    // userMobile
    _userMobile = [UILabel createLabelWithFrame:CGRectMake(mobileIcone.right+5,_userBirthday.bottom,(SCREEN_WIDTH-(((SW2/2)+10)+20))/2.8,30)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_BLUE
                                             font:kAutoFont_(10)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
    [self.cellScrollView addSubview:_userMobile];
    
    
    _countryCode = [[UIImageView alloc] initWithFrame:CGRectMake(_userBirthday.right+2, _userFullname.bottom,20,17)];
    _countryCode.backgroundColor = KCOLOR_CLEAR;
    _countryCode.contentMode = UIViewContentModeScaleToFill;
    [self.cellScrollView  addSubview:_countryCode ];
    
    // Country user
    _province = [UILabel createLabelWithFrame:CGRectMake(_countryCode.right+5, _userFullname.bottom,(SCREEN_WIDTH-(((SW2/2)+10)+50))/2,20)
                              backgroundColor:KCOLOR_CLEAR
                                    textColor:KCOLOR_Black_343434
                                         font:kAutoFont_(10)
                                textalignment:NSTextAlignmentLeft
                                         text:@""];
    _province.numberOfLines= 2;
    [self.cellScrollView addSubview:_province];
    
    // City Name
    
    _cityName = [UILabel createLabelWithFrame:CGRectMake(_province.right+5, _SchoolName.bottom+1,(SCREEN_WIDTH-135)/2,20)
                              backgroundColor:KCOLOR_CLEAR
                                    textColor:KCOLOR_Black_343434
                                         font:kAutoFont_(12)
                                textalignment:NSTextAlignmentLeft
                                         text:@""];
    [self.cellScrollView addSubview:_cityName];
    
    // Foreigner students total
    _effective = [[ColorLabel alloc] initWithFrame:CGRectMake(_logoImageView.right+10, _cityName.bottom+1,SCREEN_WIDTH-(_logoImageView.right+50),20)];
    _effective.backgroundColor = KCOLOR_CLEAR;
    [self.cellScrollView addSubview:_effective];
    
    
    
    // Description
    _detailLabel =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH-25,10,20,20)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_RED
                                           font:KICON_FONT_(15)
                                  textalignment:NSTextAlignmentLeft
                                           text:nil];
    _detailLabel.numberOfLines = 12;
    _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.cellScrollView addSubview:_detailLabel];
    
    
    
    _integralLabel =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 120, 70, 110, 20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_GRAY_999999
                                             font:kAutoFont_(12)
                                    textalignment:NSTextAlignmentRight
                                             text:@""];
    [self.cellScrollView addSubview:_integralLabel];
    _integralLabel.hidden = YES; //hidden
    
    
    
    // Facebook Icone
    _cityTypeIcone = [[UIImageView alloc] initWithFrame:CGRectMake((SW3/2)-12,(SW2-60),20,20)];
    _cityTypeIcone.backgroundColor = KCOLOR_WHITE;
    _cityTypeIcone.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
    _cityTypeIcone.contentMode = UIViewContentModeScaleAspectFill;
    [self.cellScrollView addSubview:_cityTypeIcone ];
    
    // City Name
    _cityTypeName = [UILabel resizeFrameWithLabel:_cityTypeName
                                            frame:CGRectMake(0,_cityTypeIcone.bottom,SW3,30)
                                  backgroundColor:KCOLOR_WHITE
                                        textColor:KCOLOR_BLACK
                                             font:KICON_FONT_(11)
                                    textalignment:NSTextAlignmentCenter
                                             text:@""];
    _cityTypeName.numberOfLines =3;
    [self.cellScrollView addSubview:_cityTypeName];
    
    
    
    // Linkedln Icone
    _climateTypeIcone = [[UIImageView alloc] initWithFrame:CGRectMake(SW3+((SW3/2)-12),(SW2-60),20,20)];
    _climateTypeIcone.backgroundColor = KCOLOR_WHITE;
    _climateTypeIcone.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
    _climateTypeIcone.contentMode = UIViewContentModeScaleAspectFill;
    [self.cellScrollView addSubview:_climateTypeIcone ];
    
   
    
    
    // Climate Name
    _climateTypeName = [UILabel resizeFrameWithLabel:_climateTypeName
                                               frame:CGRectMake(SW3,_climateTypeIcone.bottom,SW3,30)
                                     backgroundColor:KCOLOR_WHITE
                                           textColor:KCOLOR_BLACK
                                                font:KICON_FONT_(11)
                                       textalignment:NSTextAlignmentCenter
                                                text:@""];
    _climateTypeName.numberOfLines =3;
    [self.cellScrollView addSubview:_climateTypeName];
    
    
    
    
    // Google Icone
    _livingTypeIcone = [[UIImageView alloc] initWithFrame:CGRectMake(2*SW3+((SW3/2)-12),(SW2-60),20,20)];
    _livingTypeIcone.backgroundColor = KCOLOR_WHITE;
    _livingTypeIcone.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
    _livingTypeIcone.contentMode = UIViewContentModeScaleAspectFill;
    [self.cellScrollView addSubview:_livingTypeIcone ];

    
    
    // Living Name
    
    _livingTypeName = [UILabel resizeFrameWithLabel:_livingTypeName
                                              frame:CGRectMake(2*SW3,_livingTypeIcone.bottom,SW3,20)
                                    backgroundColor:KCOLOR_WHITE
                                          textColor:KCOLOR_BLACK
                                               font:KICON_FONT_(11)
                                      textalignment:NSTextAlignmentCenter
                                               text:@""];
    _livingTypeName.numberOfLines =3;
    [self.cellScrollView addSubview:_livingTypeName];
    
    
    
    
    
    _lineOne = [UILabel resizeFrameWithLabel:_lineOne
                                       frame:CGRectMake(SW3-0.5,_cityTypeIcone.bottom,0.5,40)
                             backgroundColor:KCOLOR_GRAY_Cell
                                   textColor:KCOLOR_GRAY_Cell
                                        font:KICON_FONT_(11)
                               textalignment:NSTextAlignmentCenter
                                        text:@""];
    [self.cellScrollView addSubview:_lineOne];
    
    
    _lineTwo = [UILabel resizeFrameWithLabel:_lineTwo
                                       frame:CGRectMake(_climateTypeName.right-0.5,_climateTypeIcone.bottom,0.5,40)
                             backgroundColor:KCOLOR_GRAY_Cell
                                   textColor:KCOLOR_GRAY_Cell
                                        font:KICON_FONT_(11)
                               textalignment:NSTextAlignmentCenter
                                        text:@""];
    [self.cellScrollView addSubview:_lineTwo];
    
    
    // userLocationChina
    _userLocationChina = [UILabel resizeFrameWithLabel:_userLocationChina
                                              frame:CGRectMake(10,_lineTwo.bottom+5,SW2-35,20)
                                    backgroundColor:KCOLOR_WHITE
                                          textColor:KCOLOR_BLACK
                                               font:KICON_FONT_(10)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
    [self.cellScrollView addSubview:_userLocationChina];
    
    //userAdressIcone
    _userAdressIcone = [UILabel resizeFrameWithLabel:_userAdressIcone
                                                      frame:CGRectMake(_userLocationChina.right+1,_lineTwo.bottom+5,SW2-10,20)
                                            backgroundColor:KCOLOR_WHITE
                                                  textColor:KCOLOR_BLACK
                                                       font:KICON_FONT_(11)
                                              textalignment:NSTextAlignmentLeft
                                                       text:@""];
    [self.cellScrollView addSubview:_userAdressIcone];
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(25, 0, SCREEN_WIDTH-50, 0.5)
                                   backgroundColor:KCOLOR_RED];
    [self.cellScrollView addSubview:lineView];
    
    
    _actionBtn = [UIButton createButtonwithFrame:CGRectMake(0,0,SCREEN_WIDTH, SW2-40)
                                 backgroundColor:KCOLOR_CLEAR
                                      titleColor:KCOLOR_CLEAR
                                            font:KSYSTEM_FONT_(11)
                                           title:nil];
    [_actionBtn addTarget:self action:@selector(actionAddviewClick) forControlEvents:UIControlEventTouchUpInside];
    // [self.cellScrollView addSubview:_actionBtn];
    
    
    
}

- (void)setInfoWith:(Users_view_data *)users_data {
  
    
    
    if(users_data) {
        if([users_data.avatar_user hasPrefix:@"http"]) {
            [_logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",users_data.avatar_user]] placeholderImage:[UIImage imageNamed:@"6000"] options:SDWebImageRetryFailed];
        }
        
        _cityTypeLabel.text = users_data.total_comments;
         _climateTypeLabel.text = users_data.total_forms;
         _livingTypeLabel.text = users_data.total_like;
        _userFullname.text = users_data.fullName;
         _userBirthday.text = [PublicMethod getYMDUsingCreatedTimestamp:users_data.birthday ];
        _province.text = users_data.country;
        _userMobile.text = users_data.mobile;
        _userLocationChina.text = [NSString stringWithFormat:@"\U0000e677 %@/%@/%@",users_data.province_name,users_data.city_name,users_data.area_name];
        _userAdressIcone.text = [NSString stringWithFormat:@"\U0000e66d %@",users_data.homeAdress];
        
        //  users_data.province_name,users_data.city_name,users_data.area_name
        
        // Flag view
        NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@",users_data.Codecountry];
        
        if(users_data.Codecountry) {
            _countryCode.image = [UIImage imageNamed:imagePath];
        }
        else
        {
            _countryCode.image = [UIImage imageNamed:@""];
        }
        
        // Facebook
        if ([users_data.facebook isEqualToString:@"1"])
        {
            _cityTypeIcone.image = [UIImage imageNamed:@"fbook"];
            _cityTypeName.text = @"Logged";
            
        }
        else if ([users_data.facebook isEqualToString:@"0"])
        {
            _cityTypeIcone.image = [UIImage imageNamed:@"fbook"];
            _cityTypeName.text = @"log out";
            _cityTypeName.textColor = KCOLOR_RED;
        }
        
        //linkedinBtn
        if ([users_data.linkedln isEqualToString:@"1"])
        {
            _climateTypeIcone.image = [UIImage imageNamed:@"linkedinBtn"];
            _livingTypeName.text = @"Logged";
            
        }
          else if ([users_data.facebook isEqualToString:@"0"])
        {
            _climateTypeIcone.image = [UIImage imageNamed:@"linkedinBtn"];
            _livingTypeName.text = @"log out";
            _livingTypeName.textColor = KCOLOR_RED;
        }

        //Google
        if ([users_data.google isEqualToString:@"1"])
        {
            _livingTypeIcone.image = [UIImage imageNamed:@"googleBtn"];
            _climateTypeName.text = @"Logged";
            
        }
          else if ([users_data.google isEqualToString:@"0"])
        {
            _livingTypeIcone.image = [UIImage imageNamed:@"googleBtn"];
            _climateTypeName.text = @"Log out";
            _climateTypeName.textColor = KCOLOR_RED;

        }
        
        
        //_iconeUserSex
        
        // Sex
        if ([users_data.sex isEqualToString:@"0"])
        {
            _iconeUserSex.text = @"\U0000e634";
            
        }
        else if ([users_data.sex isEqualToString:@"1"])
        {
            _iconeUserSex.text = @"\U0000e60f";
            _iconeUserSex.textColor = KCOLOR_RED;
            
        }
        else if ([users_data.sex isEqualToString:@"2"])
        {
            _iconeUserSex.text = @"\U0000e690";
            _iconeUserSex.textColor = KCOLOR_BLUE;

        }else
        {
            _iconeUserSex.text = @"\U0000e634";
            
        }
        
        
       
       
        
        
        

    }
}

-(void)actionAddviewClick
{
    
}






@end


