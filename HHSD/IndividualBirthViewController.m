//
//  IndividualBirthViewController.m
//  HHSD
//
//  Created by alain serge on 3/24/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "IndividualBirthViewController.h"
#import "sellectEditCell.h"


#import "MyPicker.h"
#import "MyDatePicker.h"
#import "MBProgressHUD.h"



@interface IndividualBirthViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,MyPickerDelegate, MyDatePickerDelegate>
{
    
    UITableView *_settingTabView;
    NSArray *_lists;
}

@property (nonatomic, strong) MyPicker *picker;
@property (nonatomic, strong) MyDatePicker *datePicker;

@property (nonatomic, strong) Student_Details *individual_M;
@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *sexView;



@property (nonatomic, strong) UITableView *tableView;


@end

@implementation IndividualBirthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Birthday";
    [self tableView];
    [self getAllData];
    self.view.backgroundColor = KCOLOR_THEME;
    [self initUI];

//    __weak typeof(self) weakself = self;
//    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakself getAllData];
//    }];
    
    UIButton *leftBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 30)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(15)
                                                  title:@"OK"];
    [leftBtn addTarget:self action:@selector(BirthdayEditUser) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
}

- (void)initUI
{
    IMP_BLOCK_SELF(IndividualBirthViewController);
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
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




// Birthday data to  the server
- (void)BirthdayEditUser
{
    DLog(@"Birthday save");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        kSetDict(_individual_M.birthday, @"birthday");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User/birthday"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:KMainView_D_getAllData object:self];
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
#pragma mark birthDay
- (void)birthDayButtonClick
{
    if (!_datePicker) {
        _datePicker = [[MyDatePicker alloc]init];
        _datePicker.delegate = self;
        [_datePicker showWithDatePickerMode:UIDatePickerModeDate];
    }else{
        [_datePicker open];
    }
}

#pragma mark myDatePicker
-(void)myDatePickerDidSelectedDate:(NSDate *)selectedDate {
    NSTimeInterval timeSelect = [selectedDate timeIntervalSince1970];
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    NSTimeInterval timeNow = [localeDate timeIntervalSince1970];
    
    if (timeSelect - timeNow > 0) {
        // [ProgressHUD showError:@"Choose your Birthday!"];
        [self MBShowHint:@"Choose your Birthday!"];
        
        
        return;
    }
    NSString *dataString = [PublicMethod getCreateTimeWithDate:selectedDate];
    _individual_M.birthday = [dataString copy];
    [self.tableView reloadData];
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
    [_picker showWithTitle:@"Choose your gender" nameArray:@[@"Male",@"Female"]];
    
    
}


-(void)myPicker:(MyPicker *)picker didPickRow:(NSInteger)row
{
}

//-(void)myPicker:(MyPicker *)picker willPickRow:(NSInteger)row
//{
//    [picker close];
//    _individual_M.sex = [NSString stringWithFormat:@"%ld",(long)row];
//    [self.tableView reloadData];
//}


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
    sellectEditCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell)
        
    {
        cell = [[sellectEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.titleLabel.text = @"Modify";
            cell.contentLabel.text = [PublicMethod getYMDUsingCreatedTimestamp:_individual_M.birthday];
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
    [self birthDayButtonClick];
}


#pragma mark
#pragma mark netWork
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"user_infos/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _individual_M = nil;
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

