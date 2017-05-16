//
//  nationalityViewController.m
//  HHSD
//
//  Created by alain serge on 3/22/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "nationalityViewController.h"

#import "MyPicker.h"
#import "SignupProfileCell.h"

@interface nationalityViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,MyPickerDelegate>
{
    
    UITableView *_settingTabView;
    NSArray *_lists;
}
@property (nonatomic, strong) MyPicker *picker;
@property (nonatomic, strong) Student_Details *individual_M;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *sexView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic , assign)int                           count;

@end

@implementation nationalityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Nationality";
    [self getAllData];
    [self tableView];
    self.view.backgroundColor = KCOLOR_THEME;
    [self initUI];

    
    UIButton *leftBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 30)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(15)
                                                  title:@"OK"];
    [leftBtn addTarget:self action:@selector(saveSexuser) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)initUI
{
    IMP_BLOCK_SELF(nationalityViewController);
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

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64-64)
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = KCOLOR_THEME;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.hidden = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}




// Sex data to  the server
- (void)saveSexuser
{
    DLog(@"sex save");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    kSetDict(_individual_M.nationality, @"profession");
    
    
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User/nationaly_signup"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:Ksignup_last_getAllData object:self];
            
            
            [self MBShowSuccess:@"Succes"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
    
}






#pragma mark
#pragma mark sex
- (void)sexBtnclick
{
    if(!_picker)
    {
        _picker = [[MyPicker alloc] init];
        _picker.delegate = self;
    }
    _picker.pickerTag = 0;
    [_picker showWithTitle:@"Occupation" nameArray:@[@"Student",@"Teacher",@"Searcher",@"Visitor",@"Other"]];
    
}


-(void)myPicker:(MyPicker *)picker didPickRow:(NSInteger)row
{
}

-(void)myPicker:(MyPicker *)picker willPickRow:(NSInteger)row
{
    [picker close];
    _individual_M.profession = [NSString stringWithFormat:@"%ld",(long)row];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    SignupProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell)
        
    {
        cell = [[SignupProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.titleLabel.text = @"Occupation";
            
            if([_individual_M.profession isEqualToString:@"0"])
            {
                cell.contentLabel.text = @"Student";
                
            }
            else if ([_individual_M.profession isEqualToString:@"1"])
            {
                cell.contentLabel.text = @"Teacher";
            }
            else if ([_individual_M.profession isEqualToString:@"2"])
            {
                cell.contentLabel.text = @"Searcher";
            }
            else if ([_individual_M.profession isEqualToString:@"3"])
            {
                cell.contentLabel.text = @"Visitor";
            }
            else if ([_individual_M.profession isEqualToString:@"4"])
            {
                cell.contentLabel.text = @"Other";
            }
        }
            
            break;
            
        default:
            break;
    }
    
    
    
    cell.backgroundColor = KCOLOR_WHITE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return SCREEN_HEIGHT/ 12.62;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self sexBtnclick];
}


#pragma mark
#pragma mark netWork
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User_infos/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _tableView.hidden = NO;
            _individual_M = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView.header endRefreshing];
    }];
}


















@end

