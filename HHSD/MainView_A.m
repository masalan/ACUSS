//
//  MainView_A.m
//  HHSD
//
//  Created by alain serge on 3/29/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MainView_A.h"
#import "IMQuickSearch.h"
#import "SearchModel.h"
#import "SearchSchoolListCell.h"
#import "userAddGraduteMajor.h"

#import "SWTableViewCell.h"
#import "MainView_C.h"


// Benchmarks
extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));
#define kNumberOfObjects 200
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2

#define D 50

@interface MainView_A ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,SWTableViewCellDelegate>
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

@property (nonatomic, retain) NSString *hidden;


@end

@implementation MainView_A
- (instancetype)init {
    self = [super init];
    if(self){
        _isMySetting = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"schools A";
    __weak typeof(self) weakself = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakself getAllData];
    }];
    [self.tableView.header beginRefreshing];
    
    self.FilteredResults = [self.QuickSearch filteredObjectsWithValue:nil];
    
    [self benchmarkQuickSearch];
    
    
}



-(void)didRotate {
    _isDelete = NO;
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)searchTableView {
    [searchTableView resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self performSelector:@selector(filterResults) withObject:nil afterDelay:0.07];
    return YES;
}


#pragma mark - Benchmark
- (void)benchmarkQuickSearch {
    uint64_t t = dispatch_benchmark(10000, ^{
        @autoreleasepool {
            [self.QuickSearch filteredObjectsWithValue:@"al"];
        }
    });
    NSLog(@"IMQuickSearch - %d objects - Avg. Runtime: %llu ns", kNumberOfObjects, t);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadNavi
{
    _searchText = [UITextField createTextFieldWithFrame:CGRectMake(0, 10,SCREEN_WIDTH-50, 30)
                                        backgroundColor:KCOLOR_GRAY_f5f5f5
                                            borderStyle:UITextBorderStyleNone
                                            placeholder:NSLocalizedString(@"Localized_SearchListViewController_searchText",comment:"")
                                                   text:@""
                                              textColor:KCOLOR_Black_343434
                                                   font:kAutoFont_(13)
                                          textalignment:NSTextAlignmentCenter
                                          conrnerRadius:KCORNER_RADIUS_3
                                            borderWidth:0
                                            borderColor:KCOLOR_GRAY_f5f5f5];
    _searchText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchText.returnKeyType = UIReturnKeySearch;
    _searchText.delegate = self;
    
    CGRect frame = [_searchText frame];
    frame.size.width = 30;
    UILabel *leftView = [UILabel createLabelWithFrame:frame
                                      backgroundColor:KCOLOR_Clear
                                            textColor:KCOLOR_GRAY_676767
                                                 font:KICON_FONT_(15)
                                        textalignment:NSTextAlignmentCenter
                                                 text:@"\U0000e662"];
    _searchText.leftViewMode = UITextFieldViewModeAlways;  //左边距为15pix
    _searchText.leftView = leftView;
    _searchText.centerX = self.navigationController.navigationBar.centerX;
    [self.navigationController.navigationBar addSubview:_searchText];
}


#pragma mark - Filter the Quick Search
- (void)filterResults {
    // Asynchronously
    [self.QuickSearch asynchronouslyFilterObjectsWithValue:self.searchText.text completion:^(NSArray *searchList) {
        [self updateTableViewWithNewResults:searchList];
    }];
    
    // Synchronously
    //[self updateTableViewWithNewResults:[self.QuickSearch filteredObjectsWithValue:self.searchTextField.text]];
}

- (void)updateTableViewWithNewResults:(NSArray *)results {
    self.FilteredResults = results;
    [self.searchTableView reloadData];
}






#pragma mark - getAllData
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Search/school"];
    kSetDict(_searchText.text, @"text");
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
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView.header endRefreshing];
    }];
}



#pragma mark - init
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64 - 44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = KCOLOR_CLEAR;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


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
    if (_searchList.school.count>0) {
        if (section == 0) {
            return _searchList.school.count;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"cells";
    SearchSchoolListCell *cells = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cells == nil) {
        cells = [[SearchSchoolListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellIdentity];
    }
    
    if (_searchList.school.count >0)
    {
       School_data *mode =_searchList.school[indexPath.row];
         [cells setInfoWith:mode];
    }
    
    

    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    School_Details *tmp =  _searchList.school[indexPath.row];
    _hidden = [NSString stringWithFormat:@"%@",tmp.hidden];
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
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    School_Details *tmp =  _searchList.school[cell.tag];
    _hidden = [NSString stringWithFormat:@"%@",tmp.hidden];
    
    if ([_hidden isEqualToString:@"1"])
    {
        // show
        School_Details *tmp =  _searchList.school[cell.tag];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.sess_id forKey:@"sess_id"];
        [params setObject:tmp.id forKey:@"id"];
        NSLog(@"ID------------------------->%@",tmp.id );
        NSLog(@"hidden ------------------------->%@",tmp.hidden);
        
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
        // hidden
        
        
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
    
    
    
}




#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchList.school.count>0) {
        if (indexPath.section == 0) {
            return SW2;
        }
        else
            return SW2;
    }
    else
        return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchList.school.count>0) {
        return 30;
    }
    else
        return 10;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_searchList.school.count>0|| _searchList.school.count>0) {
        UIView *vv = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)
                                 backgroundColor:KCOLOR_GRAY_f5f5f5];
        UILabel *label = [UILabel createLabelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 30)
                                       backgroundColor:KCOLOR_Clear
                                             textColor:KCOLOR_GRAY_999999
                                                  font:kAutoFont_(13)
                                         textalignment:NSTextAlignmentLeft
                                                  text:@""];
        switch (section) {
            case 0:
                label.text = NSLocalizedString(@"Localized_SearchListViewController_school",comment:"");
                break;
                
            case 1:
                label.text = NSLocalizedString(@"Localized_SearchListViewController_Student",comment:"");
                break;
                
            default:
                break;
        }
        
        [vv addSubview:label];
        return vv;
    }
    
    return nil;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    School_Details *detailsSchool = _searchList.school[indexPath.row];
    MainView_C *vc = [[MainView_C alloc] init];
    vc.schoolId = detailsSchool.id;
    [self.navigationController pushViewController:vc animated:YES];
}


@end



