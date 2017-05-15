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
@property (nonatomic, strong) UIButton *zufangBtn, *shiyouBtn, *fangyuanBtn;
@property (nonatomic, strong) UIView *lineView,*myAdView,*adminViewBtn,*bottomView;
@property (nonatomic, strong) School_Details *schoolDetail; // Details School
@property (nonatomic, strong) SchoolDetail_Column_M *detailsMajors;// details colum
@property (nonatomic, strong) SchoolDetail_Column_M_List *all_majors_list;
@property (nonatomic, strong) SchoolDetail_Column_M_List *bachelor,*master,*phd;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;
@property (nonatomic, strong) UIImageView *leftImageView,*logoSchool;
@property (nonatomic, strong) Student_Details *individual_M;
@property (nonatomic, strong) NOOrderView *orderView;


//$cycle_id
@property (nonatomic, strong) NSString *school_id;
@property (nonatomic, strong) UILabel *nameUniversity,*attributeIcone,*attribute,*levelIcone,*level,*typeIcone,*typeLb,*locationIcone,*location;

@property (nonatomic, strong) UIButton *bottomBtn,*getMore,*addReview;


@end

@implementation MainView_C


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



- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _topSelectedTag = 1;
        _school_id= @"";
        
        _Page = 1;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select Featured Program";
    self.view.backgroundColor = KCOLOR_WHITE;
    [self backScrollView];
    [self myAdView];
    [self showTopView];
    [self tableView];
    
    //[self bottomView];
    
    [self selectViewAdmin];
    _Page = 1;
    [self getAllData];
    __weak typeof(self) weakself = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakself getAllData];
    }];
    [self.tableView addGifFooterWithRefreshingBlock:^{
        [weakself morBtnClick];
    }];
    [self.tableView.header beginRefreshing];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllData)
                                                 name:KNOTIFICATION_ZufangSuccessed
                                               object:nil];
}


-(void)selectViewAdmin
{
    if ([_individual_M.admin isEqualToString:@"6"])
    {
        [self adminViewBtn];
    }else{
        [self bottomView];
    }
}

- (NOOrderView *)orderView {
    if(!_orderView) {
        _orderView = [[NOOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.view addSubview:_orderView];
        _orderView.titleLabel.text = @"Maintenance";
        _orderView.orderLabel.text = @"\U0000e603";
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
    if(sender.tag ==2)
    {
        DLog(@"bachelor");
        self.title = @"Bachelor courses Name";
        _topSelectedTag =2;
        _Page = 1;
        if (_bachelor.data.count == 0) {
            [self getAllData];
            [self orderView];
            self.orderView.hidden = YES;
        }
        else
            _all_majors_list = _bachelor;
        
        [_zufangBtn setTitleColor:KTHEME_COLOR forState:UIControlStateNormal];
        [_shiyouBtn setTitleColor:KCOLOR_Black_343434 forState:UIControlStateNormal];
        [_fangyuanBtn setTitleColor:KCOLOR_Black_343434 forState:UIControlStateNormal];
        _lineView.frame = CGRectMake(0, 42, SCREEN_WIDTH/3, 2);
    }
    else if(sender.tag == 3)
    {
        DLog(@"master")
        self.title = @"Master courses Name";
        _topSelectedTag =3;
        _Page = 1;
        if (_master.data.count == 0) {
            [self getAllData];
            [self orderView];
            self.orderView.hidden = YES;
        }
        else
            _all_majors_list = _master;
        
        [_zufangBtn setTitleColor:KCOLOR_Black_343434 forState:UIControlStateNormal];
        [_shiyouBtn setTitleColor:KTHEME_COLOR forState:UIControlStateNormal];
        [_fangyuanBtn setTitleColor:KCOLOR_Black_343434 forState:UIControlStateNormal];
        _lineView.frame = CGRectMake(SCREEN_WIDTH/3, 42, SCREEN_WIDTH/3, 2);
    }else
    {
        DLog(@"phd");
        self.title = @"Phd courses Name";
        _topSelectedTag = 4;
        _Page = 1;
        if (_phd.data.count == 0) {
            [self getAllData];
            [self orderView];
            self.orderView.hidden = YES;
        }
        else
            _all_majors_list = _phd;
        
        [_zufangBtn setTitleColor:KCOLOR_Black_343434 forState:UIControlStateNormal];
        [_shiyouBtn setTitleColor:KCOLOR_Black_343434 forState:UIControlStateNormal];
        [_fangyuanBtn setTitleColor:KTHEME_COLOR forState:UIControlStateNormal];
        _lineView.frame = CGRectMake(SCREEN_WIDTH/3*2, 42, SCREEN_WIDTH/3, 2);
    }
    [self.tableView reloadData];
}

#pragma mark getAllData
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    [params setObject:[NSString stringWithFormat:@"%ld",(unsigned long)_topSelectedTag] forKey:@"cycle_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    
    if (_topSelectedTag == 2)    // bachelor
    {
        kSetDict(self.schoolId, @"school_id");
        [string appendString:@"Programs_cylce/majors_list"];//Bachelor List
        [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.tableView.header endRefreshing];
            _all_majors_list = nil;
            if([[responseObject objectForKey:@"code"] isEqual:@200])
            {
                _bachelor = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
                _all_majors_list = _bachelor;
                [self getSchoolData];
                 [self getUserData];
                
                if(_all_majors_list.data.count <=15)
                {
                    [self.tableView.footer noticeNoMoreData];
                }
                [self.tableView reloadData];
            }
            if([[responseObject objectForKey:@"code"] isEqual:@500])
            {
                [self MBShowHint:responseObject[@"message"]];
            }
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            [self.tableView reloadData];
            _all_majors_list = nil;
            [self.tableView.header endRefreshing];
        }];
        
        
    }
    else if (_topSelectedTag == 3)    // Master
    {
        
        kSetDict(self.schoolId, @"school_id");
        [string appendString:@"Programs_cylce/majors_list"];//Bachelor List
        [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.tableView.header endRefreshing];
            _all_majors_list = nil;
            if([[responseObject objectForKey:@"code"] isEqual:@200])
            {
                _master = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
                _all_majors_list = _master;
                [self getSchoolData];
                 [self getUserData];
                
                if(_all_majors_list.data.count <=15)
                {
                    [self.tableView.footer noticeNoMoreData];
                }
                [self.tableView reloadData];
            }
            if([[responseObject objectForKey:@"code"] isEqual:@500])
            {
                [self MBShowHint:responseObject[@"message"]];
            }
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            [self.tableView reloadData];
            _all_majors_list = nil;
            [self.tableView.header endRefreshing];
        }];
        
        
    }
    else    // phd
    {
        kSetDict(self.schoolId, @"school_id");
        [string appendString:@"Programs_cylce/majors_list"];//PHD List
        [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.tableView.header endRefreshing];
            _all_majors_list = nil;
            if([[responseObject objectForKey:@"code"] isEqual:@200])
            {
                _phd = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
                _all_majors_list = _phd;
                [self getSchoolData];
                [self getUserData];
                if(_all_majors_list.data.count <=15)
                {
                    [self.tableView.footer noticeNoMoreData];
                }
                [self.tableView reloadData];
            }
            if([[responseObject objectForKey:@"code"] isEqual:@500])
            {
                [self MBShowHint:responseObject[@"message"]];
            }
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            [self.tableView reloadData];
            _all_majors_list = nil;
            [self.tableView.header endRefreshing];
        }];
        
    }
}

- (void)getDownData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    [params setObject:[NSString stringWithFormat:@"%ld",(unsigned long)_topSelectedTag] forKey:@"type"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    
    if (_topSelectedTag == 2)    // bachelor
    {
        kSetDict(self.schoolId, @"school_id");
        [string appendString:@"Programs_cylce/majors_list"];//Bachelor List
        [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.tableView.header endRefreshing];
            _all_majors_list = nil;
            if([[responseObject objectForKey:@"code"] isEqual:@200])
            {
                SchoolDetail_Column_M_List *tmplist = [SchoolDetail_Column_M_List  objectWithKeyValues:responseObject];
//                NSMutableArray *array = responseObject[@"data"];
//                
//                [array enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL *stop) {
//                    SchoolDetail_Column_M *mode = tmplist.data[idx];
//                  ///  mode.CourseName = obj[@"description"];
//
//                }];
                
                [_bachelor.data addObjectsFromArray:tmplist.data];
                _all_majors_list = _bachelor;
                [self.tableView.footer noticeNoMoreData];
                [self.tableView reloadData];
                [self getSchoolData];
                 [self getUserData];
            }
            if([[responseObject objectForKey:@"code"] isEqual:@500])
            {
                [self.tableView.footer noticeNoMoreData];
            }
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            [self.tableView reloadData];
            _all_majors_list = nil;
            [self.tableView.header endRefreshing];
        }];
        
        
    }
    else if (_topSelectedTag == 3)    // Master
    {
        
        kSetDict(self.schoolId, @"school_id");
        [string appendString:@"Programs_cylce/majors_list"];//Bachelor List
        [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.tableView.header endRefreshing];
            _all_majors_list = nil;
            if([[responseObject objectForKey:@"code"] isEqual:@200])
            {
                
                SchoolDetail_Column_M_List *tmplist = [SchoolDetail_Column_M_List  objectWithKeyValues:responseObject];
//                NSMutableArray *array = responseObject[@"data"];
//                
//                [array enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL *stop) {
//                    SchoolDetail_Column_M *mode = tmplist.data[idx];
//                   // mode.CourseName = obj[@"description"];
//                    
//                }];
                
                [_master.data addObjectsFromArray:tmplist.data];
                _all_majors_list = _master;
                
                [self.tableView.footer noticeNoMoreData];
                [self.tableView reloadData];
                [self getSchoolData];
                 [self getUserData];
                
            }
            if([[responseObject objectForKey:@"code"] isEqual:@500])
            {
                [self.tableView.footer noticeNoMoreData];
            }
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            [self.tableView reloadData];
            _all_majors_list = nil;
            [self.tableView.header endRefreshing];
        }];
        
        
    }
    else    // phd
    {
        kSetDict(self.schoolId, @"school_id");
        [string appendString:@"Programs_cylce/majors_list"];//Bachelor List
        [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.tableView.header endRefreshing];
            _all_majors_list = nil;
            if([[responseObject objectForKey:@"code"] isEqual:@200])
            {
               
                SchoolDetail_Column_M_List *tmplist = [SchoolDetail_Column_M_List  objectWithKeyValues:responseObject];
//                NSMutableArray *array = responseObject[@"data"];
//                
//                [array enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL *stop) {
//                    SchoolDetail_Column_M *mode = tmplist.data[idx];
//                  //  mode.CourseName = obj[@"description"];
//                    
//                }];
                
                [_phd.data addObjectsFromArray:tmplist.data];
                _all_majors_list = _phd;
                
                [self.tableView.footer noticeNoMoreData];
                [self.tableView reloadData];
                [self getSchoolData];
                 [self getUserData];
                
            }
            if([[responseObject objectForKey:@"code"] isEqual:@500])
            {
                [self.tableView.footer noticeNoMoreData];
            }
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            [self.tableView reloadData];
            _all_majors_list = nil;
            [self.tableView.header endRefreshing];
        }];
        
    }
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
        
        // BUY
        
        _adminViewBtn = [UIView createViewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 44, SCREEN_WIDTH, 44)
                                  backgroundColor:KCOLOR_WHITE];
        [self.view addSubview:_adminViewBtn];
        
        // 1
        _bottomBtn = [UIButton createButtonwithFrame:CGRectMake(10, 6, SW3, 32)
                                     backgroundColor:KCOLOR_RED
                                          titleColor:KCOLOR_WHITE
                                                font:KSYSTEM_FONT_(12)
                                               title:@"Bachelor"];
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
        [_adminViewBtn addSubview:_bottomBtn];  //1
        
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
            
            if([btnStartd.titleLabel.text isEqual: @"Master" ])
            {
                userAddGraduteMajor *vc = [[userAddGraduteMajor alloc] init];
                vc.SID = [self.schoolDetail.id copy];
                [self.navigationController pushViewController:vc animated:YES];
            }
            return [RACSignal empty];
        }];
        
        [_adminViewBtn addSubview:btnStartd];  // ok
        
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
            if([btn.titleLabel.text isEqual: @"Phd" ])
            {
                addSchoolReviewViewController *vc = [[addSchoolReviewViewController alloc] init];
                vc.SID = [self.schoolDetail.id copy];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            return [RACSignal empty];
        }];
        [_adminViewBtn addSubview:btn]; // ok
        
        
        
        [self.view addSubview:_adminViewBtn];
    }
    return _adminViewBtn;
}



- (void)showTopView
{
    UIView *topView = [UIView createViewWithFrame:CGRectMake(0,_myAdView.bottom, SCREEN_WIDTH, 44)
                                  backgroundColor:KCOLOR_GRAY_f5f5f5];
    
    _zufangBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 44)
                                 backgroundColor:KCOLOR_Clear
                                      titleColor:KTHEME_COLOR
                                            font:kAutoFont_(16)
                                           title:@"bachelor"];
    _zufangBtn.tag = 2;
    [_zufangBtn addTarget:self
                   action:@selector(headViewClick:)
         forControlEvents:UIControlEventTouchUpInside];
    
    _shiyouBtn = [UIButton createButtonwithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 44)
                                 backgroundColor:KCOLOR_Clear
                                      titleColor:KCOLOR_Black_343434
                                            font:kAutoFont_(16)
                                           title:@"master"];
    _shiyouBtn.tag = 3;
    [_shiyouBtn addTarget:self
                   action:@selector(headViewClick:)
         forControlEvents:UIControlEventTouchUpInside];
    
    _fangyuanBtn = [UIButton createButtonwithFrame:CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 44)
                                   backgroundColor:KCOLOR_Clear
                                        titleColor:KCOLOR_Black_343434
                                              font:kAutoFont_(16)
                                             title:@"phd"];
    _fangyuanBtn.tag = 4;
    [_fangyuanBtn addTarget:self
                     action:@selector(headViewClick:)
           forControlEvents:UIControlEventTouchUpInside];
    
    _lineView = [UIView createViewWithFrame:CGRectMake(0, 42, SCREEN_WIDTH/3, 2)
                            backgroundColor:KTHEME_COLOR];
    
    [topView addSubview:_zufangBtn];
    [topView addSubview:_shiyouBtn];
    [topView addSubview:_fangyuanBtn];
    [topView addSubview:_lineView];
    
    [self.view addSubview:topView];
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

