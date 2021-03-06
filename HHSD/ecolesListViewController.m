//
//  ecolesListViewController.m
//  HHSD
//
//  Created by alain serge on 4/5/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "ecolesListViewController.h"
#import "MainView_C.h"
#import "menuHorizontalView.h"
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
#define D 50

#import "CityViewSelectCell.h"

#import "ecoleSearch.h"


#import "MJRefreshGifHeader.h"
#import "GYHHeadeRefreshController.h"


@interface ecolesListViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,SWTableViewCellDelegate,MySchoolListDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *recordList;
@property (nonatomic, strong) IMQuickSearch *QuickSearch;
@property (nonatomic, strong) NSArray *People;
@property (nonatomic, strong) NSArray *Animals;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (nonatomic, strong) UITextField *searchText;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) NSArray *FilteredResults;
@property (nonatomic, retain) UIButton *selectedBtn,*buttonCell;
@property (nonatomic, strong) SearchModel *searchList;
@property (nonatomic , assign)int                           count;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, retain) NSString *Islike;
@property (nonatomic, retain) NSString *hidden;
@property (nonatomic, retain) NSString *SID;
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) All_Province_List *province_list;
@property (nonatomic, strong) Province_List_details *province_details;



@end

@implementation ecolesListViewController
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64 - 44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
       // _tableView.tableFooterView = [[UIView alloc] init];
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
    [self initUI];
    [self getAllData];
    [self addSearchBtnRight];
    

    
}
- (void)initUI
{
    IMP_BLOCK_SELF(ecolesListViewController);
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [block_self getAllData];
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = NO;
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
    [self getAllData];
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
#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return SW2-60;
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
    menuHorizontalView *vc = [[menuHorizontalView alloc] init];
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
    AllSchoolListCell *cells = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cells == nil) {
        cells = [[AllSchoolListCell alloc] initWithStyle:UITableViewCellStyleDefault
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
        [rightUtilityButtons sw_addUtilityButtonWithColor:KCOLOR_RED  title:@"Unlike"];
    }
    else if ([_Islike isEqualToString:@"0"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:KCOLOR_BLUE title:@"Like"];
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
    IMP_BLOCK_SELF(ecolesListViewController);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"schools/school"];
    kSetDict(_searchText.text, @"nameSchool");
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _searchList = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _searchList = [SearchModel objectWithKeyValues:responseObject[@"data"]];
            if (_searchList.school.count == 0 ) {
                [self MBShowHint:@"no result"];
                _searchList = nil;
            }
            [self tableView];
            block_self.count += 10;
            [block_self.tableView reloadData];
            //[block_self.tableView.header endRefreshing];
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [block_self.tableView reloadData];
        }
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        _searchList = nil;
        [block_self.tableView.header endRefreshing];
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







@implementation AllSchoolListCell

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
        [self.cellScrollView addSubview:_logoImageView ];
    }
    
    //maintenance
    
    
    if (!_maintenance) {
        _maintenance = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50,45,30,30)];
        _maintenance.backgroundColor = KCOLOR_CLEAR;
        _maintenance.layer.cornerRadius = _maintenance.size.height/2;
        _maintenance.layer.masksToBounds = YES;
        _maintenance.backgroundColor = KCOLOR_CLEAR;
        _maintenance.contentMode = UIViewContentModeScaleAspectFill;
        [self.cellScrollView addSubview:_maintenance ];
    }
    
    //_SchoolName
    if (!_SchoolName) {
        _SchoolName = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, 5, SCREEN_WIDTH-(_logoImageView.right+30),45)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_BLUE
                                               font:kAutoFont_(14)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        _SchoolName.numberOfLines = 3;
        [self.cellScrollView addSubview:_SchoolName];
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
        [self.cellScrollView addSubview:_province];
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
        [self.cellScrollView addSubview:_cityName];
    }
    // Foreigner students total
    
    if (!_effective) {
        _effective = [[ColorLabel alloc] initWithFrame:CGRectMake(_logoImageView.right+10, _cityName.bottom+1,SCREEN_WIDTH-(_logoImageView.right+50),20)];
        _effective.backgroundColor = KCOLOR_CLEAR;
        [self.cellScrollView addSubview:_effective];
    }
    
    
    // Description
    if (!_detailLabel) {
        _detailLabel =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH-25,10,20,20)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_RED
                                               font:KICON_FONT_(15)
                                      textalignment:NSTextAlignmentLeft
                                               text:nil];
        _detailLabel.numberOfLines = 12;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.cellScrollView addSubview:_detailLabel];
    }
    
    if (!_integralLabel) {
        _integralLabel =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 120, 70, 110, 20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_GRAY_999999
                                                 font:kAutoFont_(12)
                                        textalignment:NSTextAlignmentRight
                                                 text:@""];
        [self.cellScrollView addSubview:_integralLabel];
        _integralLabel.hidden = YES; //hidden
    }
    
    
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
            [_logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",school_data.photo]] placeholderImage:[UIImage imageNamed:@"netPlaceHoder"] options:SDWebImageRetryFailed];
        }
        _SchoolName.text = school_data.nameSchool;
        _province.text = school_data.province;
        _cityName.text = school_data.cityName;
        
        
        
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


