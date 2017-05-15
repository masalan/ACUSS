//
//  SearchDetailsStudent.m
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SearchDetailsStudent.h"
#import "MJRefresh.h"
#import "LoginViewController.h"

#import "CDOutLineHeadView.h"
#import "CDColumnCell.h"
#import "CDInteractView.h"
#import "CDCommentCell.h"
#import "FYLoginTranslation.h"

#import "WDTabBarViewController.h"
#import "AppDelegate.h"

@interface SearchDetailsStudent ()<UITableViewDataSource,UITableViewDelegate, CDOutLineHeadViewDelegate,CDCommentCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Student_Details *studentDetail;
@property (nonatomic, strong) StudentDetail_Column_M_List *studentDetail_Comment_M_List;
@property (nonatomic, strong) StudentDetail_Column_M_List *studentDetail_Major_List;
@property (nonatomic, strong) StudentDetail_Column_M_List *studentDetail_Sharing_List;
@property (nonatomic, strong) UITextField *userNameTextField,*passWDTextField;
@property (nonatomic, assign) NSInteger indexType;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *bottomBtn,*getMore,*addReview;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) FYLoginTranslation* login;
@end

@implementation SearchDetailsStudent
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
    self.title = NSLocalizedString(@"Localized_SearchDetailsStudent_title",comment:"");
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
            cell.backgroundColor = KCOLOR_GRAY_f5f5f5;
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
   kSetDict(self.studentId, @"id");
   [string appendString:@"Search/profile_student"];//server
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing]; //me
        self.studentDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _studentDetail = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            self.studentDetail.indexType = 0;
            [self.tableView reloadData];
            [self tableView];
            [self bottomView];
            [self getMajor];
            [self getShare];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
           // [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)getMajor
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
   kSetDict(self.studentId, @"id");
    [string appendString:@"Search/major_student"];//major student List
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
           // [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

- (void)getShare
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
     kSetDict(self.studentId, @"id");
    [string appendString:@"Search/publication_student"];//share student List
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
           // [self MBShowHint:responseObject[@"message"]];
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

- (UIView *)bottomView
{
    if(!_bottomView)
    {
        
        
        _bottomView = [UIView createViewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 44, SCREEN_WIDTH, 44)
                                  backgroundColor:KTHEME_COLOR];
        [self.view addSubview:_bottomView];
        
        UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                       backgroundColor:KCOLOR_CLEAR];
        [self.bottomView addSubview:lineView];
        
        _getMore = [UIButton createButtonwithFrame:CGRectMake(10, 6,(SCREEN_WIDTH-20)/2, 32)
                                   backgroundColor:KCOLOR_RED
                                        titleColor:KCOLOR_WHITE
                                              font:KICON_FONT_(15)
                                             title:NSLocalizedString(@"Localized_SearchDetailsStudent_call",comment:"")
                                     conrnerRadius:5.0f
                                       borderWidth:1.0
                                       borderColor:KCOLOR_RED];
        [_getMore addTarget:self action:@selector(UserCheckProfile) forControlEvents:UIControlEventTouchUpInside];
       [self.bottomView addSubview:_getMore];
        
        //addReview
        _addReview = [UIButton createButtonwithFrame:CGRectMake(_getMore.right+10, 6,((SCREEN_WIDTH-20)/2)-10, 32)
                                     backgroundColor:KCOLOR_BLUE
                                          titleColor:KCOLOR_WHITE
                                                font:KICON_FONT_(15)
                                               title:NSLocalizedString(@"Localized_SearchDetailsStudent_sms",comment:"")
                                       conrnerRadius:5.0f
                                         borderWidth:1.0
                                         borderColor:KCOLOR_BLUE];
        [_addReview addTarget:self action:@selector(UserCheckProfile) forControlEvents:UIControlEventTouchUpInside];

        
        [self.bottomView addSubview:_addReview];
    }
    return _bottomView;
}

-(void)UserCheckProfile
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

- (FYLoginTranslation *)login {
   
    return _login;
}
-(void)finishTransitionRootVC {
    
    [self.login stopAnimation];
}

@end











