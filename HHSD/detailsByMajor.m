//
//  detailsByMajor.m
//  HHSD
//
//  Created by alain serge on 4/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "detailsByMajor.h"
#import "majorViewDetailsCell.h"
#import "applyForMajor.h"
#import "quickApplyFormNow.h"

#define distance (SCREEN_HEIGHT/2)+20
#define avatar (SCREEN_WIDTH/2)-20
#define LabelWidth SCREEN_WIDTH/3-imageView.right-15
#define SW3 (SCREEN_WIDTH/3)-10


@interface detailsByMajor ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImageView *headImageView,*myBgImage,*countryCode;
@property (nonatomic, retain) UILabel *FullnameLabel,*lineLabel1,*totalLabel,*totalLabels,*totalLast,*nationality,*sex,*majorTotal,*commentsTotal,*viewsTotal,*labelCourseName;
@property (nonatomic, retain) UIButton *btnOne,*btnTwo,*btnTree,*btnFour,*topHeader;
@property (nonatomic, retain) UIView *topView;
@property (nonatomic, retain) UIButton *gouWuQuan;
@property (nonatomic, retain) UILabel *gouWuquanLabel;
@property (nonatomic, retain) UIButton *woDeShouCang;
@property (nonatomic, retain) UILabel *woDeShouCangLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) School_Details *schoolDetail; // Details School

@property (nonatomic, strong) UIButton *bottomBtn,*getMore,*addReview;



@end

@implementation detailsByMajor


- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64 - 44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tableView.backgroundColor = KTHEME_COLOR;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

// Top Header
- (UIImageView *)myBgImage
{
    if(!_myBgImage) {
        _myBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _myBgImage.image = [UIImage imageNamed:@"6000"];
        _myBgImage.contentMode = UIViewContentModeScaleToFill;
        _myBgImage.backgroundColor = KTHEME_COLOR;
        //_myBgImage.alpha =0.5;
        
    }
    return _myBgImage;
}

- (UIButton *)topHeader
{
    
    if(!_topHeader) {
        _topHeader = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        [_topHeader setBackgroundColor:KCOLOR_CLEAR];
        _topHeader.contentMode = UIViewContentModeScaleAspectFill;
        
        if(!_headImageView) {
            _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, 100,100)];
            _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
            _headImageView.centerX = SCREEN_WIDTH/2.0;
            _headImageView.layer.masksToBounds = YES;
            _headImageView.layer.borderWidth = 2;
            _headImageView.layer.borderColor = KCOLOR_CLEAR.CGColor;
            _headImageView.backgroundColor = KCOLOR_CLEAR;
            _headImageView.contentMode = UIViewContentModeScaleAspectFill;
            _headImageView.image = [UIImage imageNamed:@"PlaceHoder"];
            [_topHeader addSubview:_headImageView];
        }
        
        if(!_FullnameLabel) {
            _FullnameLabel = [UILabel createLabelWithFrame:CGRectMake(20, _headImageView.bottom+10, SCREEN_WIDTH - 40, 50)
                                           backgroundColor:KCOLOR_Clear
                                                 textColor:KCOLOR_BLACK_32343a
                                                      font:KICON_FONT_(18)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@""];
            _FullnameLabel.numberOfLines = 3;
            
            [_topHeader addSubview:_FullnameLabel];
        }
        
        
    }
    return _topHeader;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"";
    [self getAllData];
    __weak typeof(self) weakself = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakself getAllData];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 7;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    majorViewDetailsCell *cell = (majorViewDetailsCell *)[_tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        cell =[[majorViewDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)  // section 0
    {
        if (indexPath.row == 0) {
            [self myBgImage];
            [self topHeader];
            [cell addSubview:_myBgImage];
            [cell addSubview:_topHeader];
        }
        
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell = [[majorViewDetailsCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e76a"
                                              titleString:@"Degree"];
            cell.rightLabel.hidden = NO;
            if (_schoolDetail.cat_name) {
                cell.rightLabel.text = _schoolDetail.cat_name;
            }else{
                cell.rightLabel.text = @"";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            cell = [[majorViewDetailsCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e781"
                                              titleString:@"Starting Date"];
            cell.rightLabel.hidden = NO;
            
            if (_schoolDetail.startingDate) {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",_schoolDetail.startingDate];
            }else{
                cell.rightLabel.text = @"";
            }
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 2) {
            cell = [[majorViewDetailsCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                                    iconString:@"\U0000e6ce"
                                                   titleString:@"Application Deadline"];
            cell.rightLabel.hidden = NO;
            
            if (_schoolDetail.deadline) {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@",_schoolDetail.deadline];
            }else{
                cell.rightLabel.text = @"";
            }
            cell.rightLabel.tintColor = KCOLOR_RED;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row ==3) {
            cell = [[majorViewDetailsCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e641"
                                              titleString:@"Duration"];
            cell.rightLabel.hidden = NO;
            if (_schoolDetail.duration) {
                cell.rightLabel.text = [NSString stringWithFormat:@"%@ years",_schoolDetail.duration];
            }else{
                cell.rightLabel.text = @"";
            }
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 4) {
            cell = [[majorViewDetailsCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e781"
                                              titleString:@"Teaching Language"];
            cell.rightLabel.hidden = NO;
            if (_schoolDetail.language) {
                cell.rightLabel.text = _schoolDetail.language;
            }else{
                cell.rightLabel.text = @"";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 5) {
            cell = [[majorViewDetailsCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e715"
                                              titleString:@"Tuition Fees"];
            cell.rightLabel.hidden = NO;
            
            if (_schoolDetail.fee) {
                cell.rightLabel.text = [NSString stringWithFormat:@"RMB %@ in Total",_schoolDetail.fee];
            }else{
                cell.rightLabel.text = @"";
            }
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 6) {
            cell = [[majorViewDetailsCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                                    iconString:@"\U0000e76b"
                                                   titleString:@"Application Fee"];
            cell.rightLabel.hidden = NO;
            if (_schoolDetail.fee_apply) {
                cell.rightLabel.text = [NSString stringWithFormat:@"USD %@ (Non Refundable)",_schoolDetail.fee_apply];
            }else{
                cell.rightLabel.text = @"";
            }
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        
    }
    
    
    
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0 ) {
        return (indexPath.row == 0) ? 200 : 60;
    }
    else {
        return 44;
    }
    return 44;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
            case 0:
        {
            return 0.01;
        }
            break;
            
        default: return 50.0;
            break;
    }
    return 50.0;
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)
                                   backgroundColor:KTHEME_COLOR];
    headView.userInteractionEnabled = YES;
    
    switch (section) {
            case 0:
        {
            
        }
            break;
            case 1:
        {
          
            
            _labelCourseName = [UILabel createLabelWithFrame:CGRectMake(15,5, SCREEN_WIDTH-30,45)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_WHITE
                                                      font:KSYSTEM_FONT_(17)
                                             textalignment:NSTextAlignmentCenter
                                                      text:nil];
            _labelCourseName.numberOfLines = 3;
            //labelCourseName
            if (_schoolDetail.CourseName) {
                _labelCourseName.text = [NSString stringWithFormat:@"%@",_schoolDetail.CourseName];
            }else{
                _labelCourseName.text = [NSString stringWithFormat:@""];
            }
            
            [headView addSubview:_labelCourseName];
            
            
            return headView;
        }
         
        default: return headView;
            break;
    }
    return [[UIView alloc] init];;
}



#pragma mark
#pragma mark netWork
- (void)getAllData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    kSetDict(self.school_details.id, @"id");
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/detail_major"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _schoolDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _schoolDetail = [School_Details objectWithKeyValues:responseObject[@"data"]];
            
            self.SID = [self.schoolDetail.id copy];
            
            // School logo
            if([_schoolDetail.photo hasPrefix:@"http"]) {
                [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_schoolDetail.photo]]
                               placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")]];
            }
            else {
                _headImageView.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
            }
            
            if([_schoolDetail.photo hasPrefix:@"http"]) {
                [_myBgImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_schoolDetail.background]]
                                  placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")]];
            }
            else {
                _myBgImage.image = [UIImage imageNamed:@"6000"];
            }
            
            
            // School Name
            if (_schoolDetail.nameSchool) {
                _FullnameLabel.text = [NSString stringWithFormat:@"%@",_schoolDetail.nameSchool];
            }else{
                _FullnameLabel.text = [NSString stringWithFormat:@""];
            }
            
            
            // School Name
            if (_schoolDetail.nameSchool) {
                 self.title = [NSString stringWithFormat:@"%@",_schoolDetail.nameSchool];
            }else{
                 self.title = [NSString stringWithFormat:@""];
            }
           

            
            
          [self.tableView reloadData];
             [self tableView];
            [self bottomView];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    }];
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
                                                font:KICON_FONT_(12)
                                               title:@"\U0000e6d9 send SMS"];
        _bottomBtn.layer.cornerRadius = 5.0;
        _bottomBtn.layer.masksToBounds = YES;
        
        [_bottomBtn addTarget:self
                      action:@selector(sendSMS)
            forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomView addSubview:_bottomBtn];  //1
        
        //2
        UIButton *btnStartd = [UIButton createButtonwithFrame:CGRectMake(_bottomBtn.right+3, 6,SW3, 32)
                                              backgroundColor:KCOLOR_BLUE
                                                   titleColor:KCOLOR_WHITE
                                                         font:KICON_FONT_(12)
                                                        title:@"\U0000e624 Call now"
                                                conrnerRadius:5.0
                                                  borderWidth:1.0
                                                  borderColor:KCOLOR_BLUE];
        
        
        [btnStartd addTarget:self
                      action:@selector(telClick)
            forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:btnStartd];  // ok
        
        // ADD REVIEW
        UIButton *btn = [UIButton createButtonwithFrame:CGRectMake(btnStartd.right+3, 6, SW3, 32)
                                        backgroundColor:KCOLOR_GREEN_09bb07
                                             titleColor:KCOLOR_WHITE
                                                   font:KICON_FONT_(12)
                                                  title:@"\U0000e70c Quick Apply"
                                          conrnerRadius:5.0
                                            borderWidth:1.0
                                            borderColor:KCOLOR_GREEN_09bb07];
        
        
        btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            if([btn.titleLabel.text isEqual: @"\U0000e70c Quick Apply" ])
            {

//                applyForMajor *vc = [[applyForMajor alloc] init];
//                vc.SID = [self.schoolDetail.id copy];
//                NSLog(@"Apply ID----------------------------------------> %@",[self.schoolDetail.id copy]);
//                [self.navigationController pushViewController:vc animated:YES];
//                 
//                
                
                 
                

               // quickApplyFormNow *vc = [[quickApplyFormNow alloc] init];
               //// vc.SID = [self.schoolDetail.id copy];
               // NSLog(@"Apply ID----------------------------------------> %@",[self.schoolDetail.id copy]);
               // [self.navigationController pushViewController:vc animated:YES];
                
                [self getAllDataUser];

            }
            
            return [RACSignal empty];
        }];
        [_bottomView addSubview:btn]; // ok
        
        
        
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (void)getAllDataUser
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict([self.schoolDetail.id copy], @"id");  // Major ID
    NSLog(@"GET ID Major ----------------------------------------> %@",[self.schoolDetail.id copy]);

    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"Programs_cylce/quick_apply_view"];//server
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:NO sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.schoolDetail = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            NSDictionary *dic = responseObject[@"data"];
            quickApplyFormNow *vc = [[quickApplyFormNow alloc] init];
            vc.isMyFabu = YES;
            vc.params = [[NSMutableDictionary alloc] initWithDictionary:dic];
             [self.navigationController pushViewController:vc animated:YES];
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        
    }];
}

//call
- (void)telClick
{
    DLog(@"call");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call the office" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    [alert show];
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_schoolDetail.support_phone]]];
    }else
    {
        return ;
    }
}
//sent SMS
- (void)sendSMS
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",_schoolDetail.support_phone]]];

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
