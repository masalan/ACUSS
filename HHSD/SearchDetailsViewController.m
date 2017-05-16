//
//  SearchDetailsViewController.m
//  HHSD
//
//  Created by alain serge on 3/10/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//
#import "MJRefresh.h"
#import "SearchDetailsViewController.h"
#import "SchoolLineHeadView.h"
#import "BachelorInteractView.h"
#import "MasterInteractView.h"
#import "PhdInteractView.h"
#import "WDTabBarViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"


@interface SearchDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,SchoolLineHeadViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) School_Details *schoolDetail;
@property (nonatomic, strong) SchoolDetail_Column_M_List *bachelorDetail_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *masterDetail_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *phdDetail_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *bachelorDetail_Column_M_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *masterDetail_Column_M_List;
@property (nonatomic, strong) SchoolDetail_Column_M_List *phdDetail_Column_M_List;
@property (nonatomic, strong) UITextField *userNameTextField,*passWDTextField;
@property (nonatomic , assign)int                           count;
@property (nonatomic, assign) NSInteger indexType;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *bottomBtn,*getMore,*addReview;
@property (nonatomic, strong) UILabel *priceLabel;

@end

NSString *kSuccessTitle = @"Congratulations";
NSString *kErrorTitle = @"Connection error";
NSString *kNoticeTitle = @"Notice";
NSString *kWarningTitle = @"Warning";
NSString *kInfoTitle = @"Info";
NSString *kSubtitle = @"You've just displayed this awesome Pop Up View";
NSString *kButtonTitle = @"Done";
NSString *kAttributeTitle = @"Attributed string operation successfully completed.";

@implementation SearchDetailsViewController
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
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:KUSERNAME];
    NSString *passWd = [[NSUserDefaults standardUserDefaults] objectForKey:KPASSWORD];
    if(userName && passWd)
    {
        self.userNameTextField.text = userName;
        self.passWDTextField.text = passWd;
        // self.loginUser.enabled = YES;
    }
    [self initUI];

    DLog(@"%@",NSStringFromCGRect(self.view.frame));

}

- (void)initUI
{
    IMP_BLOCK_SELF(SearchDetailsViewController);
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


-(void)BtnClickLoginHere:(NSInteger)index
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    UIColor *color = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:144.0/255.0 alpha:1.0];
    [alert showCustom:self image:[UIImage imageNamed:@"git"] color:color title:@"Custom" subTitle:@"Add a custom icon and color for your own type of alert!" closeButtonTitle:@"OK" duration:0.0f];
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
   // return [[UIView alloc] init];
            _bottomView = [UIView createViewWithFrame:CGRectMake(0,SCREEN_HEIGHT - 47, SCREEN_WIDTH, 44)
                                  backgroundColor:KCOLOR_CLEAR];
    _bottomView.userInteractionEnabled = YES;
        switch (section) {
        case 0:
        {
            UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                           backgroundColor:KCOLOR_CLEAR];
            [self.bottomView addSubview:lineView];
            
            _getMore = [UIButton createButtonwithFrame:CGRectMake(10, 6,(SCREEN_WIDTH-20)/2, 32)
                                       backgroundColor:KCOLOR_RED
                                            titleColor:KCOLOR_WHITE
                                                  font:KSYSTEM_FONT_(15)
                                                 title:NSLocalizedString(@"Localized_SearchDetailsViewController_getMore",comment:"")
                                         conrnerRadius:5.0f
                                           borderWidth:1.0
                                           borderColor:KCOLOR_RED];
            
            
            [_getMore addTarget:self action:@selector(UserCheckProfileSearch) forControlEvents:UIControlEventTouchUpInside];

            
            [self.bottomView addSubview:_getMore];
            
            //addReview
            _addReview = [UIButton createButtonwithFrame:CGRectMake(_getMore.right+10, 6,((SCREEN_WIDTH-20)/2)-10, 32)
                                         backgroundColor:KCOLOR_BLUE
                                              titleColor:KCOLOR_WHITE
                                                    font:KSYSTEM_FONT_(15)
                                                   title:NSLocalizedString(@"Localized_SearchDetailsViewController_addReview",comment:"")
                                           conrnerRadius:5.0f
                                             borderWidth:1.0
                                             borderColor:KCOLOR_BLUE];
            [_addReview addTarget:self action:@selector(UserCheckProfileSearch) forControlEvents:UIControlEventTouchUpInside];

            
            [self.bottomView addSubview:_addReview];
            return _bottomView;
        }
            break;
            
        default:
            break;
    }
  
    return [[UIView alloc] init];;
}

-(void)UserCheckProfileSearch
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
        [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
        NSLog(@"Signup");
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
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

#pragma mark
#pragma mark NetWork
// profile (Main)
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    kSetDict(self.schoolId, @"id");
    
    [string appendString:@"Search/detail"];//server
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
    
    [string appendString:@"Search/bachelor"];//Bachelor List
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
    
    [string appendString:@"Search/master"];//Bachelor List
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

    [string appendString:@"Search/phd"];//Bachelor List
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-64 ) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = KCOLOR_WHITE;
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
