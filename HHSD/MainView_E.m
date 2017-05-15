//
//  MainView_E.m
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MainView_E.h"
#import "applyForMajor.h"
#import "editApplyForm.h"

#import "MyFabuTableViewCell.h"
#import "SecondHandModel.h"
#import "NOOrderView.h"

@interface MainView_E ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Fabu_List *fabu_M_List;
@property (nonatomic, strong) NOOrderView *orderView;
@property (nonatomic, assign) NSInteger indexSection;
@property (nonatomic, assign) BOOL refresh;
@end

@implementation MainView_E

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"My form";
    
    [self tableView];
    __weak typeof(self) weakself = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        weakself.refresh = YES;
        [weakself getAllData];
    }];
    
    [self getAllData];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllData)
                                                 name:KNOTIFICATION_ZufangSuccessed
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllData)
                                                 name:KNOTIFICATION_SECHANDSuccessed
                                               object:nil];
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionPickerDone)];
    [self.view addGestureRecognizer:tapAction];
}

-(void)actionPickerDone {
    _refresh = YES;
    [_tableView reloadData];
}

- (NOOrderView *)orderView {
    if(!_orderView) {
        _orderView = [[NOOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.view addSubview:_orderView];
        _orderView.titleLabel.text = @"You have not Application form";
        _orderView.orderLabel.text = @"\U0000e601";
    }
    return _orderView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _refresh = YES;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _fabu_M_List.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"cell";
    MyFabuTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(cell == nil) {
        cell = [[MyFabuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SecondHandModel *mode = _fabu_M_List.data[indexPath.section];
    [cell setMode:mode withIndexSection:indexPath.section];
    if (_refresh) {
        cell.backView.hidden = YES;
        cell.moreBtn.selected = NO;
    }
    [cell.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delBtn addTarget:self action:@selector(delBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)editBtnAction:(UIButton *)sender {
    SecondHandModel *mode = _fabu_M_List.data[sender.tag];
    [self getDetail:mode.issue_type andId:mode.id];
}


-(void)delBtnAction:(UIButton *)sender {
    [self deleteFabuMessage:sender.tag];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyFabuTableViewCell getHeight];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //     SecondHandModel *mode = _fabu_M_List.data[indexPath.section];
    //[self getDetail:mode.issue_type andId:mode.id];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteFabuMessage:indexPath.section];
    }
}

#pragma mark - init
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT -64)
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark getAllData
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/list_form"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self.tableView.header endRefreshing];
         _fabu_M_List = nil;
         if([[responseObject objectForKey:@"code"] isEqual:@200])
         {
             _fabu_M_List = [Fabu_List objectWithKeyValues:responseObject];
             
             if (_fabu_M_List.data.count == 0) {
                 [self orderView];
                 self.orderView.hidden = NO;
             }
             
         }
         else if ([[responseObject objectForKey:@"code"] isEqual:@500])
         {
             _fabu_M_List = nil;
         }
         
         [self.tableView reloadData];
         
     }failBlock:^(AFHTTPRequestOperation *operation, NSError *eror)
     {
         _fabu_M_List = nil;
         [self.tableView reloadData];
         
     }];
}

//
- (void)getDetail:(NSString *)type andId:(NSString *)fabuId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    kSetDict(type, @"issue_type");
    kSetDict(fabuId, @"id");
    
    
    NSLog(@"ID form------------------------------>%@",fabuId);
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/details_form"];  // Get all infos from here
   [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if([[responseObject objectForKey:@"code"] isEqual:@200])
         {
             NSDictionary *dic = responseObject[@"data"];
             editApplyForm *saleVC = [[editApplyForm alloc] init];
             saleVC.isMyFabu = YES;
             saleVC.params = [[NSMutableDictionary alloc] initWithDictionary:dic];
             [self.navigationController pushViewController:saleVC animated:YES];
             
         }
                  
     }failBlock:^(AFHTTPRequestOperation *operation, NSError *eror)
     {
     }];
}

- (void)deleteFabuMessage:(NSInteger)index
{
    NSLog(@"delete Action");
    
    UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Delete" message:@"Are you sure？"];
    [alert bk_addButtonWithTitle:@"No" handler:^{
        self.refresh = YES;
        [self.tableView reloadData];
    }];
    [alert bk_addButtonWithTitle:@"Yes" handler:^{
        SecondHandModel *mode = _fabu_M_List.data[index];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        kSetDict(mode.id, @"id");
        
        NSLog(@"delete ID--------------------------->%@",mode.id);

        
        NSMutableString *string = [NSMutableString stringWithString:urlHeader];
        [string appendString:@"Programs_cylce/delete_form"];
         [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            if([[responseObject objectForKey:@"code"] isEqual:@200]) {
                [self.fabu_M_List.data removeObjectAtIndex:index];
                [self.tableView reloadData];
            }
        }failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
            
        }];
    }];
    [alert show];
}



@end
