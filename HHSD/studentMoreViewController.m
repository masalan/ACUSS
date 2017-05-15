//
//  studentMoreViewController.m
//  HHSD
//
//  Created by alain serge on 3/28/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "studentMoreViewController.h"


#import "MJRefresh.h"
#import "LoginViewController.h"
#import "SearchStudentModel.h"
#import "CDOutLineHeadView.h"
#import "CDColumnCell.h"
#import "CDInteractView.h"
#import "CDCommentCell.h"
#import "FYLoginTranslation.h"

#import "WDTabBarViewController.h"
#import "AppDelegate.h"

@interface studentMoreViewController ()<UITableViewDataSource,UITableViewDelegate, CDOutLineHeadViewDelegate,CDCommentCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Student_Details *studentDetail;
@property (nonatomic, strong) StudentDetail_Column_M_List *studentDetail_Comment_M_List;
@property (nonatomic, strong) StudentDetail_Column_M_List *studentDetail_Major_List;
@property (nonatomic, strong) StudentDetail_Column_M_List *studentDetail_Sharing_List;
@property (nonatomic, strong) UITextField *userNameTextField,*passWDTextField;
@property (nonatomic, assign) NSInteger indexType;
@property (nonatomic, strong) UIButton *bottomBtn,*getMore,*addReview;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UIProgressView *progress;
@end

@implementation studentMoreViewController
- (instancetype)init
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    _indexType = 0;
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Graduate";
    [self getAllData];
    self.view.backgroundColor = KTHEME_COLOR;
    __weak typeof(self) weakself = self;
    
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakself getAllData];
    }];
    self.progress.progress = 0.0;
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERNAME];
    NSString *passWd = [[NSUserDefaults standardUserDefaults] objectForKey:KPASSWORD];
    if(userName && passWd)
    {
        self.userNameTextField.text = userName;
        self.passWDTextField.text = passWd;
    }
    
}
#pragma mark
#pragma mark delegate Ok swicth menu select
- (void)CDOutLineHeadViewbtnClick:(NSInteger)index
{
    _indexType = index;
    self.studentDetail.indexType = index;
    [self.tableView reloadData];
}

- (void)CDColumnCellOpenClick:(StudentDetail_Column_M *)mode
{
    mode.isOpen = !mode.isOpen;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.indexType) {
        case 0:
        {
            return  [CDInteractView getHeight:self.studentDetail];  // Main View
        }
            break;
        case 1:
        {
            return  [CDColumnCell getHeight:self.studentDetail_Major_List.data[indexPath.row]]; // major
        }
            break;
        case 2:
        {
            return [CDCommentCell getCellHeight:self.studentDetail_Sharing_List.data[indexPath.row]];
        }
            break;
        default:
            break;
    }
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [CDOutLineHeadView getHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CDOutLineHeadView *headView =[[CDOutLineHeadView alloc] initWithMode:self.studentDetail];
    headView.delegate = self;
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.indexType) {
        case 0:
            
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}



#pragma mark
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"profil";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    switch (self.indexType) {
        case 0:
        {
            [cell addSubview:[[CDInteractView alloc] initWithMode:self.studentDetail]];
           cell.backgroundColor = KTHEME_COLOR;
        }
            break;
        case 1:
        {
            static NSString *cellIdentity = @"major";
            CDColumnCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if(!cell)
            {
                cell = [[CDColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            }
            [cell setMode:self.studentDetail_Major_List.data[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = KTHEME_COLOR;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellIdentity = @"posts";
            CDCommentCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if(!cell)
            {
                cell = [[CDCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            }
            [cell setMode:self.studentDetail_Sharing_List.data[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = KTHEME_COLOR;
            return cell;
        }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.indexType) {
        case 0:
            return 1;
            break;
        case 1:
            return self.studentDetail_Major_List.data.count;
            break;
        case 2:
            return self.studentDetail_Sharing_List.data.count;
            break;
        default:
            break;
    }
    return 2;
}

#pragma mark
#pragma mark NetWork
// profile (Main)
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [params setObject:self.sess_id forKey:@"sess_id"];
    [string appendString:@"students/profile_student"];//server
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing]; //me
        self.studentDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _studentDetail = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            self.studentDetail.indexType = 0;
            [self.tableView reloadData];
            [self tableView];
            [self getMajor];
            [self getShare];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {

        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)getMajor
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [params setObject:self.sess_id forKey:@"sess_id"];
    [string appendString:@"students/major_student"];//major student List
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _studentDetail_Major_List = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _studentDetail_Major_List = [StudentDetail_Column_M_List objectWithKeyValues:responseObject];
            [self.tableView reloadData];
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {

        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)getShare
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [params setObject:self.sess_id forKey:@"sess_id"];
    [string appendString:@"students/publication_student"];//share student List
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _studentDetail_Sharing_List = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _studentDetail_Sharing_List = [StudentDetail_Column_M_List objectWithKeyValues:responseObject];
            [self.tableView reloadData];
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}


#pragma mark
#pragma mark ViewInit
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = KTHEME_COLOR;
        _tableView.showsVerticalScrollIndicator = YES;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end











