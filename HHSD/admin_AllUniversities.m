//
//  admin_AllUniversities.m
//  HHSD
//
//  Created by alain serge on 5/10/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "admin_AllUniversities.h"
#import "MJRefreshGifHeader.h"
#import "GYHHeadeRefreshController.h"
#import "MainView_C.h"
#import "SWTableViewCell.h"
#import "IMQuickSearch.h"
#import "SearchModel.h"
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



@interface admin_AllUniversities ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SWTableViewCellDelegate,MySchoolListDelegate>
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
@property (nonatomic, strong) SearchModel *searchList;
@property (nonatomic , assign)int                           count;
@property (nonatomic, retain) NSString *Islike;
@property (nonatomic, retain) NSString *hidden;
@property (nonatomic, retain) NSString *SID;

@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) All_Province_List *province_list;
@property (nonatomic, strong) Province_List_details *province_details;



@end

@implementation admin_AllUniversities
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
    self.title = @"schools";
    
    [self tableView];
    [self collectionView];
    [self getCityData];
    [self getAllData];
    [self initUI];

    [self.tableView.header beginRefreshing];
    [self addSearchBtnRight];
    
}

- (void)initUI
{
    IMP_BLOCK_SELF(admin_AllUniversities);
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        block_self.count = 0;
        [block_self getAllData];
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.header = header;
    [header beginRefreshing];
    
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [block_self getAllData];
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
        return (SW2-60)+80;
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
    adminAllSchoolListCell *cells = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cells == nil) {
        cells = [[adminAllSchoolListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellIdentity];
    }
    if (_searchList.school.count >0) {
        School_data *mode =_searchList.school[indexPath.row];
        [cells setInfoWith:mode];
    }
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    
    
    School_Details *tmp =  _searchList.school[indexPath.row];
    _hidden = [NSString stringWithFormat:@"%@",tmp.hidden];
    _Islike = [NSString stringWithFormat:@"%@",tmp.is_like];
    
    
    // Like/ Unlike
    if ([_Islike isEqualToString:@"1"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                    title:@"Unlike"];
    }
    else if ([_Islike isEqualToString:@"0"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                    title:@"Like"];
    }
    
    
    // Hidden/Show
    if ([_hidden isEqualToString:@"1"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Show"];
    }
    else if ([_hidden isEqualToString:@"0"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Hidden"];
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
    
    School_Details *tmp =  _searchList.school[cell.tag];
    switch (index) {
        case 0:
        {
            NSLog(@" unlike click");
            _Islike = [NSString stringWithFormat:@"%@",tmp.is_like];
            if ([_Islike isEqualToString:@"1"])
            {
                NSLog(@" Unlike click");
                School_Details *tmp =  _searchList.school[cell.tag];
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:self.sess_id forKey:@"sess_id"];
                [params setObject:tmp.id forKey:@"s_id"];
                NSMutableString *string = [NSMutableString stringWithString:urlHeader];
                [string appendString:@"Schools/unlike"];
                [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                    if([[responseObject objectForKey:@"code"] isEqual:@200])
                    {
                        [self getAllData];
                    }
                    if([[responseObject objectForKey:@"code"] isEqual:@500])
                    {
                    }
                } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                    
                }];
            }else if ([_Islike isEqualToString:@"0"])
            {
                NSLog(@" Like click");
                School_Details *tmp =  _searchList.school[cell.tag];
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:self.sess_id forKey:@"sess_id"];
                [params setObject:tmp.id forKey:@"id"];
                NSMutableString *string = [NSMutableString stringWithString:urlHeader];
                [string appendString:@"Schools/like"];
                [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                    if([[responseObject objectForKey:@"code"] isEqual:@200])
                    {
                        [self getAllData];
                    }
                    if([[responseObject objectForKey:@"code"] isEqual:@500])
                    {
                    }
                } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                }];
            }
            
            break;
        }
            break;
        case 1:
        {
            
            // School_Details *tmp =  _searchList.school[cell.tag];
            _hidden = [NSString stringWithFormat:@"%@",tmp.hidden];
            if ([_hidden isEqualToString:@"1"])
            {
                NSLog(@" show click");
                School_Details *tmp =  _searchList.school[cell.tag];
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:self.sess_id forKey:@"sess_id"];
                [params setObject:tmp.id forKey:@"id"];
                NSMutableString *string = [NSMutableString stringWithString:urlHeader];
                [string appendString:@"Manager/show_school"];
                [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                    if([[responseObject objectForKey:@"code"] isEqual:@200])
                    {
                        [self getAllData];
                    }
                    if([[responseObject objectForKey:@"code"] isEqual:@500])
                    {
                    }
                } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                    
                }];
                
            }else if ([_hidden isEqualToString:@"0"])
            {
                NSLog(@" hidden click");
                School_Details *tmp =  _searchList.school[cell.tag];
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:self.sess_id forKey:@"sess_id"];
                [params setObject:tmp.id forKey:@"id"];
                NSMutableString *string = [NSMutableString stringWithString:urlHeader];
                [string appendString:@"Manager/hidden_school"];
                [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                    if([[responseObject objectForKey:@"code"] isEqual:@200])
                    {
                        [self getAllData];
                    }
                    if([[responseObject objectForKey:@"code"] isEqual:@500])
                    {
                    }
                } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                    
                }];
                
            }
            break;
        }
        default:
            break;
    }
}





// AllSchoolListCell
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
    return  self.searchList.school.count;
}

#pragma mark - getAllData
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"manager/school"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _searchList = [SearchModel objectWithKeyValues:responseObject[@"data"]];
            if (_searchList.school.count == 0 ) {
                [self MBShowHint:@"no result"];
                _searchList = nil;
            }
            [self.tableView reloadData];
            [self tableView ];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark
#pragma mark UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.province_list.list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityViewSelectCell *cell = [[CityViewSelectCell alloc] init];
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"HouseCareCell" forIndexPath:indexPath];
    Province_List_details *mode = self.province_list.list[indexPath.row];
    cell.titleLabel.text = mode.province;
    
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREEN_WIDTH/4,44);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    Province_List_details *mode = self.province_list.list[indexPath.row];
    self.c_id =[mode.id copy];
    [self getAllData];
    [self rightNavBtnClick:self.rightNavBtn];
    
    
}

#pragma mark
#pragma mark getAllData
// get province select
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



- (void)AddViewActionBtnClick:(School_data *)mode;
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








@end











@implementation adminAllSchoolListCell

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
    _province = [[UILabel alloc] init];
    _cityTypeIcone = [[UILabel alloc] init];
    _cityTypeLabel = [[UILabel alloc] init];
    _cityTypeName = [[UILabel alloc] init];
    _climateTypeIcone = [[UILabel alloc] init];
    _climateTypeLabel = [[UILabel alloc] init];
    _climateTypeName = [[UILabel alloc] init];
    _livingTypeIcone = [[UILabel alloc] init];
    _livingTypeLabel = [[UILabel alloc] init];
    _livingTypeName = [[UILabel alloc] init];
    _lineOne = [[UILabel alloc] init];
    _lineTwo = [[UILabel alloc] init];
    
    _SchoolName = [[UILabel alloc] init];
    _cityName = [[UILabel alloc] init];
    _detailLabel = [[UILabel alloc] init];
    _integralLabel = [[UILabel alloc] init];
    
    
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SW2/2, SW2/2)];
        _logoImageView.backgroundColor = KCOLOR_CLEAR;
        _logoImageView.layer.cornerRadius = _logoImageView.size.height/2;
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.backgroundColor = KCOLOR_CLEAR;
        _logoImageView.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.cellScrollView addSubview:_logoImageView ];
   
    
    //maintenance
    
    
        _maintenance = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50,45,30,30)];
        _maintenance.backgroundColor = KCOLOR_CLEAR;
        _maintenance.layer.cornerRadius = _maintenance.size.height/2;
        _maintenance.layer.masksToBounds = YES;
        _maintenance.backgroundColor = KCOLOR_CLEAR;
        _maintenance.contentMode = UIViewContentModeScaleAspectFill;
        [self.cellScrollView addSubview:_maintenance ];
   
    
    //_SchoolName
        _SchoolName = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, 5, SCREEN_WIDTH-(_logoImageView.right+30),45)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_BLUE
                                               font:kAutoFont_(14)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        _SchoolName.numberOfLines = 3;
        [self.cellScrollView addSubview:_SchoolName];
    
    
    
    // Province
    
        _province = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, _SchoolName.bottom+1,(SCREEN_WIDTH-140)/2,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_Black_343434
                                             font:kAutoFont_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
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
   
    
    
    
    
    
    
                    // City Icone
                    
                    _cityTypeIcone = [UILabel resizeFrameWithLabel:_cityTypeIcone
                                                             frame:CGRectMake(0,(SW2-60),SW3,20)
                                                   backgroundColor:KCOLOR_WHITE
                                                         textColor:KTHEME_COLOR
                                                              font:KICON_FONT_(15)
                                                     textalignment:NSTextAlignmentCenter
                                                              text:@"\U0000e625"];
                    [self.cellScrollView addSubview:_cityTypeIcone];
                    
                    
                    // City label
                    
                    _cityTypeLabel = [UILabel resizeFrameWithLabel:_cityTypeLabel
                                                             frame:CGRectMake(0,_cityTypeIcone.bottom,SW3,20)
                                                   backgroundColor:KCOLOR_WHITE
                                                         textColor:KCOLOR_GRAY_Cell
                                                              font:KICON_FONT_(11)
                                                     textalignment:NSTextAlignmentCenter
                                                              text:@"Comments"];
                    [self.cellScrollView addSubview:_cityTypeLabel];
                    
                    
                    // City Name
                    
                    _cityTypeName = [UILabel resizeFrameWithLabel:_cityTypeName
                                                            frame:CGRectMake(0,_cityTypeLabel.bottom,SW3,30)
                                                  backgroundColor:KCOLOR_WHITE
                                                        textColor:KCOLOR_BLACK
                                                             font:KICON_FONT_(11)
                                                    textalignment:NSTextAlignmentCenter
                                                             text:@""];
                    _cityTypeName.numberOfLines =3;
                    [self.cellScrollView addSubview:_cityTypeName];
                    
                    
                    
                    // Climate Icone
                    
                    _climateTypeIcone = [UILabel resizeFrameWithLabel:_climateTypeIcone
                                                                frame:CGRectMake(SW3,(SW2-60),SW3,20)
                                                      backgroundColor:KCOLOR_WHITE
                                                            textColor:KTHEME_COLOR
                                                                 font:KICON_FONT_(15)
                                                        textalignment:NSTextAlignmentCenter
                                                                 text:@"\U0000e601"];
                    [self.cellScrollView addSubview:_climateTypeIcone];
                    
                    
                    
                    // Climate Label
                    
                    _climateTypeLabel = [UILabel resizeFrameWithLabel:_climateTypeLabel
                                                                frame:CGRectMake(SW3,_climateTypeIcone.bottom,SW3,20)
                                                      backgroundColor:KCOLOR_WHITE
                                                            textColor:KTHEME_COLOR
                                                                 font:KICON_FONT_(11)
                                                        textalignment:NSTextAlignmentCenter
                                                                 text:@"Apply forms"];
                    [self.cellScrollView addSubview:_climateTypeLabel];
                    
                    
                    // Climate Name
                    
                    _climateTypeName = [UILabel resizeFrameWithLabel:_climateTypeName
                                                               frame:CGRectMake(SW3,_climateTypeLabel.bottom,SW3,30)
                                                     backgroundColor:KCOLOR_WHITE
                                                           textColor:KCOLOR_BLACK
                                                                font:KICON_FONT_(11)
                                                       textalignment:NSTextAlignmentCenter
                                                                text:@""];
                    _climateTypeName.numberOfLines =3;
                    [self.cellScrollView addSubview:_climateTypeName];
                    
                    
                    
                    
                    
                    
                    // Living Icone
                    _livingTypeIcone = [UILabel resizeFrameWithLabel:_livingTypeIcone
                                                               frame:CGRectMake(2*SW3,(SW2-60),SW3,20)
                                                     backgroundColor:KCOLOR_WHITE
                                                           textColor:KTHEME_COLOR
                                                                font:KICON_FONT_(15)
                                                       textalignment:NSTextAlignmentCenter
                                                                text:@"\U0000e613"];
                    [self.cellScrollView addSubview:_livingTypeIcone];
                    
                    
                    
                    // Living Label
                    
                    _livingTypeLabel = [UILabel resizeFrameWithLabel:_livingTypeLabel
                                                               frame:CGRectMake(2*SW3,_livingTypeIcone.bottom,SW3,20)
                                                     backgroundColor:KCOLOR_WHITE
                                                           textColor:KTHEME_COLOR
                                                                font:KICON_FONT_(11)
                                                       textalignment:NSTextAlignmentCenter
                                                                text:@"Like"];
                    [self.cellScrollView addSubview:_livingTypeLabel];
                    
                    
                    // Living Name
                    
                    _livingTypeName = [UILabel resizeFrameWithLabel:_livingTypeName
                                                              frame:CGRectMake(2*SW3,_livingTypeLabel.bottom,SW3,20)
                                                    backgroundColor:KCOLOR_WHITE
                                                          textColor:KCOLOR_BLACK
                                                               font:KICON_FONT_(11)
                                                      textalignment:NSTextAlignmentCenter
                                                               text:@""];
                    _livingTypeName.numberOfLines =3;
                    [self.cellScrollView addSubview:_livingTypeName];
                    
    
    
    
    
                _lineOne = [UILabel resizeFrameWithLabel:_lineOne
                                                   frame:CGRectMake(SW3-0.5,_cityTypeIcone.bottom,0.5,50)
                                         backgroundColor:KCOLOR_GRAY_Cell
                                               textColor:KCOLOR_GRAY_Cell
                                                    font:KICON_FONT_(11)
                                           textalignment:NSTextAlignmentCenter
                                                    text:@""];
                [self.cellScrollView addSubview:_lineOne];
                
                
                
                
                _lineTwo = [UILabel resizeFrameWithLabel:_lineTwo
                                                   frame:CGRectMake(_climateTypeLabel.right-0.5,_climateTypeIcone.bottom,0.5,50)
                                         backgroundColor:KCOLOR_GRAY_Cell
                                               textColor:KCOLOR_GRAY_Cell
                                                    font:KICON_FONT_(11)
                                           textalignment:NSTextAlignmentCenter
                                                    text:@""];
                [self.cellScrollView addSubview:_lineTwo];

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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

- (void)setInfoWith:(School_data *)school_data {
    [_effective instance:@"\U0000e611 "
          LeftStringFont:KICON_FONT_(12)
         LeftStringColor:KTHEME_COLOR
         RightStringFont:kAutoFont_(12)
        RightStringColor:KTHEME_COLOR
            Right_String:[NSString stringWithFormat:@"%@ ",school_data.effective]];
    
    if(school_data) {
        if([school_data.photo hasPrefix:@"http"]) {
            [_logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",school_data.photo]] placeholderImage:[UIImage imageNamed:@"6000"] options:SDWebImageRetryFailed];
        }
        _SchoolName.text = school_data.nameSchool;
        _province.text = school_data.province;
        _cityName.text = school_data.cityName;
        
        
        _cityTypeName.text = school_data.total_comments;
        _climateTypeName.text = school_data.total_forms;
        _livingTypeName.text = school_data.total_like;
        
        
        
        
        if ([school_data.hidden isEqualToString:@"1"])
        {
            _maintenance.image = [UIImage imageNamed:@"maintenance"];
            
        } else if ([school_data.hidden isEqualToString:@"0"])
        {
            _maintenance.image = [UIImage imageNamed:@""];
            
        }
        
        
        
        if ([school_data.is_like isEqualToString:@"1"])
        {
            _detailLabel.text = @"\U0000e635";
            
        } else if ([school_data.is_like isEqualToString:@"0"])
        {
            _detailLabel.text = @"";
        }
        
        
    }
}

-(void)actionAddviewClick
{
    
}






@end


