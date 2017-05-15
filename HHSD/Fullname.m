//
//  Fullname.m
//  HHSD
//
//  Created by alain serge on 3/24/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//


#import "Fullname.h"

@interface Fullname ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) Student_Details *individual_M;

@end

@implementation Fullname

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Full name";
    self.view.backgroundColor = KCOLOR_THEME;
    UIButton *leftBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 30)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(15)
                                                  title:@"OK"];
    [leftBtn addTarget:self action:@selector(saveFullName_User) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self topView];
    [self getAllData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark
#pragma mark otherAction
- (void)saveFullName_User
{
    DLog(@"name save");
    if([self.textField.text isEqualToString:@"0"])
    {
        [self MBShowHint:@"Enter your real name"];
        return ;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.textField.text, @"fullName");  // Ok
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"user/fullName"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:KMainView_D_getAllData object:self];
            [self MBShowSuccess:@"Succes"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
    
}
#pragma mark
#pragma mark ViewInit
- (UIView *)topView
{
    if(!_topView)
    {
        _topView = [UIView createViewWithFrame:CGRectMake(0, SCREEN_HEIGHT/6.0, SCREEN_WIDTH, 44)
                               backgroundColor:KCOLOR_WHITE];
        UILabel *iconeName = [UILabel createLabelWithFrame:CGRectMake(10, 0, 44, 44)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KTHEME_COLOR
                                                      font:KICON_FONT_(20)
                                             textalignment:NSTextAlignmentLeft
                                                      text:@"\U0000e6c4"];
        [_topView addSubview:iconeName];
        
        if(!_textField )
        {
            _textField =[UITextField createTextFieldWithFrame:CGRectMake(iconeName.right, 0, SCREEN_WIDTH - 70, 44)
                                              backgroundColor:KCOLOR_CLEAR
                                                  borderStyle:UITextBorderStyleNone
                                                  placeholder:@"Full name"
                                                         text:@""
                                                    textColor:KCOLOR_Black_343434
                                                         font:KSYSTEM_FONT_(15)
                                                textalignment:NSTextAlignmentLeft];
            _textField.clearButtonMode = UITextFieldViewModeWhileEditing;

            [_topView addSubview:_textField];
        }
        [self.view addSubview:_topView];
    }
    return _topView;
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
            
            if (_individual_M.fullName) {
                _textField.text = [NSString stringWithFormat:@"%@",_individual_M.fullName];
            }else
            {
                _textField.text = @"Your full name";
                
            }
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}




@end
