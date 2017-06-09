//
//  MainView_B.m
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MainView_B.h"
#import "pinyin.h"
#import "GroupStudentHeadView.h"
#import "StudentTableViewCell.h"
#import "SearchStudentModel.h"
#import "signup_last.h"
//#import "SearchDetailsStudent.h"
#import "userDetailsViewController.h"

#import "eleveSearch.h"
#import "MyCodeViewController.h"


@interface MainView_B ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *a_z_dataDic;//Alphabetically
@property (nonatomic, strong) Student_Details *individual_M;
@property (nonatomic, strong) SearchStudentModel *searchList;
@property (nonatomic, strong) SearchStudentModel *searchListStudent;
@property (nonatomic, copy) NSString *sess_ID;
@property (nonatomic , assign)int                           count;

@end

@implementation MainView_B

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"students";
    [self getAllData];
    [self tableView];
    [self.tableView.header beginRefreshing];
    [self initUI];

    
    [self addSearchBtnRightE];
}


- (void)initUI
{
    IMP_BLOCK_SELF(MainView_B);
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


-(void)addSearchBtnRightE {
    UIButton *barButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];
    [barButton setTitle:@"\U0000e662" forState:UIControlStateNormal];
    barButton.titleLabel.font = KICON_FONT_(20);
    [barButton addTarget:self action:@selector(eleveSearch) forControlEvents:UIControlEventTouchUpInside];
    [barButton setTitleColor:[PublicMethod getNaviBarItemColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

// serach clikc
-(void)eleveSearch
{
    eleveSearch *vc = [[eleveSearch alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //Change the color of the index
    self.tableView.sectionIndexTrackingBackgroundColor = KCOLOR_CLEAR;
    self.tableView.sectionIndexColor = KCOLOR_Black_343434;
    self.tableView.sectionIndexBackgroundColor = KCOLOR_CLEAR;

    return 27;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getA_Z_DicCount:section];
}

//The letter is displayed on the right
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indices = [NSMutableArray array];
    
    for (int i = 0; i < 27; i++)
    {
        if ([self getA_Z_DicCount:i]!=0)
            [indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
    }
    return indices;
}

//Click the alphabet index
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return  [ALPHA rangeOfString:title].location;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier= @"friendCell";
    StudentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[StudentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:indexPath.section]];
    NSArray *array=[self.a_z_dataDic objectForKey:key];
    cell.backgroundColor = KCOLOR_RED;
    
    if (indexPath.row <array.count) {
        [cell setMode:array[indexPath.row] ];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    userDetailsViewController *vc = [[userDetailsViewController alloc] init];
    NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:indexPath.section]];
    NSArray *array=[self.a_z_dataDic objectForKey:key];
    
    if (indexPath.row <array.count) {
        Student_Details *detailsUser = array[indexPath.row];
        vc.studentId = detailsUser.id;
    }

 NSLog(@"User ID---------------------------> %@",vc.studentId);

    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [StudentTableViewCell getHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:section]];
    NSArray *array = [self.a_z_dataDic objectForKey:key];
    if (array.count != 0) {
        return 23;
    }
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self getA_Z_DicCount:section]) {
        NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:section]];
        GroupStudentHeadView *groupHeadView = [[GroupStudentHeadView alloc] initWithTitle:key];
        return groupHeadView;
    }
    
    return nil;
}




#pragma mark - getAllData
- (void)getAllData
{
    IMP_BLOCK_SELF(MainView_B);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Menu_a/student"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.tableView.header endRefreshing];
        _searchListStudent = nil;
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _searchListStudent = [SearchStudentModel objectWithKeyValues:responseObject[@"data"]];
            if (_searchListStudent.student.count>0) {
                self.a_z_dataDic = [self convertTo_A_Z_DICTION:_searchListStudent.student];
            }
            
            block_self.count += 100;
            [block_self.tableView reloadData];
            [block_self.tableView.header endRefreshing];
            [block_self.tableView.footer endRefreshing];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {

        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [block_self.tableView.header endRefreshing];
        [block_self.tableView.footer endRefreshing];
    }];
}

- (void)end
{
    [self.tableView.header endRefreshing];
    [self MBHidden];
}

#pragma mark - ViewInit
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -44-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = KTHEME_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark method
#pragma mark - a~z排序方法
- (NSMutableDictionary *)convertTo_A_Z_DICTION:(NSArray *)array
{
    NSMutableDictionary *sectionDic = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < 26; i++) [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
    [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
    
    for (Student_data *mode in array) {
        NSString *personname = mode.fullName;
        char first = '#';
        
        if ([personname length]>0) {
            NSString *nameFirst = [personname substringToIndex:1];
            if([nameFirst canBeConvertedToEncoding:NSASCIIStringEncoding]) {
                first = [personname characterAtIndex:0];
            } else {// if its english List
                first =  pinyinFirstLetter([personname characterAtIndex:0]);
            }
        }
        
        NSString *sectionName;
        if ((first>='a'&&first<='z')||(first>='A'&&first<='Z')) {
            if([self searchResult:personname searchText:@"L"])//Polyphonic words
                sectionName = @"C";
            else
                sectionName = [[NSString stringWithFormat:@"%c",first] uppercaseString];
        }
        else {
            sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
        }
        [[sectionDic objectForKey:sectionName] addObject:mode];
        
    }
    return sectionDic;
}

-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT{
    NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch
                                               range:NSMakeRange(0, searchT.length)];
    if (result == NSOrderedSame)
        return YES;
    else
        return NO;
}

- (NSUInteger)getA_Z_DicCount:(NSInteger)section
{
    NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:section]];
    NSArray *array = [self.a_z_dataDic objectForKey:key];
    
    return array.count;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self checkSignupUser];
    self.leftBackBtn.hidden = NO;
}

- (void)checkSignupUser
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User_infos/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _individual_M = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            
           
            if ([_individual_M.signup_end isEqualToString:@"0"])
            {
                signup_last *vc = [[signup_last alloc] init];
                vc.sess_ID = _sess_ID;
                [self.navigationController pushViewController:vc animated:YES];
                self.leftBackBtn.hidden = NO;
            }else
            {
                //
            }
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {

        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}

/***
 
 0 public
 1 hidding for search engineer
 2 hidding for everyone
 
 ***/



@end
