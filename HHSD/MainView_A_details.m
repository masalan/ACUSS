//
//  MainView_A_details.m
//  HHSD
//
//  Created by alain serge on 3/30/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MainView_A_details.h"
#import "userAddGraduteMajor.h"

#import "MJRefresh.h"
#import "SchoolLineHeadView.h"
#import "BachelorInteractView.h"
#import "MasterInteractView.h"
#import "PhdInteractView.h"
#import "WDTabBarViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#define SW3 (SCREEN_WIDTH/3)-10

@interface MainView_A_details ()<UITableViewDataSource,UITableViewDelegate,SchoolLineHeadViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) School_Details *schoolDetail;
@property (nonatomic, strong) SchoolDetail_Column_M_List *bachelorDetail_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *masterDetail_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *phdDetail_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *bachelorDetail_Column_M_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *masterDetail_Column_M_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *phdDetail_Column_M_List;

@property (nonatomic, strong) UITextField *userNameTextField,*passWDTextField;
@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger indexType;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *bottomBtn,*getMore,*addReview;
@property (nonatomic, strong) UILabel *priceLabel;



@end


@implementation MainView_A_details
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
    self.title = NSLocalizedString(@"Localized_SearchDetailsViewController_title",comment:"");
    [self getAllData];
    [self bottomView];
  
    DLog(@"%@",NSStringFromCGRect(self.view.frame));
    __weak typeof(self) weakself = self;
    
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakself getAllData];
    }];
    //[self.tableView.header beginRefreshing];
    
}



#pragma mark
#pragma mark delegate
- (void)SchoolLineHeadViewbtnClick:(NSInteger)index
{
    _indexType = index;
    self.schoolDetail.indexType = index;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.indexType) {
        case 0:
        {
            return [BachelorInteractView getCellHeight:self.bachelorDetail_List.data[indexPath.row]];
        }
            break;
        case 1:
        {
            return [MasterInteractView getCellHeight:self.masterDetail_List.data[indexPath.row]];
        }
            break;
        case 2:
        {
            return [PhdInteractView getCellHeight:self.phdDetail_List.data[indexPath.row]];
        }
            break;
        default:
            break;
    }
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  [SchoolLineHeadView getHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return [[UIView alloc] init];
}




// Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SchoolLineHeadView *headView =[[SchoolLineHeadView alloc] initWithMode:self.schoolDetail];
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
    static NSString *cellIdentity = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    switch (self.indexType) {
        case 0:
        {
            static NSString *cellIdentity = @"bachellor";
            BachelorInteractView *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if(!cell)
            {
                cell = [[BachelorInteractView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            }
            [cell setMode:self.bachelorDetail_List.data[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = KCOLOR_GRAY_f5f5f5;
            
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellIdentity = @"master";
            MasterInteractView *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if(!cell)
            {
                cell = [[MasterInteractView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            }
            [cell setMode:self.masterDetail_List.data[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = KCOLOR_GRAY_f5f5f5;
            
            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellIdentity = @"phd";
            PhdInteractView *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
            if(!cell)
            {
                cell = [[PhdInteractView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
            }
            [cell setMode:self.phdDetail_List.data[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = KCOLOR_GRAY_f5f5f5;
            
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
            return self.bachelorDetail_List.data.count;
            break;
        case 1:
            return self.masterDetail_List.data.count;
            break;
        case 2:
            return self.phdDetail_List.data.count;
            break;
        default:
            break;
    }
    return 2;
}
//#define kSetDict(value,key) if (value)[params setObject:value forKey:key]
#pragma mark
#pragma mark NetWork
// School details (Main)
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.sess_id, @"sess_id");
    kSetDict(self.schoolId, @"id");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Schools/detail"];//server
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing]; //me
        self.schoolDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _schoolDetail = [School_Details objectWithKeyValues:responseObject[@"data"]];
            self.schoolDetail.indexType = 0;
            [self.tableView reloadData];
            [self tableView];
            [self getBachelor];
            [self getMaster];
            [self getPhd];
            [self bottomView];

        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}


- (void)getBachelor
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    kSetDict(self.schoolId, @"id");
    
    [string appendString:@"Schools/bachelor"];//Bachelor List
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _bachelorDetail_List = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _bachelorDetail_List = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
            [self.tableView reloadData];
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)getMaster
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    kSetDict(self.schoolId, @"id");
    
    [string appendString:@"Schools/master"];//Bachelor List
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _masterDetail_List = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _masterDetail_List = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
            [self.tableView reloadData];
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}
- (void)getPhd
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    //kSetDict(self.mainMode.id, @"id");
    kSetDict(self.schoolId, @"id");
    
    [string appendString:@"Schools/phd"];//Bachelor List
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _phdDetail_List = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _phdDetail_List = [SchoolDetail_Column_M_List objectWithKeyValues:responseObject];
            [self.tableView reloadData];
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR_WHITE;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                userAddGraduteMajor *vc = [[userAddGraduteMajor alloc] init];
                vc.mainDetails = [self.mainDetails.id copy ];
                NSLog(@"ID------------------------> %@",[self.mainDetails.id copy ]);
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
                vc.mainDetails = [self.mainDetails.id copy ];
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
                userAddGraduteMajor *vc = [[userAddGraduteMajor alloc] init];
                vc.mainDetails = [self.mainDetails.id copy ];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            return [RACSignal empty];
        }];
        [_bottomView addSubview:btn]; // ok
        
        
        
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}





@end
