//
//  ViewByCityController.m
//  HHSD
//
//  Created by alain serge on 5/9/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "ViewByCityController.h"
#import "SWTableViewCell.h"
#import "citiesModel.h"
#import "SWTableViewCell.h"

#define kNumberOfObjects 200
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2
#define D 50
#define SW3 SCREEN_WIDTH/3

@interface ViewByCityController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,SWTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) citiesModel *searchCities;

@property (nonatomic, retain) NSString *Islike;
@property (nonatomic, retain) NSString *hidden;
@property (nonatomic, retain) NSString *SID;

@end

@implementation ViewByCityController
- (instancetype)init
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    return self;
}


#pragma mark - init
- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = KTHEME_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cities";
    self.view.backgroundColor = KTHEME_COLOR;

    [self getAllData];
    __weak typeof(self) weakself = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakself getAllData];
    }];

    // Do any additional setup after loading the view.
    
    //Hide Top bar
    
    self.navigationController.hidesBarsOnSwipe = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getAllData];
}

#pragma mark - getAllData
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"cities/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _searchCities = [citiesModel objectWithKeyValues:responseObject[@"data"]];
            if (_searchCities.cities.count == 0 ) {
                [self MBShowHint:@"no result"];
                _searchCities = nil;
            }
            [self.tableView reloadData];
            [self tableView ];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView.header endRefreshing];
    }];
}



#pragma mark
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentity = @"cells";
    AllCitiesListCell *cells = [_tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cells == nil) {
        cells = [[AllCitiesListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellIdentity];
    }
    if (_searchCities.cities.count >0) {
        Cities_data *mode =_searchCities.cities[indexPath.row];
        [cells setInfoWith:mode];
    }
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    Cities_data *tmp =  _searchCities.cities[indexPath.row];
    _Islike = [NSString stringWithFormat:@"%@",tmp.is_living];
    _hidden = [NSString stringWithFormat:@"%@",tmp.deleted];

    
    // Like/ Unlike
    if ([_Islike isEqualToString:@"1"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:KCOLOR_WHITE normalIcon:[UIImage imageNamed:@"hate"] selectedIcon:[UIImage imageNamed:@""]];
    }
    else if ([_Islike isEqualToString:@"0"])
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:KCOLOR_WHITE normalIcon:[UIImage imageNamed:@"love"] selectedIcon:[UIImage imageNamed:@""]];
    }
    
//    if ([_hidden isEqualToString:@"0"])
//    {
//        [rightUtilityButtons sw_addUtilityButtonWithColor:KCOLOR_RED normalIcon:[UIImage imageNamed:@"admin_edit"] selectedIcon:[UIImage imageNamed:@""]];
//    }
//    else if ([_hidden isEqualToString:@"1"])
//    {
//        [rightUtilityButtons sw_addUtilityButtonWithColor:KCOLOR_RED normalIcon:[UIImage imageNamed:@"admin_edit"] selectedIcon:[UIImage imageNamed:@""]];
//    }
    
    [cells setRightUtilityButtons:rightUtilityButtons WithButtonWidth:80.0];
    cells.delegate = self;
    cells.tag = indexPath.row;
    return cells;
    
}


#pragma mark
#pragma mark ----- SWCellDelegate -----
// click event on right utility button
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    
    Cities_data *tmp =  _searchCities.cities[cell.tag];

    switch (index) {
        case 0:
        {
            NSLog(@" unlike click");
            _Islike = [NSString stringWithFormat:@"%@",tmp.is_living];
            if ([_Islike isEqualToString:@"1"])
            {
                NSLog(@" Unlike click");
                Cities_data *tmp =  _searchCities.cities[cell.tag];
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:self.sess_id forKey:@"sess_id"];
                [params setObject:tmp.id forKey:@"id"];
                NSMutableString *string = [NSMutableString stringWithString:urlHeader];
                [string appendString:@"cities/user_Out"];
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
            }else if ([_Islike isEqualToString:@"0"])
            {
                NSLog(@" Like click");
                Cities_data *tmp =  _searchCities.cities[cell.tag];
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:self.sess_id forKey:@"sess_id"];
                [params setObject:tmp.id forKey:@"id"];
                NSMutableString *string = [NSMutableString stringWithString:urlHeader];
                [string appendString:@"cities/user_On"];
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
            
            break;
        }
            break;
            
        default:
            break;
    }
    
}



// AllcitiesListCell
#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.searchCities.cities.count;
}

#pragma mark
#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SW2+80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   /*****
    
    School_Details *detailsSchool = _searchList.school[indexPath.row];
    MainView_C *vc = [[MainView_C alloc] init];
    vc.schoolId = detailsSchool.id;
    
    School_data *stats = _searchList.school[indexPath.row];
    NSString *hidden;
    hidden = stats.hidden;
    
    if ([hidden isEqualToString:@"1"])  // its coming soon
    {
        
    } else if ([hidden isEqualToString:@"0"])  // open new page
    {
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    ****/
    
}



@end





























@implementation AllCitiesListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor=KCOLOR_WHITE;
        [self addContent];
    }
    return  self;
}

-(void)addContent {
    
    _logoImageView = [[UIImageView alloc] init];
    _maintenance = [[UIImageView alloc] init];
    _province = [[UILabel alloc] init];
    _cityTypeIcone = [[UILabel alloc] init];
    _cityTypeLabel = [[UILabel alloc] init];
    _cityTypeName = [[UILabel alloc] init];
    _climateTypeIcone = [[UILabel alloc] init];
    _climateTypeLabel = [[UILabel alloc] init];
    _climateTypeName = [[UILabel alloc] init];
    _livingTypeIcone = [[UILabel alloc] init];
    _livingTypeLabel = [[UILabel alloc] init];
    _livingTypeName = [[UILabel alloc] init];
    _lineOne = [[UILabel alloc] init];
    _lineTwo = [[UILabel alloc] init];

    
    
    
    
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SW2)];
    _logoImageView.backgroundColor = KCOLOR_CLEAR;
    _logoImageView.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.cellScrollView addSubview:_logoImageView ];
    
    
    _maintenance = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35,SW2-35,30,30)];
    _maintenance.backgroundColor = KCOLOR_CLEAR;
    _maintenance.layer.cornerRadius = _maintenance.size.height/2;
    _maintenance.layer.masksToBounds = YES;
    _maintenance.backgroundColor = KCOLOR_CLEAR;
    _maintenance.contentMode = UIViewContentModeScaleAspectFill;
    [self.cellScrollView addSubview:_maintenance ];
 
    // Province
   
        _province = [UILabel resizeFrameWithLabel:_province
                                            frame:CGRectMake(10,SW2-21,SCREEN_WIDTH/2,20)
                                  backgroundColor:KCOLOR_BLACK
                                        textColor:KCOLOR_WHITE
                                             font:KICON_FONT_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
    _province.alpha = 0.6;
        _province.layer.cornerRadius = 8;
        _province.layer.masksToBounds = YES;
        [self.cellScrollView addSubview:_province];
   
    
    // City Icone
   
        _cityTypeIcone = [UILabel resizeFrameWithLabel:_cityTypeIcone
                                                 frame:CGRectMake(0,SW2+5,SW3,20)
                                  backgroundColor:KCOLOR_WHITE
                                        textColor:KTHEME_COLOR
                                             font:KICON_FONT_(15)
                                    textalignment:NSTextAlignmentCenter
                                             text:@"\U0000e733"];
        [self.cellScrollView addSubview:_cityTypeIcone];
    
    
    // City label
   
    _cityTypeLabel = [UILabel resizeFrameWithLabel:_cityTypeLabel
                                             frame:CGRectMake(0,_cityTypeIcone.bottom,SW3,20)
                                       backgroundColor:KCOLOR_WHITE
                                             textColor:KTHEME_COLOR
                                                  font:KICON_FONT_(11)
                                         textalignment:NSTextAlignmentCenter
                                                  text:@"City Type"];
        [self.cellScrollView addSubview:_cityTypeLabel];
   
    
    // City Name
    
        _cityTypeName = [UILabel resizeFrameWithLabel:_cityTypeName
                                                frame:CGRectMake(0,_cityTypeLabel.bottom,SW3,30)
                                       backgroundColor:KCOLOR_WHITE
                                             textColor:KCOLOR_BLACK
                                                  font:KICON_FONT_(11)
                                         textalignment:NSTextAlignmentCenter
                                                  text:@""];
        _cityTypeName.numberOfLines =3;
        [self.cellScrollView addSubview:_cityTypeName];
    
    
    
    // Climate Icone
   
        _climateTypeIcone = [UILabel resizeFrameWithLabel:_climateTypeIcone
                                                    frame:CGRectMake(SW3,SW2+5,SW3,20)
                                       backgroundColor:KCOLOR_WHITE
                                             textColor:KTHEME_COLOR
                                                  font:KICON_FONT_(15)
                                         textalignment:NSTextAlignmentCenter
                                                  text:@"\U0000e61e"];
        [self.cellScrollView addSubview:_climateTypeIcone];
    
    
    
    // Climate Label
    
        _climateTypeLabel = [UILabel resizeFrameWithLabel:_climateTypeLabel
                                                    frame:CGRectMake(SW3,_climateTypeIcone.bottom,SW3,20)
                                          backgroundColor:KCOLOR_WHITE
                                                textColor:KTHEME_COLOR
                                                     font:KICON_FONT_(11)
                                            textalignment:NSTextAlignmentCenter
                                                     text:@"Climate"];
        [self.cellScrollView addSubview:_climateTypeLabel];
    
    
    // Climate Name
   
        _climateTypeName = [UILabel resizeFrameWithLabel:_climateTypeName
                                                   frame:CGRectMake(SW3,_climateTypeLabel.bottom,SW3,30)
                                      backgroundColor:KCOLOR_WHITE
                                            textColor:KCOLOR_BLACK
                                                 font:KICON_FONT_(11)
                                        textalignment:NSTextAlignmentCenter
                                                 text:@""];
        _climateTypeName.numberOfLines =3;
      [self.cellScrollView addSubview:_climateTypeName];
   
    
    
    
    
    
    // Living Icone
        _livingTypeIcone = [UILabel resizeFrameWithLabel:_livingTypeIcone
                                                   frame:CGRectMake(2*SW3,SW2+5,SW3,20)
                                          backgroundColor:KCOLOR_WHITE
                                                textColor:KTHEME_COLOR
                                                     font:KICON_FONT_(15)
                                            textalignment:NSTextAlignmentCenter
                                                     text:@"\U0000e667"];
       [self.cellScrollView addSubview:_livingTypeIcone];
   
    
    
    // Living Label
    
        _livingTypeLabel = [UILabel resizeFrameWithLabel:_livingTypeLabel
                                                   frame:CGRectMake(2*SW3,_livingTypeIcone.bottom,SW3,20)
                                         backgroundColor:KCOLOR_WHITE
                                               textColor:KTHEME_COLOR
                                                    font:KICON_FONT_(11)
                                           textalignment:NSTextAlignmentCenter
                                                    text:@"Living Cost"];
       [self.cellScrollView addSubview:_livingTypeLabel];
    
    
    // Living Name
    
        _livingTypeName = [UILabel resizeFrameWithLabel:_livingTypeName
                                                  frame:CGRectMake(2*SW3,_livingTypeLabel.bottom,SW3,20)
                                         backgroundColor:KCOLOR_WHITE
                                               textColor:KCOLOR_BLACK
                                                    font:KICON_FONT_(11)
                                           textalignment:NSTextAlignmentCenter
                                                    text:@""];
        _livingTypeName.numberOfLines =3;
       [self.cellScrollView addSubview:_livingTypeName];
   
    
    
    
  
        _lineOne = [UILabel resizeFrameWithLabel:_lineOne
                                           frame:CGRectMake(SW3-0.5,_cityTypeIcone.bottom,0.5,50)
                                        backgroundColor:KCOLOR_GRAY_Cell
                                              textColor:KCOLOR_GRAY_Cell
                                                   font:KICON_FONT_(11)
                                          textalignment:NSTextAlignmentCenter
                                                   text:@""];
        [self.cellScrollView addSubview:_lineOne];
    
    
    
   
        _lineTwo = [UILabel resizeFrameWithLabel:_lineTwo
                                           frame:CGRectMake(_climateTypeLabel.right-0.5,_climateTypeIcone.bottom,0.5,50)
                                 backgroundColor:KCOLOR_GRAY_Cell
                                       textColor:KCOLOR_GRAY_Cell
                                            font:KICON_FONT_(11)
                                   textalignment:NSTextAlignmentCenter
                                            text:@""];
        [self.cellScrollView addSubview:_lineTwo];

    
}

- (void)setInfoWith:(Cities_data *)cities_data {
    
    
    if(cities_data) {
        if([cities_data.image hasPrefix:@"http"]) {
            [_logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",cities_data.image]] placeholderImage:[UIImage imageNamed:@"6000"] options:SDWebImageRetryFailed];
        }
        
        _province.text = [NSString stringWithFormat:@"\U0000e67b Study in %@",cities_data.locationName];
        _cityTypeName.text = cities_data.citytype;
        _climateTypeName.text = cities_data.climate;
        _livingTypeName.text = cities_data.average;

        
        if ([cities_data.is_living isEqualToString:@"1"])
        {
            _maintenance.image = [UIImage imageNamed:@"isLiving"];
            
        } else if ([cities_data.is_living isEqualToString:@"0"])
        {
            _maintenance.image = [UIImage imageNamed:@""];
        }
        
        
        
    }
}







@end


