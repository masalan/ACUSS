//
//  bgViewController.m
//  HHSD
//
//  Created by alain serge on 3/25/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "bgViewController.h"
#import "BackgroundImgCell.h"
#import "MainView_D.h"
#import "AddMyBackground.h"

#define distance (SCREEN_HEIGHT/2)+20
#define avatar (SCREEN_WIDTH/2)-20
#define LabelWidth SCREEN_WIDTH/3-imageView.right-15


@interface bgViewController ()<UITableViewDataSource,UITableViewDelegate,BgImgCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) BACKGROUND_IMAGES_LIST *capital_M_List;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BACKGROUND_IMAGES_LIST *capital_City_M_List;
@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, strong) UIView *headView,*myAdView;
@property (nonatomic, strong) Student_Details *personCenter_MyData;
@property (nonatomic , assign)int                           count;

@end

@implementation bgViewController

- (instancetype)init
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"My current background";
    [self initUI];
    UIButton *leftBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 30)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KCOLOR_WHITE
                                                   font:KICON_FONT_(15)
                                                  title:@"\U0000e6af"];
    [leftBtn addTarget:self action:@selector(AddNewBgImg) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];

    
//    __weak typeof(self) weakself = self;
//    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakself getAllData];
//    }];
    [self.tableView.header beginRefreshing];
}


- (void)initUI
{
    IMP_BLOCK_SELF(bgViewController);
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



-(void)AddNewBgImg
{
    AddMyBackground *vc = [AddMyBackground new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [BackgroundImgCell getHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return distance + 44;
        }
            break;
            
        default: return 44;
            break;
    }
    return 44.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)
                                     backgroundColor:KCOLOR_GRAY_f5f5f5];
    return footerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headView];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // open new page if u want
}

#pragma mark
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentity = @"cell0";
    BackgroundImgCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(!cell)
    {
        cell = [[BackgroundImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    Background_list *mode = self.capital_M_List.list[indexPath.row];
    mode.indexPath = [indexPath copy];
    
    [cell setMode:mode];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.capital_M_List.list.count;
}

- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.c_id, @"c_id");
    kSetDict(KIntTS(self.selectedBtn.tag), @"is_open");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Background/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.capital_M_List = nil;
        [self.tableView.header endRefreshing];
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            self.capital_M_List = [BACKGROUND_IMAGES_LIST objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
        }
       
        [self tableView];
        [self myAdView];
        [self getMyBg];
        
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView.header endRefreshing];
    }];
    
}

- (void)end
{
    [self.tableView.header endRefreshing];
    [self MBHidden];
}


#pragma mark
#pragma mark ViewInit
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = KCOLOR_THEME;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIView *)myAdView
{
    if(!_myAdView)
    {
        _myAdView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, distance) backgroundColor:KCOLOR_THEME];
        
        if(!_iconImageView)
        {
            _iconImageView = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, distance)];
            _iconImageView.backgroundColor = KCOLOR_WHITE;
            _iconImageView.userInteractionEnabled = YES;
            _iconImageView.image = [UIImage imageNamed:@""];
            _iconImageView.contentMode = UIViewContentModeScaleToFill;
            [_myAdView addSubview:_iconImageView];
        }
        
        
        _myAdView.backgroundColor = KCOLOR_THEME;
        _myAdView.userInteractionEnabled = YES;
        [_myAdView bk_whenTapped:^{
            MainView_D *vc = [[MainView_D alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [self.view addSubview:_myAdView];
    }
    return _myAdView;
}



- (UIView *)headView
{
    if(!_headView)
    {
        _headView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 + SCREEN_WIDTH/2.0)
                                backgroundColor:KCOLOR_CLEAR];
        _headView.userInteractionEnabled = YES;
        [_headView addSubview:self.myAdView];
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"\U0000e781",@"\U0000e75c", nil];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(0 + idx *SCREEN_WIDTH/2.0, self.myAdView.height, SCREEN_WIDTH/2.0, 44)
                                            backgroundColor:KCOLOR_CLEAR
                                                 titleColor:KCOLOR_THEME
                                                       font:KICON_FONT_(15)
                                                      title:obj];
            [btn setTitleColor:KCOLOR_WHITE forState:UIControlStateSelected];
            btn.tag = idx + 1;
            @weakify(self)
            btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self)
                _selectedBtn.selected = NO;
                btn.selected = YES;
                _selectedBtn = btn;
                [self getAllData];
                return [RACSignal empty];
            }];
            [RACObserve(btn, selected) subscribeNext:^(id x) {
                if(btn.selected)
                {
                    [btn setBackgroundColor:KCOLOR_THEME];
                }else
                {
                    [btn setBackgroundColor:KCOLOR_GRAY_Cell];
                }
            }];
            if(!idx)
            {
                _selectedBtn = btn;
                btn.selected = YES;
            }
            [_headView addSubview:btn];
        }];
    }
    return _headView;
}


#pragma mark
#pragma mark CapitalCellDelegtae
- (void)BgImgActionBtnClick:(Background_list *)mode
{
    DLog(@"cell Click");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    kSetDict(mode.id, @"bg_id");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    if([mode.is_apply intValue] == 1)
    {
        [string appendString:@"Background/apply"];
    }else
    {
        [string appendString:@"Background/apply"];
    }
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            if([mode.is_apply intValue] == 1)
            {
                mode.is_apply = [NSString stringWithFormat:@"2"];
            }else
            {
                mode.is_apply = [NSString stringWithFormat:@"1"];
            }
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[mode.indexPath copy], nil] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];

        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)getMyBg
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User_infos/index"];
    
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _personCenter_MyData = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_personCenter_MyData.bg_image]]
                              placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")]];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}



@end
