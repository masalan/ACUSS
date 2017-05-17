//
//  MainView_C.m
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MainView_C.h"
#import "MajorListCell.h"
#import "userAddGraduteMajor.h"
#import "ContactSchool.h"  // Contact school
#import "addSchoolReviewViewController.h"  // Add school review
#import "detailsByMajor.h"
#import "NOOrderView.h"
#import "adminAddMajor.h"

#define SW2 (SCREEN_HEIGHT/3)-40
#import "UIImageView+SDWDImageCache.h"
#define btnWidth SCREEN_WIDTH/3
#define btnHeight 44
#define logo_length SCREEN_WIDTH/3
#define SW3 (SCREEN_WIDTH/3)-10

#define lineH logo_length+52
#define lineBtn lineH+btnHeight+30

#define honorLabel 30

#define H logo_length + 44
@interface MainView_C ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImageView *typeImageView;
@property (nonatomic, assign) NSUInteger topSelectedTag;
@property (nonatomic, assign) NSUInteger Page;
@property (nonatomic, strong) UIButton *zufangBtn, *shiyouBtn, *fangyuanBtn,*hMenuBtn;
@property (nonatomic, strong) UIView *lineView,*myAdView,*adminViewBtn,*bottomView;
@property (nonatomic, strong) School_Details *schoolDetail; // Details School
@property (nonatomic, strong) SchoolDetail_Column_M *detailsMajors;// details colum
@property (nonatomic, strong) SchoolDetail_Column_M_List *all_majors_list;
@property (nonatomic, strong) SchoolDetail_Column_M_List *bachelor,*master,*phd;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;
@property (nonatomic, strong) UIImageView *leftImageView,*logoSchool;
@property (nonatomic, strong) Student_Details *individual_M;
@property (nonatomic, strong) NOOrderView *orderView;

@property (nonatomic, strong) UIScrollView *horizontalMenu;
//   _cycle_id = @"2";
@property (nonatomic, strong) NSString *cat_name,*cycle_id,*duration_study;
@property (nonatomic, strong) NSString *school_id,*CID,*CNAME;
@property (nonatomic, strong) UILabel *nameUniversity,*attributeIcone,*attribute,*levelIcone,*level,*typeIcone,*typeLb,*locationIcone,*location,*adminName;
@property (nonatomic, strong) UIButton *bottomBtn,*getMore,*addReview;
@property (nonatomic , assign)int                           count;


@end

@implementation MainView_C

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _topSelectedTag = 2;
        _school_id= @"";
        
        _Page = 1;
    }
    return self;
}

// ScrollView
- (TPKeyboardAvoidingScrollView *)backScrollView
{
    if(!_backScrollView)
    {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:_backScrollView];
    }
    return _backScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KCOLOR_WHITE;
    [self backScrollView];
    [self myAdView];
    [self showTopView];
    [self tableView];
    [self initUI];
    
    _Page = 1;
    [self getAllData];
    [self.tableView.header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllData)
                                                 name:KNOTIFICATION_ZufangSuccessed
                                               object:nil];
    
}


- (void)initUI
{
    IMP_BLOCK_SELF(MainView_C);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [block_self getAllData];
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.header = header;
    [header beginRefreshing];
    
    
    self.tableView.footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [block_self morBtnClick];
    }];
    
}


- (NOOrderView *)orderView {
    if(!_orderView) {
        _orderView = [[NOOrderView alloc] initWithFrame:CGRectMake(0, (_myAdView.bottom)+45,SCREEN_WIDTH, SCREEN_HEIGHT-((_myAdView.bottom)+150))];
        [self.view addSubview:_orderView];
        _orderView.titleLabel.text = @"";
        _orderView.orderLabel.text = @"\U0000e624";
    }
    return _orderView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fabu
{
    //
}




#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _all_majors_list.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_topSelectedTag == 2)
    {
        static NSString *cellIdentity = @"cell";
        MajorListCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if(cell == nil) {
            cell = [[MajorListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SchoolDetail_Column_M *mode = _all_majors_list.data[indexPath.row];
        cell.topSelectedTag = _topSelectedTag;
        [cell setMode:mode ];
        return cell;
    }
    else if (_topSelectedTag == 3)
    {
        static NSString *cellIdentity = @"cell";
        MajorListCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if(cell == nil) {
            cell = [[MajorListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SchoolDetail_Column_M *mode = _all_majors_list.data[indexPath.row];
        cell.topSelectedTag = _topSelectedTag;
        [cell setMode:mode ];
        return cell;
    }
    else if (_topSelectedTag == 4)
    {
        static NSString *cellIdentity = @"cell";
        MajorListCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if(cell == nil) {
            cell = [[MajorListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SchoolDetail_Column_M *mode = _all_majors_list.data[indexPath.row];
        cell.topSelectedTag = _topSelectedTag;
        [cell setMode:mode ];
        return cell;
    }
    
    return nil;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailsByMajor *vc = [[detailsByMajor alloc] init];
    vc.school_details = _all_majors_list.data[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self myAdView];
    
}


-(void)getUserData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User_infos/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] isEqual:@200]) {
            _individual_M = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            
             NSLog(@"Admin Status-------------------------_>%@",_individual_M.admin);
            
            if ([_individual_M.admin isEqualToString:@"6"])
            {
                [self adminViewBtn];
            }else{
                [self bottomView];
            }
            
        }
        
        if ([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        //
    }];
    
    
    
}

#pragma mark otherAction
- (void)morBtnClick
{
    DLog(@"more");
    _Page += _Page;
    [self getDownData];
    
}

- (void)headViewClick:(UIButton *)sender
{
    sender.selected = YES;
    if(sender.tag == 2)  // bachelor
    {
        DLog(@"bachelor");
        self.title = @"Undergraduate";
        _topSelectedTag =2;  // bachelor
        _Page = 1;
        if (_bachelor.data.count == 0) {
            [self getAllData];
        }
        else
            _all_majors_list = _bachelor;
        [self.tableView reloadData];
        [_hMenuBtn setTitleColor:KCOLOR_BLUE forState:UIControlStateNormal];
    }
    else if(sender.tag == 3)  // Master
    {
        DLog(@"master")
        self.title = @"PostGraduate";
        _topSelectedTag =3;  // Master
        _Page = 1;
        if (_master.data.count == 0) {
            [self getAllData];
        }
        else
            _all_majors_list = _master;
        
        [_hMenuBtn setTitleColor:KCOLOR_BLUE forState:UIControlStateNormal];
    }else if(sender.tag == 4)  // Phd
    {
        DLog(@"phd");
        self.title = @"Doctorat";
        _topSelectedTag = 4;  // Phd
        _Page = 1;
        if (_phd.data.count == 0) {
            [self getAllData];
        }
        else
            _all_majors_list = _phd;
        [_hMenuBtn setTitleColor:KCOLOR_BLUE forState:UIControlStateNormal];
    }else
    {
        DLog(@"bachelor");
        self.title = @"Bachelor courses Name";
        _topSelectedTag =2;  // bachelor
        _Page = 1;
        if (_bachelor.data.count == 0) {
            [self getAllData];
        }
        else
            _all_majors_list = _bachelor;
        [self.tableView reloadData];
        [_hMenuBtn setTitleColor:KCOLOR_BLUE forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

#pragma mark getAllData
- (void)getAllData
{
    IMP_BLOCK_SELF(MainView_C);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    _Page = 1;
    [params setObject:self.sess_id forKey:@"sess_id"];
    [params setObject:[NSString stringWithFormat:@"%ld",(unsigned long)_topSelectedTag] forKey:@"cycle_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    kSetDict(self.schoolId, @"school_id");
    [string appendString:@"Programs_cylce/majors_list"];//Bachelor List
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _all_majors_list = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if (_topSelectedTag == 2) {
                _bachelor = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
                _all_majors_list = _bachelor;
            }
            else if (_topSelectedTag == 3)
            {
                _master = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
                _all_majors_list = _master;
            }
            else if (_topSelectedTag == 4)
            {
                _phd = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
                _all_majors_list = _phd;
            }else
            {
                _bachelor = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
                _all_majors_list = _bachelor;
            }
            
            if(_all_majors_list.data.count <=15)
            {
                [self.tableView.footer noticeNoMoreData];
            }
            
            [block_self.tableView reloadData];
            [block_self.tableView.header endRefreshing];
            [self getSchoolData];
            [self getUserData];
        }else
        {
            _all_majors_list = nil;
        }
        [self.tableView reloadData];
        
    }failBlock:^(AFHTTPRequestOperation *operation, NSError *eror)
     {
         [block_self.tableView.header endRefreshing];
         _all_majors_list = nil;
         [self.tableView reloadData];
         
     }];
    
}




- (void)getDownData
{
    IMP_BLOCK_SELF(MainView_C);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    [params setObject:[NSString stringWithFormat:@"%ld",(unsigned long)_topSelectedTag] forKey:@"type"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    kSetDict(self.schoolId, @"school_id");
    [string appendString:@"Programs_cylce/majors_list"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _all_majors_list = nil;
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if (_topSelectedTag == 2)
            {
                SchoolDetail_Column_M_List *tmplist = [SchoolDetail_Column_M_List  objectWithKeyValues:responseObject];
                [_bachelor.data addObjectsFromArray:tmplist.data];
                _all_majors_list = _bachelor;
                [self.tableView.footer noticeNoMoreData];
                [block_self.tableView reloadData];
                [block_self.tableView.footer endRefreshing];
                [self getSchoolData];
                [self getUserData];
            }
            else if (_topSelectedTag == 3)
            {
                SchoolDetail_Column_M_List *tmplist = [SchoolDetail_Column_M_List  objectWithKeyValues:responseObject];
                [_master.data addObjectsFromArray:tmplist.data];
                _all_majors_list = _master;
                
                [self.tableView.footer noticeNoMoreData];
                [block_self.tableView reloadData];
                [block_self.tableView.footer endRefreshing];
                [self getSchoolData];
                [self getUserData];
            }
            else if (_topSelectedTag == 4)
            {
                SchoolDetail_Column_M_List *tmplist = [SchoolDetail_Column_M_List  objectWithKeyValues:responseObject];
                [_phd.data addObjectsFromArray:tmplist.data];
                _all_majors_list = _phd;
                [self.tableView.footer noticeNoMoreData];
                [block_self.tableView reloadData];
                [block_self.tableView.footer endRefreshing];
                [self getSchoolData];
                [self getUserData];
            }else{
                SchoolDetail_Column_M_List *tmplist = [SchoolDetail_Column_M_List  objectWithKeyValues:responseObject];
                [_phd.data addObjectsFromArray:tmplist.data];
                _all_majors_list = _phd;
                [self.tableView.footer noticeNoMoreData];
                [block_self.tableView reloadData];
                [block_self.tableView.footer endRefreshing];
                [self getSchoolData];
                [self getUserData];
            }
            
        }else if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self.tableView.footer noticeNoMoreData];
        }
        [self.tableView reloadData];
        
    }failBlock:^(AFHTTPRequestOperation *operation, NSError *eror)
     {
         [block_self.tableView.header endRefreshing];
         _all_majors_list = nil;
         [self.tableView reloadData];
         
     }];
}





// School details (Main)
- (void)getSchoolData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.schoolId, @"id");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/detail"];//server
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing]; //me
        self.schoolDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _schoolDetail = [School_Details objectWithKeyValues:responseObject[@"data"]];
            
            self.mainDetails.id = [self.schoolDetail.id copy];
            self.SID = [self.schoolDetail.id copy];
            self.NAME = [self.schoolDetail.nameSchool copy];
            
            self.mainDetails.nameSchool = [self.schoolDetail.nameSchool copy];
            self.schoolDetail.indexType = 0;
            [self.tableView reloadData];
            [self tableView];
            
            
            if([_schoolDetail.photo hasPrefix:@"http"]) {
                [_logoSchool sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_schoolDetail.photo]]
                               placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")]];
            }
            else {
                _logoSchool.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
            }
            
            if (_schoolDetail.nameSchool) {
                _nameUniversity.text = [NSString stringWithFormat:@"%@",_schoolDetail.nameSchool];
            }else{
                _nameUniversity.text = [NSString stringWithFormat:@"..."];
            }
            
            if (_schoolDetail.attribute) {
                _attribute.text = [NSString stringWithFormat:@"%@",_schoolDetail.attribute];
            }else{
                _attribute.text = [NSString stringWithFormat:@""];
            }
            
            if (_schoolDetail.level) {
                _level.text = [NSString stringWithFormat:@"%@",_schoolDetail.level];
            }else{
                _level.text = [NSString stringWithFormat:@""];
            }
            
            
            if (_schoolDetail.type) {
                _typeLb.text = [NSString stringWithFormat:@"%@",_schoolDetail.type];
            }else{
                _typeLb.text = [NSString stringWithFormat:@""];
            }
            
            
            
            if (_schoolDetail.locationName) {
                _location.text = [NSString stringWithFormat:NSLocalizedString(@"Localized_SchoolLineHeadView_location",comment:""),_schoolDetail.locationName];
            }else{
                _location.text = [NSString stringWithFormat:@""];
            }
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            // [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}






#pragma mark - init
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44+SW2, SCREEN_WIDTH, SCREEN_HEIGHT-SW2/2)
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = KCOLOR_CLEAR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



- (UIView *)bottomView
{
    if(!_bottomView)
    {
        
        // BUY
        
        _bottomView = [UIView createViewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 44, SCREEN_WIDTH, 44)
                                  backgroundColor:KCOLOR_WHITE];
        [self.view addSubview:_bottomView];
        
        // 1
        _bottomBtn = [UIButton createButtonwithFrame:CGRectMake(10, 6, SW3, 32)
                                     backgroundColor:KCOLOR_RED
                                          titleColor:KCOLOR_WHITE
                                                font:KSYSTEM_FONT_(12)
                                               title:@"Contacts"];
        _bottomBtn.layer.cornerRadius = 5.0;
        _bottomBtn.layer.masksToBounds = YES;
        
        _bottomBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            if([_bottomBtn.titleLabel.text isEqual: @"Contacts" ])
            {
                ContactSchool *vc = [[ContactSchool alloc] init];
                vc.SID = [self.schoolDetail.id copy];
                [self.navigationController pushViewController:vc animated:YES];
            }
            return [RACSignal empty];
        }];
        [self.bottomView addSubview:_bottomBtn];  //1
        
        //2
        UIButton *btnStartd = [UIButton createButtonwithFrame:CGRectMake(_bottomBtn.right+3, 6,SW3, 32)
                                              backgroundColor:KCOLOR_BLUE
                                                   titleColor:KCOLOR_WHITE
                                                         font:KSYSTEM_FONT_(12)
                                                        title:@"Graduate"
                                                conrnerRadius:5.0
                                                  borderWidth:1.0
                                                  borderColor:KCOLOR_BLUE];
        
        
        btnStartd.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            if([btnStartd.titleLabel.text isEqual: @"Graduate" ])
            {
                userAddGraduteMajor *vc = [[userAddGraduteMajor alloc] init];
                vc.SID = [self.schoolDetail.id copy];
                [self.navigationController pushViewController:vc animated:YES];
            }
            return [RACSignal empty];
        }];
        
        [_bottomView addSubview:btnStartd];  // ok
        
        // ADD REVIEW
        UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(btnStartd.right+3, 6, SW3, 32)
                                        backgroundColor:KCOLOR_GREEN_09bb07
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(12)
                                                  title:@"Comment"
                                          conrnerRadius:5.0
                                            borderWidth:1.0
                                            borderColor:KCOLOR_GREEN_09bb07];
        
        
        btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            if([btn.titleLabel.text isEqual: @"Comment" ])
            {
                addSchoolReviewViewController *vc = [[addSchoolReviewViewController alloc] init];
                vc.SID = [self.schoolDetail.id copy];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            return [RACSignal empty];
        }];
        [_bottomView addSubview:btn]; // ok
        
        
        
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}


-(UIView *)adminViewBtn
{
    if(!_adminViewBtn)
    {
        _adminViewBtn = [UIView createViewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 44, SCREEN_WIDTH, 44)
                                    backgroundColor:KCOLOR_BLACK];
        [self.view addSubview:_adminViewBtn];
        
        // adminName
        _adminName = [UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH-54, SCREEN_HEIGHT - 64 - 44-24, 44, 44)
                                   backgroundColor:KCOLOR_BLACK
                                         textColor:KCOLOR_WHITE
                                              font:KICON_FONT_(11)
                                     textalignment:NSTextAlignmentCenter
                                              text:@"Admin Edit"];
        
        _adminName.layer.cornerRadius = _adminName.size.height/2;
        _adminName.layer.masksToBounds = YES;
        _adminName.backgroundColor = KCOLOR_BLACK;
        
        _adminName.numberOfLines = 2;
        [self.view addSubview:_adminName];

        
        
        

        _bottomBtn = [UIButton createButtonwithFrame:CGRectMake(10, 6, SW3, 32)
                                     backgroundColor:KCOLOR_RED
                                          titleColor:KCOLOR_WHITE
                                                font:KSYSTEM_FONT_(9)
                                               title:@"Add bachelor major"];
        _bottomBtn.layer.cornerRadius = 5.0;
        _bottomBtn.layer.masksToBounds = YES;
        
        _bottomBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
           
            adminAddMajor *vc = [[adminAddMajor alloc] init];
            vc.SID = [self.schoolDetail.id copy];
            vc.NAME = [self.schoolDetail.nameSchool copy];
            vc.cycleId = bachelor;
            
            self.duration_study = @"4";
            vc.DURATION =  [self.duration_study copy];
            
            vc.CID = [self.schoolDetail.cycle_id copy];
            
            self.cat_name = @"Bachelor";
            vc.CNAME = [self.cat_name copy];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            return [RACSignal empty];
        }];
        [_adminViewBtn addSubview:_bottomBtn];  //1
        
        //2
        UIButton *btnStartd = [UIButton createButtonwithFrame:CGRectMake(_bottomBtn.right+3, 6,SW3, 32)
                                              backgroundColor:KTHEME_COLOR
                                                   titleColor:KCOLOR_WHITE
                                                         font:KSYSTEM_FONT_(9)
                                                        title:@"Add master major"
                                                conrnerRadius:5.0
                                                  borderWidth:1.0
                                                  borderColor:KTHEME_COLOR];
        
        
        btnStartd.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            adminAddMajor *vc = [[adminAddMajor alloc] init];
            vc.SID = [self.schoolDetail.id copy];
            vc.NAME = [self.schoolDetail.nameSchool copy];
            vc.cycleId = master;
            self.duration_study = @"3";
            vc.DURATION =  [self.duration_study copy];
            vc.CID = [self.schoolDetail.cycle_id copy];
            
            self.cat_name = @"Master";
            vc.CNAME = [self.cat_name copy];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            return [RACSignal empty];
        }];
        
        [_adminViewBtn addSubview:btnStartd];  // ok
        
        // 3
        UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(btnStartd.right+3, 6, SW3, 32)
                                        backgroundColor:KCOLOR_GREEN_09bb07
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(10)
                                                  title:@"Add Phd major"
                                          conrnerRadius:5.0
                                            borderWidth:1.0
                                            borderColor:KCOLOR_GREEN_09bb07];
        
        
        btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            adminAddMajor *vc = [[adminAddMajor alloc] init];
            vc.SID = [self.schoolDetail.id copy];
            vc.NAME = [self.schoolDetail.nameSchool copy];
            vc.cycleId = phd;
            self.duration_study = @"4";
            vc.DURATION =  [self.duration_study copy];
            vc.CID = [self.schoolDetail.cycle_id copy];
            self.cat_name = @"Phd";
            vc.CNAME = [self.cat_name copy];
            [self.navigationController pushViewController:vc animated:YES];
            
            return [RACSignal empty];
        }];
        [_adminViewBtn addSubview:btn]; // ok
        
        [self.view addSubview:_adminViewBtn];
    }
    return _adminViewBtn;
}





- (void)showTopView
{
    self.horizontalMenu = [[UIScrollView alloc] initWithFrame:CGRectMake(0,_myAdView.bottom, self.view.frame.size.width, 44)];
    NSArray *namearray = [NSArray array];
    namearray = @[@"Bachelor",@"Master",@"Phd",@"Introdcution",@"Accommodation",@"Facilities",@"Fee Structure",@"Documents"];
    int x = 0;
    for (int i = 0; i <namearray.count; i++) {
        _hMenuBtn = [UIButton createButtonwithFrame:CGRectMake(x, 0, SCREEN_WIDTH/3, 44)
                                    backgroundColor:KTHEME_COLOR
                                         titleColor:KCOLOR_WHITE
                                               font:kAutoFont_(14)
                                              title:namearray[i]
                                      conrnerRadius:8
                                        borderWidth:3
                                        borderColor:KCOLOR_WHITE];
        
        [_hMenuBtn setBackgroundColor:KTHEME_COLOR];
        _hMenuBtn.tag = 2-(-i);
        
        [_hMenuBtn addTarget:self
                      action:@selector(headViewClick:)
            forControlEvents:UIControlEventTouchUpInside];
        
        [_horizontalMenu addSubview:_hMenuBtn];
        x += _hMenuBtn.frame.size.width;
    }
    _horizontalMenu.contentSize = CGSizeMake(x, _horizontalMenu.frame.size.height);
    _horizontalMenu.backgroundColor = KCOLOR_WHITE;
    _horizontalMenu.showsHorizontalScrollIndicator = NO;
    _horizontalMenu.indicatorStyle= NO;
    [self.view addSubview:_horizontalMenu];
    
}




//top bar view

- (UIView *)myAdView
{
    if(!_myAdView)
    {
        _myAdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SW2)];
        
        //Logo
        if (!_logoSchool)
        {
            _logoSchool = [UIImageView createImageViewWithFrame:CGRectMake(10,25, logo_length, logo_length)
                                                backgroundColor:KCOLOR_CLEAR
                                                          image:nil];
            _logoSchool.layer.cornerRadius = _logoSchool.size.height/2;
            _logoSchool.layer.masksToBounds = YES;
            _logoSchool.backgroundColor = KCOLOR_CLEAR;
            _logoSchool.contentMode = UIViewContentModeScaleAspectFill;
            [_myAdView addSubview:_logoSchool];
            
        }
        // name University
        
        if (!_nameUniversity) {
            
            _nameUniversity = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10, 10, SCREEN_WIDTH-(logo_length+10)-20,50)
                                            backgroundColor:KCOLOR_CLEAR
                                                  textColor:KCOLOR_NAME_SCHOOL
                                                       font:KSYSTEM_FONT_(13)
                                              textalignment:NSTextAlignmentCenter
                                                       text:nil];
            _nameUniversity.numberOfLines = 3;
            [_myAdView addSubview:_nameUniversity];
            
        }
        
        // attribute University
        _attributeIcone = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10,_nameUniversity.bottom, 20,20)
                                        backgroundColor:KCOLOR_CLEAR
                                              textColor:KCOLOR_BLUE
                                                   font:KICON_FONT_(15)
                                          textalignment:NSTextAlignmentLeft
                                                   text:@"\U0000e781"];
        [_myAdView addSubview:_attributeIcone];
        
        // attribute University
        _attribute = [UILabel createLabelWithFrame:CGRectMake(_attributeIcone.right+2,_nameUniversity.bottom, SCREEN_WIDTH-(logo_length+30)-10,20)
                                   backgroundColor:KCOLOR_CLEAR
                                         textColor:KCOLOR_GRAY
                                              font:KICON_FONT_(10)
                                     textalignment:NSTextAlignmentLeft
                                              text:nil];
        [_myAdView addSubview:_attribute];
        
        
        
        // Level Icone
        _levelIcone = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10,_attribute.bottom, 20,20)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_Black_343434
                                               font:KICON_FONT_(15)
                                      textalignment:NSTextAlignmentLeft
                                               text:@"\U0000e76a"];
        [_myAdView addSubview:_levelIcone];
        
        // Level University
        _level = [UILabel createLabelWithFrame:CGRectMake(_attributeIcone.right+2,_attribute.bottom, SCREEN_WIDTH-(logo_length+30)-10,20)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_GRAY
                                          font:KICON_FONT_(10)
                                 textalignment:NSTextAlignmentLeft
                                          text:nil];
        
        [_myAdView addSubview:_level];
        
        
        
        // Type Icone
        _typeIcone = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10,_level.bottom, 20,20)
                                   backgroundColor:KCOLOR_CLEAR
                                         textColor:KCOLOR_GREEN
                                              font:KICON_FONT_(15)
                                     textalignment:NSTextAlignmentLeft
                                              text:@"\U0000e601"];
        [_myAdView addSubview:_typeIcone];
        
        // Type University
        _typeLb = [UILabel createLabelWithFrame:CGRectMake(_attributeIcone.right+2,_level.bottom, SCREEN_WIDTH-(logo_length+30)-10,20)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_GRAY
                                           font:KICON_FONT_(10)
                                  textalignment:NSTextAlignmentLeft
                                           text:nil];
        
        
        [_myAdView addSubview:_typeLb];
        // Type Icone
        _locationIcone = [UILabel createLabelWithFrame:CGRectMake(_logoSchool.right+10,_typeLb.bottom, 20,20)
                                       backgroundColor:KCOLOR_CLEAR
                                             textColor:KCOLOR_RED
                                                  font:KICON_FONT_(15)
                                         textalignment:NSTextAlignmentLeft
                                                  text:@"\U0000e677"];
        [_myAdView addSubview:_locationIcone];
        
        // Type University
        _location = [UILabel createLabelWithFrame:CGRectMake(_attributeIcone.right+2,_typeLb.bottom, SCREEN_WIDTH-(logo_length+30)-10,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_GRAY
                                             font:KICON_FONT_(10)
                                    textalignment:NSTextAlignmentLeft
                                             text:nil];
        
        [_myAdView addSubview:_location];
        
        [_backScrollView addSubview:_myAdView];
    }
    return _myAdView;
}



@end







@implementation majorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
        _photoView.backgroundColor = KCOLOR_GRAY_WD;
        [self addSubview:_photoView];
        
        
    }
    return self;
}

@end

