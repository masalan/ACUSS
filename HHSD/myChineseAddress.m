//
//  myChineseAddress.m
//  HHSD
//
//  Created by alain serge on 3/25/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//
#import "CNCityPickerView.h"
#import "myChineseAddress.h"

#define SW2 SCREEN_WIDTH/2
#define SW3 SCREEN_WIDTH/3
#define SH2 SCREEN_HEIGHT/2

#define LW SCREEN_WIDTH/3

@interface myChineseAddress ()
@property (nonatomic, strong) UIView *topView,*headerView;
@property (nonatomic, strong) UILabel *titleLabel,*provinceLabel,*cityLabel,*areaLabel,*provinceName,*cityName,*areaName;
@property (nonatomic, strong) Student_Details *individual_M;


@end

@implementation myChineseAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    [self topView];
    [self headerView];
  
    self.view.backgroundColor = KCOLOR_THEME;
    UIButton *leftBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 30)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(15)
                                                  title:@"OK"];
    [leftBtn addTarget:self action:@selector(saveLocation_User) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark otherAction
- (void)saveLocation_User
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"Please wait!";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.provinceName.text, @"province_name");
    kSetDict(self.cityName.text, @"city_name");
    kSetDict(self.areaName.text, @"area_name");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"user/location"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
             [hud hideAnimated:YES afterDelay:0.5];
             [[NSNotificationCenter defaultCenter] postNotificationName:KMainView_D_getAllData object:self];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = PromptMessage;
         [hud hideAnimated:YES afterDelay:0.5];
    }];
    
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
            _individual_M = [Student_Details objectWithKeyValues:responseObject[@"data"]];
           
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}





-(UIView *)topView
{
    if (!_topView) {
        
        _topView = [UIView createViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SW2)
                               backgroundColor:KCOLOR_CLEAR];
        
        
        UILabel *lineOne =[UILabel createLabelWithFrame:CGRectMake(_provinceName.right+0.5,(SW2-30)/2,0.5,40)
                                        backgroundColor:KCOLOR_WHITE
                                              textColor:KCOLOR_CLEAR
                                                   font:KSYSTEM_FONT_15
                                          textalignment:NSTextAlignmentLeft
                                                   text:nil];
        [_topView addSubview:lineOne];

        
        
        if (!_provinceName) {
            _provinceName = [UILabel createLabelWithFrame:CGRectMake(0,(SW2-30)/2,LW,40)
                                          backgroundColor:KCOLOR_CLEAR
                                                textColor:KCOLOR_WHITE
                                                     font:KICON_FONT_(15)
                                            textalignment:NSTextAlignmentCenter
                                                     text:@"province"];
            [_topView addSubview:_provinceName];
        }
        
        if (!_cityName) {
            _cityName = [UILabel createLabelWithFrame:CGRectMake(_provinceName.right,(SW2-30)/2,LW,40)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_WHITE
                                                 font:KICON_FONT_(15)
                                        textalignment:NSTextAlignmentCenter
                                                 text:@"city"];
            [_topView addSubview:_cityName];
        }
        
        
        if (!_areaName) {
            _areaName = [UILabel createLabelWithFrame:CGRectMake(_cityName.right,(SW2-30)/2,LW,40)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_WHITE
                                                 font:KICON_FONT_(15)
                                        textalignment:NSTextAlignmentCenter
                                                 text:@"area"];
            [_topView addSubview:_areaName];
        }
        
        
        
        
        
        
        
        
        [self.view addSubview:_topView];
    }
    return _topView;
}


-(UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [UIView createViewWithFrame:CGRectMake(0,_topView.bottom,SCREEN_WIDTH,200) backgroundColor:KCOLOR_CLEAR];
       
        if (!_provinceLabel) {
            _provinceLabel = [UILabel createLabelWithFrame:CGRectMake(0,5,LW,40)
                                        backgroundColor:KCOLOR_CLEAR
                                              textColor:KCOLOR_WHITE
                                                   font:KICON_FONT_(15)
                                          textalignment:NSTextAlignmentCenter
                                                   text:@"province"];
            [_headerView addSubview:_provinceLabel];
        }
        
        if (!_cityLabel) {
            _cityLabel = [UILabel createLabelWithFrame:CGRectMake(_provinceLabel.right,5,LW,40)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_WHITE
                                                      font:KICON_FONT_(15)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@"city"];
            [_headerView addSubview:_cityLabel];
        }
        
       
        if (!_areaLabel) {
            _areaLabel = [UILabel createLabelWithFrame:CGRectMake(_cityLabel.right,5,LW,40)
                                       backgroundColor:KCOLOR_CLEAR
                                             textColor:KCOLOR_WHITE
                                                  font:KICON_FONT_(15)
                                         textalignment:NSTextAlignmentCenter
                                                  text:@"area"];
            [_headerView addSubview:_areaLabel];
        }
        
        
        
        CNCityPickerView *pickerView = [CNCityPickerView createPickerViewWithFrame:CGRectMake(10,0,SCREEN_WIDTH-20,200)
                                                              valueChangedCallback:^(NSString *province, NSString *city, NSString *area) {
                                                                 
                                                                  
                                                                  
                 _provinceName.text = [NSString stringWithFormat:@"%@",province];
                 _cityName.text = [NSString stringWithFormat:@"%@",city];
                 _areaName.text = [NSString stringWithFormat:@"%@ ",area];
                                                                  
                                                                  
                                                              }];
        
        
        pickerView.textAttributes = @{NSForegroundColorAttributeName :KCOLOR_YELLOW,
                                      NSFontAttributeName : KSYSTEM_FONT_15
                                      };
        pickerView.rowHeight = 30.0f;
        
        [_headerView addSubview:pickerView];
        
        
        
        [self.view addSubview:_headerView];
    }
    return _headerView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
