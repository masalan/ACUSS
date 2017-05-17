//
//  managerAdminPage.m
//  HHSD
//
//  Created by alain serge on 5/8/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "managerAdminPage.h"
#import "MainView_D.h"
#import "adminProfileCell.h"
#import "bgViewController.h"
#import "settingMyViewController.h"
#import "addSchoolByAdmin.h"
#import "addMajorProgram.h"
#define distance (SCREEN_HEIGHT/2)+20
#define avatar (SCREEN_WIDTH/2)-20
#define LabelWidth SCREEN_WIDTH/3-imageView.right-15

// Manage Pages
#import "admin_AllUniversities.h"
#import "admin_AllUsersApp.h"


@interface managerAdminPage ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) Student_Details *individual_M;



@end

@implementation managerAdminPage


- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = KCOLOR_GRAY_eeeeee;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"admin manager";
    [self getAllData];
    [self initUI];

}


- (void)initUI
{
    IMP_BLOCK_SELF(managerAdminPage);
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [block_self getAllData];
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.header = header;
    [header beginRefreshing];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 4;
    }
    if (section == 3) {
        return 5;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    adminProfileCell *cell = (adminProfileCell *)[_tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
            cell =[[adminProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section == 0)   // section 0
    {
        if (indexPath.row == 0) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e76a"
                                              titleString:@"All Universities"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = _individual_M.total_school;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e634"
                                              titleString:@"All Users"];
            cell.rightLabel.hidden = NO;
             cell.rightLabel.text = _individual_M.total_student;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    if (indexPath.section == 1)  // section 1
    {
        if (indexPath.row == 0) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e6ec"
                                              titleString:@"All Applications form Pending"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text =_individual_M.total_application;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e616"
                                              titleString:@"All Applications form Deleting"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = _individual_M.total_form_delete;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 2) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e62d"
                                              titleString:@"All Applications form Approuve"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"";
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    if (indexPath.section == 2)  // section 2
    {
        if (indexPath.row == 0) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e634"
                                               titleString:@"Manage students"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"";
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e62b"
                                               titleString:@"Manage agences"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"";
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 2) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e781"
                                              titleString:@"Setting Country list"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"";
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 3) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e670"
                                              titleString:@"Setting  Call support"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"";
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    
    if (indexPath.section == 3)  // section 3
    {
        if (indexPath.row == 0) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e634"
                                              titleString:@"Application configuration"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"";
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e603"
                                              titleString:@"Setting (log Out)"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"\U0000e603";
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 2) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e6db"
                                              titleString:@"Manage Backgrounds"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text =_individual_M.total_background;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 3) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e67d"
                                              titleString:@"Add a School"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text =_individual_M.total_school;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 4) {
            cell = [[adminProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e67d"
                                              titleString:@"Add a Major"];
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text =_individual_M.total_majors;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    
    return cell;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (4);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 44;
        }
            break;
            
        default: return 44;
            break;
    }
    return 44.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                   backgroundColor:KCOLOR_GRAY_Cell];
    headView.userInteractionEnabled = YES;
    
    switch (section) {
        case 0:
        {
            UILabel *iconLabel = [UILabel createLabelWithFrame:CGRectMake(10, 3, 30, 30)
                                               backgroundColor:KCOLOR_CLEAR
                                                     textColor:KCOLOR_BLACK
                                                          font:KICON_FONT_(20)
                                                 textalignment:NSTextAlignmentLeft
                                                          text:@"\U0000e60b"];
            [headView addSubview:iconLabel];
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(iconLabel.right+2, 15, SCREEN_WIDTH-(iconLabel.right+10), 15)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_GRAY_676767
                                                      font:KSYSTEM_FONT_(15)
                                             textalignment:NSTextAlignmentLeft
                                                      text:@"|Universities and Students Setting "];
            [headView addSubview:label];
            
            
            return headView;
        }
            break;
        case 1:
        {
            UILabel *iconLabel = [UILabel createLabelWithFrame:CGRectMake(10, 3, 30, 30)
                                               backgroundColor:KCOLOR_CLEAR
                                                     textColor:KCOLOR_BLACK
                                                          font:KICON_FONT_(20)
                                                 textalignment:NSTextAlignmentLeft
                                                          text:@"\U0000e60b"];
            [headView addSubview:iconLabel];
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(iconLabel.right+2, 15, SCREEN_WIDTH-(iconLabel.right+10), 15)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_GRAY_676767
                                                      font:KSYSTEM_FONT_(15)
                                             textalignment:NSTextAlignmentLeft
                                                      text:@"|Applications form  Setting "];
            [headView addSubview:label];
            
            
            return headView;
        }
        case 2:
        {
            UILabel *iconLabel = [UILabel createLabelWithFrame:CGRectMake(10, 3, 30, 30)
                                               backgroundColor:KCOLOR_CLEAR
                                                     textColor:KCOLOR_BLACK
                                                          font:KICON_FONT_(20)
                                                 textalignment:NSTextAlignmentLeft
                                                          text:@"\U0000e64f"];
            [headView addSubview:iconLabel];
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(iconLabel.right+2, 15, SCREEN_WIDTH-(iconLabel.right+10), 15)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_GRAY_676767
                                                      font:KSYSTEM_FONT_(15)
                                             textalignment:NSTextAlignmentLeft
                                                      text:@"|My Chinese Location "];
            [headView addSubview:label];
            
            
            return headView;
        }
        case 3:
        {
            UILabel *iconLabel = [UILabel createLabelWithFrame:CGRectMake(10, 3, 30, 30)
                                               backgroundColor:KCOLOR_CLEAR
                                                     textColor:KCOLOR_BLACK
                                                          font:KICON_FONT_(20)
                                                 textalignment:NSTextAlignmentLeft
                                                          text:@"\U0000e603"];
            [headView addSubview:iconLabel];
            
            UILabel *label = [UILabel createLabelWithFrame:CGRectMake(iconLabel.right+2, 15, SCREEN_WIDTH-(iconLabel.right+10), 15)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_GRAY_676767
                                                      font:KSYSTEM_FONT_(15)
                                             textalignment:NSTextAlignmentLeft
                                                      text:@"|Manage User using datas"];
            [headView addSubview:label];
            
            
            return headView;
        }
            
        default: return headView;
            break;
    }
    return [[UIView alloc] init];;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // admin_AllUniversities
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    admin_AllUniversities *vc = [[admin_AllUniversities alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    admin_AllUsersApp *vc = [[admin_AllUsersApp alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 1:
        {
            // section 1
        }
            break;
        case 2:
        {
            // section 2
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    settingMyViewController *vc = [[settingMyViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                {
                    bgViewController *vc = [[bgViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 3:
                {
                    addSchoolByAdmin *vc = [[addSchoolByAdmin alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 4:
                {
                    addMajorProgram *vc = [[addMajorProgram alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }
    
}



#pragma mark
#pragma mark netWork
- (void)getAllData
{
    IMP_BLOCK_SELF(managerAdminPage);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"manager/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _individual_M = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _tableView.hidden = NO;
            _individual_M = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            
            
            if ([_individual_M.admin isEqualToString:@"1"])
            {
                MainView_D *vc = [[MainView_D alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                self.leftBackBtn.hidden = NO;
            }else
            {
                //
            }
            [self tableView];
            [block_self.tableView reloadData];
            [block_self.tableView.header endRefreshing];
           }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [block_self.tableView.header endRefreshing];
    }];
}



@end
