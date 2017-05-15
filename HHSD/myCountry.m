//
//  myCountry.m
//  HHSD
//
//  Created by alain serge on 3/24/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "myCountry.h"


@interface myCountry ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) Student_Details *individual_M;
@end

@implementation myCountry

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KCOLOR_THEME;
    UIButton *leftBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 40, 30)
                                        backgroundColor:KCOLOR_CLEAR
                                             titleColor:KCOLOR_WHITE
                                                   font:KSYSTEM_FONT_(15)
                                                  title:@"OK"];
    [leftBtn addTarget:self action:@selector(saveMyCountryname) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize nameLabel, codeLabel;

- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    self.nameLabel.text = name;
    self.codeLabel.text = code;
    
    NSLog(@" pays--------> %@",self.nameLabel.text);
}

- (void)saveMyCountryname
{
    DLog(@"name save");
    if([self.textField.text isEqualToString:@"0"])
        //    if(!self.textField.text.length)
    {
        [self MBShowHint:@"Enter your real name"];
        return ;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    kSetDict(self.nameLabel.text, @"nationality");  // Ok
    kSetDict(self.nameLabel.text, @"country");  // Ok
    kSetDict(self.codeLabel.text, @"Codecountry");  // Ok
    
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"user/nationality"];
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





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
