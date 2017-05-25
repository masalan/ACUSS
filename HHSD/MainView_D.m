//
//  MainView_D.m
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MainView_D.h"
#define distance (SCREEN_HEIGHT/2)+20
#define avatar (SCREEN_WIDTH/2)-20
#define LabelWidth SCREEN_WIDTH/3-imageView.right-15
#import "userProfileCell.h"
#import "demoPageT.h"
#import "chineseAddress.h"
#import "avatarUserViewController.h"
#import "Fullname.h"
#import "CountryViewController.h"
#import "IndividualBirthViewController.h"
#import "occupation.h"
#import "sex.h"
#import "myCountry.h"
#import "LivingViewController.h"
#import "myChineseAddress.h"
#import "bgViewController.h"
#import "settingMyViewController.h"
#import "addSchoolByAdmin.h"
#import "addMajorProgram.h"
#import "studentMoreViewController.h"
#import "paysViewController.h"
#import "MainView_E.h"

#import "WelcomeViewController.h"
#import <linkedin-sdk/LISDK.h>
#import <TwitterKit/TwitterKit.h>
#import "LinkedInHelper.h"
#import "socialMainPage.h"
#import "MainPageViewController.h"
#import "PopMenu.h"
#import "InstagramLoginViewController.h"
#import "FKAuthViewController.h"
#import "managerAdminPage.h"  // manager

#import "SignupAgence.h" // Signup
#import "myAgencePage.h"

#import "my_tweet.h"
#import "myTweetViewController.h"
#import "allMygraduteList.h"

// Admin is 6

#define SW2 SCREEN_WIDTH/2

@interface MainView_D ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) Student_Details *individual_M;
@property (nonatomic, retain) UIImageView *headImageView,*myBgImage,*countryCode;
@property (nonatomic, retain) UILabel *FullnameLabel,*lineLabel1,*totalLabel,*totalLabels,*totalLast,*nationality,*sex,*majorTotal,*commentsTotal,*viewsTotal;
@property (nonatomic, retain) UILabel *smsTotals,*moreInfos,*receiveTotal,*sendTotal;
@property (nonatomic, retain) UIButton *btnOne,*btnTwo,*btnTree,*btnFour,*btnFive,*topHeader;
@property (nonatomic, retain) UIView *topView;
@property (nonatomic, retain) UIButton *gouWuQuan;
@property (nonatomic, retain) UILabel *gouWuquanLabel;
@property (nonatomic, retain) UIButton *woDeShouCang;
@property (nonatomic, retain) UILabel *woDeShouCangLabel;
@property (nonatomic, strong) UIButton *leftNavBtn,*rightNavBtn,*socialBtnLogin;
@property (nonatomic,strong) NSUserDefaults * userDefaults;
@property (nonatomic, assign) NSUInteger topSelectedTag;
@property (nonatomic, assign) NSString *socialLoginTag,*sess_ID,*S_ID,*G_ID,*L_ID,*email,*gender,*last_name,*first_name,*name,*picture,*phone,*location,*social_type;
@property (nonatomic, assign) NSString *googleIsLogin,*facebookIsLogin,*twitterIsLogin,*instagramIsLogin,*linkedlnIsLogin,*yahooIsLogin;
@property (nonatomic, assign) NSMutableArray *profileUser;
@property (nonatomic, strong) PopMenu *popMenu;
@property (nonatomic, strong) Mobile_Config *conig_app;
@property (nonatomic, retain) FKFlickrNetworkOperation *todaysInterestingOp;
@property (nonatomic, retain) FKFlickrNetworkOperation *myPhotostreamOp;
@property (nonatomic, retain) FKDUNetworkOperation *completeAuthOp;
@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;
@property (nonatomic, retain) FKImageUploadNetworkOperation *uploadOp;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic , assign)int                           count;

@end

@implementation MainView_D

-(instancetype)init
{
    self =[super init];
    if (self) {
        _topSelectedTag = 1;
        _socialLoginTag = @"Facebook";
        _googleIsLogin      = 0;
        _facebookIsLogin    = 0;
        _twitterIsLogin     = 0;
        _instagramIsLogin   = 0;
        _linkedlnIsLogin    = 0;
        _yahooIsLogin       = 0;
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
   // [self tableView];
    [self socialLogOutBtn];
    self.view.backgroundColor = KTHEME_COLOR;
    self.title = @"Me";
    [self initUI];
    _userDefaults=[NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLocating:) name:@"ForceUpdateLocation" object:nil]; // don't forget the ":"
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAuthenticateCallback:) name:@"UserAuthCallbackNotification" object:nil];
    [GIDSignIn sharedInstance].uiDelegate = self;

}

- (void)initUI
{
    IMP_BLOCK_SELF(MainView_D);
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        block_self.count = 0;
        [block_self getAllData];
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.header = header;
    [header beginRefreshing];
}

- (void)viewDidAppear:(BOOL)animated {
   
    
}


-(void)socialLogOutBtn
{
    
    for (UIButton *btn in [self.navigationController.navigationBar subviews]) {
        if (btn.tag >= 1000) {
            [btn removeFromSuperview];
        }
    }
    
    self.leftNavBtn = [UIButton createButtonwithFrame:CGRectMake(0, 0, 25, 25)
                                      backgroundColor:KCOLOR_Clear
                                           titleColor:KCOLOR_WHITE
                                                 font:KICON_FONT_(21)
                                                title:@""];
    [self.leftNavBtn addTarget:self action:@selector(deconnexionSocialUser:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavBtn];
    self.leftNavBtn.tag = 1;  // facebook
    
    self.rightNavBtn = [UIButton createButtonwithFrame:
                        CGRectMake(0, 0,80, 25)
                                       backgroundColor:KCOLOR_Clear
                                            titleColor:KCOLOR_WHITE
                                                  font:KICON_FONT_(10)
                                                 title:@"Social Login"];
                                                 //title:@"\U0000e70c"];
    [self.rightNavBtn addTarget:self
                         action:@selector(loginSocialConnexion)
               forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithCustomView:self.rightNavBtn];
   // self.rightNavBtn.tag = 2;  // Linkedln
}

- (void)deconnexionSocialUser:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        // facebook LogOut
        
        socialMainPage *vc = [[socialMainPage alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (sender.tag == 2)
    {
       
        // socialMainPage
        
     
        
        NSLog(@"%s","clear pressed");
        LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
        [linkedIn logout];
        WelcomeViewController *VC = [[WelcomeViewController alloc] init];
        UINavigationController *naVc = [[UINavigationController alloc] initWithRootViewController:VC];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = naVc;
        if (!linkedIn.isValidToken) {
            self.rightNavBtn.hidden = YES;
            NSLog(@"  LinkedIn------------->  0 ");
        }else
        {
            NSLog(@"  LinkedIn------------->  1 ");
        }
        
    }
    
    
    }





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







- (UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64 - 44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = KCOLOR_GRAY_eeeeee;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

// Top Header
- (UIImageView *)myBgImage
{
    if(!_myBgImage) {
        _myBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, distance)];
        _myBgImage.image = [UIImage imageNamed:@"1000"];
        _myBgImage.contentMode = UIViewContentModeScaleToFill;
        _myBgImage.backgroundColor = KTHEME_COLOR;
        //_myBgImage.alpha =0.5;
        
    }
    return _myBgImage;
}

- (UIButton *)topHeader
{
    
    if(!_topHeader) {
        _topHeader = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, distance)];
         [_topHeader setBackgroundColor:KCOLOR_CLEAR];
        [_topHeader addTarget:self action:@selector(editAvatarUser) forControlEvents:UIControlEventTouchUpInside];
        _topHeader.contentMode = UIViewContentModeScaleAspectFill;
        
        if(!_headImageView) {
            _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,30, 150,150)];
            _headImageView.layer.cornerRadius = _headImageView.frame.size.height/2;
            _headImageView.centerX = SCREEN_WIDTH/2.0;
            _headImageView.layer.masksToBounds = YES;
            _headImageView.layer.borderWidth = 2;
            _headImageView.layer.borderColor = KCOLOR_CLEAR.CGColor;
            _headImageView.backgroundColor = KCOLOR_CLEAR;
            _headImageView.contentMode = UIViewContentModeScaleAspectFill;
            [_topHeader addSubview:_headImageView];
        }
        
        if(!_FullnameLabel) {
            _FullnameLabel = [UILabel createLabelWithFrame:CGRectMake(10, _headImageView.bottom+10, SCREEN_WIDTH - 20, 25)
                                           backgroundColor:KCOLOR_Clear
                                                 textColor:KCOLOR_BLACK_32343a
                                                      font:KICON_FONT_(18)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@""];
            
            [_topHeader addSubview:_FullnameLabel];
        }
        
        //countryCode
        if(!_countryCode) {
            _countryCode = [[UIImageView alloc] initWithFrame:CGRectMake(10, _FullnameLabel.bottom+1,24,24)];
            _countryCode.centerX = SCREEN_WIDTH/2.0;
            _countryCode.backgroundColor = KCOLOR_CLEAR;
            _countryCode.contentMode = UIViewContentModeScaleAspectFill;
            [_topHeader addSubview:_countryCode];
        }
        
        
        //nationality
        if(!_nationality) {
            _nationality = [UILabel createLabelWithFrame:CGRectMake(10, _countryCode.bottom+1, SCREEN_WIDTH - 20,18)
                                         backgroundColor:KCOLOR_Clear
                                               textColor:KCOLOR_RED
                                                    font:KICON_FONT_(14)
                                           textalignment:NSTextAlignmentCenter
                                                    text:@""];
            
            [_topHeader addSubview:_nationality];
        }
        
        //sex
        if(!_sex) {
            _sex = [UILabel createLabelWithFrame:CGRectMake(10, _nationality.bottom+4,25,25)
                                 backgroundColor:KCOLOR_Clear
                                       textColor:KCOLOR_BLUE
                                            font:KICON_FONT_(14)
                                   textalignment:NSTextAlignmentCenter
                                            text:@"\U0000e60f"];
            
            _sex.layer.cornerRadius = _sex.frame.size.height/2;
            _sex.layer.masksToBounds = YES;
            _sex.layer.borderWidth = 2;
            _sex.layer.borderColor = KCOLOR_CLEAR.CGColor;
            _sex.backgroundColor = KCOLOR_WHITE;
            _sex.centerX = SCREEN_WIDTH/2.0;
            [_topHeader addSubview:_sex];
        }
    }
    return _topHeader;
}



-(void)editAvatarUser
{
    avatarUserViewController *vc = [[avatarUserViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


// major Count
- (UIButton *)btnOne {
    if(!_btnOne) {
        _btnOne = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 65)];
        _btnOne.backgroundColor = KCOLOR_CLEAR;
        [_btnOne addTarget:self action:@selector(graduateBtnClik) forControlEvents:UIControlEventTouchUpInside];
        
        _lineLabel1 =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH/3-0.5, 0, 0.5, _btnOne.size.height)
                                   backgroundColor:KCOLOR_Line_Color textColor:nil font:nil
                                     textalignment:NSTextAlignmentLeft text:nil];
        [_btnOne addSubview:_lineLabel1];
        
        UILabel *imageView =[UILabel createLabelWithFrame:CGRectMake(2,3,(SCREEN_WIDTH/3)-4,30)
                                          backgroundColor:KCOLOR_CLEAR
                                                textColor:KCOLOR_RED
                                                     font:KICON_FONT_(25)
                                            textalignment:NSTextAlignmentCenter
                                                     text:@"\U0000e76a"];
        [_btnOne addSubview:imageView];
        
        UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(2,imageView.bottom-10,(SCREEN_WIDTH/3)-4,30)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_GRAY_676767
                                                      font:KSYSTEM_FONT_(11)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@"Graduates"];
        [_btnOne addSubview:nameLabel];
        
        if(!_majorTotal) {
            _majorTotal = [UILabel createLabelWithFrame:CGRectMake(2,nameLabel.bottom-10,(SCREEN_WIDTH/3)-4,15)
                                        backgroundColor:KCOLOR_Clear
                                              textColor:KCOLOR_GRAY_999999
                                                   font:KSYSTEM_FONT_(8)
                                          textalignment:NSTextAlignmentCenter
                                                   text:@""];
            [_btnOne addSubview:_majorTotal];
        }
    }
    return _btnOne;
}

//Comments count
- (UIButton *)btnTwo {
    if(!_btnTwo) {
        _btnTwo = [[UIButton alloc] initWithFrame:CGRectMake(_btnOne.right, 0, SCREEN_WIDTH/3, 65)];
        _btnTwo.backgroundColor = KCOLOR_CLEAR;
        [_btnTwo addTarget:self action:@selector(commentsBtnClik) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lineLabel =[UILabel createLabelWithFrame:CGRectMake(_btnTwo.width-0.25, 0, 0.5, _btnTwo.size.height)
                                          backgroundColor:KCOLOR_Line_Color
                                                textColor:nil font:nil textalignment:NSTextAlignmentLeft text:nil];
        [_btnTwo addSubview:lineLabel];
        
        UILabel *imageView =[UILabel createLabelWithFrame:CGRectMake(2,3,(SCREEN_WIDTH/3)-4,30)
                                     backgroundColor:KCOLOR_CLEAR
                                           textColor:KCOLOR_RED
                                                font:KICON_FONT_(25)
                                       textalignment:NSTextAlignmentCenter
                                                text:@"\U0000e753"];
        [_btnTwo addSubview:imageView];
        
        UILabel *Namelabel = [UILabel createLabelWithFrame:CGRectMake(2,imageView.bottom-10,(SCREEN_WIDTH/3)-4,30)
                                       backgroundColor:KCOLOR_CLEAR
                                             textColor:KCOLOR_GRAY_676767
                                                  font:KSYSTEM_FONT_(11)
                                         textalignment:NSTextAlignmentCenter
                                                  text:@"Comments"];
        [_btnTwo addSubview:Namelabel];
        
        if(!_commentsTotal) {
            _commentsTotal = [UILabel createLabelWithFrame:CGRectMake(2,Namelabel.bottom-10,(SCREEN_WIDTH/3)-4,15)
                                         backgroundColor:KCOLOR_Clear
                                               textColor:KCOLOR_GRAY_999999
                                                    font:KSYSTEM_FONT_(8)
                                           textalignment:NSTextAlignmentCenter
                                                    text:@""];
            [_btnTwo addSubview:_commentsTotal];
        }
    }
    return _btnTwo;
}


//Btn Right
- (UIButton *)btnTree {
    if(!_btnTree) {
        _btnTree = [[UIButton alloc] initWithFrame:CGRectMake(_btnTwo.right, 0, SCREEN_WIDTH/3, 65)];
        _btnTree.backgroundColor = KCOLOR_CLEAR;
        [_btnTree addTarget:self action:@selector(ViewMyApplyForm) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lineLabel3 =[UILabel createLabelWithFrame:CGRectMake(_btnTree.width-0.25, 0, 0.5, _btnTree.size.height)
                                          backgroundColor:KCOLOR_Line_Color
                                                textColor:nil font:nil textalignment:NSTextAlignmentLeft text:nil];
        [_btnTree addSubview:lineLabel3];
        
        UILabel *imageView =[UILabel createLabelWithFrame:CGRectMake(2,3,(SCREEN_WIDTH/3)-4,30)
                                          backgroundColor:KCOLOR_CLEAR
                                                textColor:KCOLOR_RED
                                                     font:KICON_FONT_(25)
                                            textalignment:NSTextAlignmentCenter
                                                     text:@"\U0000e601"];
        [_btnTree addSubview:imageView];
        
        UILabel *Namelabel = [UILabel createLabelWithFrame:CGRectMake(2,imageView.bottom-10,(SCREEN_WIDTH/3)-4,30)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_GRAY_676767
                                                      font:KSYSTEM_FONT_(11)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@"Apply form"];
        [_btnTree addSubview:Namelabel];
        
        if(!_viewsTotal) {
            _viewsTotal = [UILabel createLabelWithFrame:CGRectMake(2,Namelabel.bottom-10,(SCREEN_WIDTH/3)-4,15)
                                         backgroundColor:KCOLOR_Clear
                                               textColor:KCOLOR_GRAY_999999
                                                    font:KSYSTEM_FONT_(8)
                                           textalignment:NSTextAlignmentCenter
                                                    text:@""];
            [_btnTree addSubview:_viewsTotal];
        }
    }
    return _btnTree;
}


// *btnFour,*btnFive

// All tweets
- (UIButton *)btnFour {
    if(!_btnFour) {
        _btnFour = [[UIButton alloc] initWithFrame:CGRectMake(0,_btnOne.bottom, SCREEN_WIDTH/2, 65)];
        _btnFour.backgroundColor = KCOLOR_CLEAR;
        [_btnFour addTarget:self action:@selector(tweetBtnClik) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lineLabel3 =[UILabel createLabelWithFrame:CGRectMake(_btnFour.width-0.25, 0, 0.5, _btnFour.size.height)
                                           backgroundColor:KCOLOR_Line_Color
                                                 textColor:nil font:nil textalignment:NSTextAlignmentLeft text:nil];
        [_btnFour addSubview:lineLabel3];
        
        // Send Icon
        UILabel *imageViewSend =[UILabel createLabelWithFrame:CGRectMake(2,3,(SW2/2)-4,30)
                                          backgroundColor:KCOLOR_CLEAR
                                                textColor:KCOLOR_RED
                                                     font:KICON_FONT_(25)
                                            textalignment:NSTextAlignmentCenter
                                                     text:@"\U0000e769"];
        [_btnFour addSubview:imageViewSend];
        
        // Receive Icon
        UILabel *imageViewRecevie =[UILabel createLabelWithFrame:CGRectMake(imageViewSend.right,3,(SW2/2)-4,30)
                                              backgroundColor:KCOLOR_CLEAR
                                                    textColor:KCOLOR_RED
                                                         font:KICON_FONT_(25)
                                                textalignment:NSTextAlignmentCenter
                                                         text:@"\U0000e74c"];
        [_btnFour addSubview:imageViewRecevie];
        
        UILabel *NamelabelSend = [UILabel createLabelWithFrame:CGRectMake(2,imageViewSend.bottom-10,(SW2/2)-4,30)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_GRAY_676767
                                                      font:KSYSTEM_FONT_(11)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@"Send"];
        [_btnFour addSubview:NamelabelSend];
        
        
        
        UILabel *NamelabelReceive= [UILabel createLabelWithFrame:CGRectMake(NamelabelSend.right,imageViewRecevie.bottom-10,(SW2/2)-4,30)
                                               backgroundColor:KCOLOR_CLEAR
                                                     textColor:KCOLOR_GRAY_676767
                                                          font:KSYSTEM_FONT_(11)
                                                 textalignment:NSTextAlignmentCenter
                                                          text:@"Receive"];
        [_btnFour addSubview:NamelabelReceive];
        
        
        if(!_sendTotal) {
            _sendTotal = [UILabel createLabelWithFrame:CGRectMake(2,NamelabelSend.bottom-10,(SW2/2)-4,15)
                                        backgroundColor:KCOLOR_Clear
                                              textColor:KCOLOR_GRAY_999999
                                                   font:KSYSTEM_FONT_(8)
                                          textalignment:NSTextAlignmentCenter
                                                   text:@""];
            [_btnFour addSubview:_sendTotal];
        }
        
        if(!_receiveTotal) {
            _receiveTotal = [UILabel createLabelWithFrame:CGRectMake(_sendTotal.right,NamelabelReceive.bottom-10,(SW2/2)-4,15)
                                       backgroundColor:KCOLOR_Clear
                                             textColor:KCOLOR_GRAY_999999
                                                  font:KSYSTEM_FONT_(8)
                                         textalignment:NSTextAlignmentCenter
                                                  text:@""];
            [_btnFour addSubview:_receiveTotal];
        }
    }
    return _btnFour;
}

// More
- (UIButton *)btnFive {
    if(!_btnFive) {
        _btnFive = [[UIButton alloc] initWithFrame:CGRectMake(_btnFour.right,_btnTwo.bottom, SCREEN_WIDTH/2, 65)];
        _btnFive.backgroundColor = KCOLOR_CLEAR;
        [_btnFive addTarget:self action:@selector(MoreStudentDetails) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lineLabel =[UILabel createLabelWithFrame:CGRectMake(_btnFive.width-0.25, 0, 0.5, _btnFive.size.height)
                                          backgroundColor:KCOLOR_Line_Color
                                                textColor:nil font:nil textalignment:NSTextAlignmentLeft text:nil];
        [_btnFive addSubview:lineLabel];
        
        UILabel *imageView =[UILabel createLabelWithFrame:CGRectMake(2,3,(SCREEN_WIDTH/2)-4,30)
                                          backgroundColor:KCOLOR_CLEAR
                                                textColor:KCOLOR_RED
                                                     font:KICON_FONT_(25)
                                            textalignment:NSTextAlignmentCenter
                                                     text:@"\U0000e753"];
        [_btnFive addSubview:imageView];
        
        UILabel *Namelabel = [UILabel createLabelWithFrame:CGRectMake(2,imageView.bottom-10,(SCREEN_WIDTH/2)-4,30)
                                           backgroundColor:KCOLOR_CLEAR
                                                 textColor:KCOLOR_GRAY_676767
                                                      font:KSYSTEM_FONT_(11)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@"more infos"];
        [_btnFive addSubview:Namelabel];
        
        if(!_moreInfos) {
            _moreInfos = [UILabel createLabelWithFrame:CGRectMake(2,Namelabel.bottom-10,(SCREEN_WIDTH/2)-4,15)
                                           backgroundColor:KCOLOR_Clear
                                                 textColor:KCOLOR_GRAY_999999
                                                      font:KSYSTEM_FONT_(8)
                                             textalignment:NSTextAlignmentCenter
                                                      text:@""];
            [_btnFive addSubview:_moreInfos];
        }
    }
    return _btnFive;
}

-(void)graduateBtnClik
{
    allMygraduteList *vc =[[allMygraduteList alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)ViewMyApplyForm {
    MainView_E *vc =[[MainView_E alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)commentsBtnClik {
    studentMoreViewController *vc =[[studentMoreViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tweetBtnClik
{
    myTweetViewController *vc = [[myTweetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)MoreStudentDetails
{
   // myTweetViewController *vc = [[myTweetViewController alloc]  init];
   // [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 5;
    }
    if (section == 2) {
        return 3;
    }
    if (section == 3) {
        return 4;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (4);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    userProfileCell *cell = (userProfileCell *)[_tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        cell =[[userProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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
        if (indexPath.row == 1) {
            [self btnOne];
            [self btnTwo];
            [self btnTree];
            [self btnFour];
            [self btnFive];
            [cell addSubview:_btnOne];
            [cell addSubview:_btnTwo];
            [cell addSubview:_btnTree];
            [cell addSubview:_btnFour];
            [cell addSubview:_btnFive];
        }

    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                           iconString:@"\U0000e634"
                                          titleString:@"Full name"];
            cell.rightLabel.hidden = NO;
            
            if (_individual_M.realname) {
                cell.rightLabel.text = _individual_M.fullName;
            }else{
                 cell.rightLabel.text = @"";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e781"
                                              titleString:@"Nationality"];
            cell.rightLabel.hidden = NO;
            if (_individual_M.nationality) {
                cell.rightLabel.text = _individual_M.nationality;
            }else{
                cell.rightLabel.text = @"";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 2) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e641"
                                              titleString:@"Birthday"];
            cell.rightLabel.hidden = NO;
            
            if (_individual_M.birthday) {
                cell.rightLabel.text = [PublicMethod getYMDUsingCreatedTimestamp:_individual_M.birthday];

            }else{
                cell.rightLabel.text = @"";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 3) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e76b"
                                              titleString:@"Occupation"];
            cell.rightLabel.hidden = NO;
            
                if([_individual_M.profession isEqualToString:@"0"])
                {
                    cell.rightLabel.text = @"\U0000e76a Student";
                }
                else if ([_individual_M.profession isEqualToString:@"1"])
                {
                    cell.rightLabel.text = @"Teacher";
                }
                else if ([_individual_M.profession isEqualToString:@"2"])
                {
                    cell.rightLabel.text = @"Searcher";
                }
                else if ([_individual_M.profession isEqualToString:@"3"])
                {
                    cell.rightLabel.text = @"Visitor";
                }
                else if ([_individual_M.profession isEqualToString:@"4"])
                {
                    cell.rightLabel.text = @"Other";
                }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 4) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e691"
                                              titleString:@"Sex"];
            cell.rightLabel.hidden = NO;
            
            if([_individual_M.sex  isEqualToString:@"0"])
            {
                cell.rightLabel.text = @"\U0000e6bf";
            }
            else if ([_individual_M.sex  isEqualToString:@"1"])
            {
                cell.rightLabel.text = @"\U0000e60f";
            }
            else if ([_individual_M.sex  isEqualToString:@"2"])
            {
                cell.rightLabel.text = @"\U0000e690";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e67b"
                                              titleString:@"Province"];
            cell.rightLabel.hidden = NO;
            
            if (_individual_M.province_name) {
                cell.rightLabel.text = _individual_M.province_name;
            }else{
                cell.rightLabel.text = @"";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 1) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e66d"
                                              titleString:@"Province/City"];
            cell.rightLabel.hidden = NO;
            
            if (_individual_M.city_name) {
                cell.rightLabel.text = _individual_M.city_name;
            }else{
                cell.rightLabel.text = @"";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row == 2) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e6de"
                                              titleString:@"Area"];
            cell.rightLabel.hidden = NO;
            
            if (_individual_M.area_name) {
                cell.rightLabel.text = _individual_M.area_name;
            }else{
                cell.rightLabel.text = @"";
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
    if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e67b"
                                              titleString:@"Province"];
            cell.rightLabel.hidden = NO;
            
            if([_individual_M.living_in_china  isEqualToString:@"0"])
            {
                cell.rightLabel.text = @"I am not in china";
            }
            else if ([_individual_M.living_in_china  isEqualToString:@"1"])
            {
                cell.rightLabel.text = @"I am currently living in china";
            }
            
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if([_individual_M.admin isEqualToString:@"1"])
        {
            if (indexPath.row == 1) {
                cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                                   iconString:@"\U0000e603"
                                                  titleString:@"Setting (log Out)"];
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = @"\U0000e603";
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        
        // Admin is 6
        else if ([_individual_M.admin isEqualToString:@"6"])
        {
            if (indexPath.row == 1) {
                cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                                   iconString:@"\U0000e603"
                                                  titleString:@"Admin  DashBoard"];
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = @"\U0000e768";
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
        else{
            
            if (indexPath.row == 1) {
                cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                                   iconString:@"\U0000e603"
                                                  titleString:@"Setting (log Out)"];
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = @"\U0000e603";
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                return cell;
            }
            
        }
        
        if (indexPath.row == 2) {
            cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                               iconString:@"\U0000e6db"
                                              titleString:@"Background Images"];
                                          cell.rightLabel.hidden = NO;
                                          cell.rightLabel.text = @"\U0000e6db";
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }

        
        if (indexPath.row == 3) {
            
          if ([_individual_M.is_agence isEqualToString:@"1"])
            {
                
                cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                                   iconString:@"\U0000e72e"
                                                  titleString:@"My agence Page"];
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = @"\U0000e70e";
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                return cell;
            }
            else if ([_individual_M.is_agence isEqualToString:@"0"])
            {
                
                cell = [[userProfileCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                                   iconString:@"\U0000e72e"
                                                  titleString:@"Became agence "];
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = @"\U0000e70e";
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                return cell;
                
            }
            
            
            
          
        }
        
        
    }
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0 ) {
        return (indexPath.row == 0) ? distance : 130;
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
            
        default: return 44;
            break;
    }
    return 44.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)
                                   backgroundColor:KCOLOR_YELLOW_F2EB05];
    headView.userInteractionEnabled = YES;

    switch (section) {
        case 0:
        {
            
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
                                                      text:@"|Personal Information "];
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
                                                      text:@"|Setting"];
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
   
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                
                case 0:
                {
                      Fullname *vc = [[Fullname alloc] init];                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    //myCountry *vc = [[myCountry alloc] init];
                    paysViewController *vc = [[paysViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                {
                    IndividualBirthViewController *vc = [[IndividualBirthViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case 3:
                {
                    occupation *vc = [[occupation alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 4:
                {
                    sex *vc = [[sex alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    myChineseAddress *vc = [[myChineseAddress alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                    case 1:
                {
                    myChineseAddress *vc = [[myChineseAddress alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                     break;
                case 2:
                {
                    myChineseAddress *vc = [[myChineseAddress alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            
            
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    LivingViewController *vc = [[LivingViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    
                    
                    if([_individual_M.admin isEqualToString:@"1"])
                    {
                        settingMyViewController *vc = [[settingMyViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    else if ([_individual_M.admin isEqualToString:@"6"])
                    {
                        managerAdminPage *vc = [[managerAdminPage alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    else
                    {
                        settingMyViewController *vc = [[settingMyViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
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
                     if ([_individual_M.is_agence isEqualToString:@"1"])
                    {
                        myAgencePage *vc = [[myAgencePage alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    else if ([_individual_M.is_agence isEqualToString:@"0"])
                    {
                        SignupAgence *vc = [[SignupAgence alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                                        
                }
                    break;
               
                    
                    // SignupAgence
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
    IMP_BLOCK_SELF(MainView_D);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.sess_id forKey:@"sess_id"];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"User_infos/index"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        _individual_M = nil;
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _tableView.hidden = NO;
            _individual_M = [Student_Details objectWithKeyValues:responseObject[@"data"]];
            [block_self.tableView reloadData];
            [block_self.tableView.header endRefreshing];
            [self getAllDataSocial];
    
            if([_individual_M.avatar_user hasPrefix:@"http"]) {
                [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_individual_M.avatar_user]]
                              placeholderImage:[UIImage imageNamed:@""]
                                       options:SDWebImageRefreshCached];
            }
            else {
                _headImageView.image = [UIImage imageNamed:@""];
            }
            
            
        if([_individual_M.bg_image hasPrefix:@"http"]) {
                [_myBgImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_individual_M.bg_image]]
                             placeholderImage:[UIImage imageNamed:@"1000"]
                                      options:SDWebImageRefreshCached];
            }
            else {
                _myBgImage.image = [UIImage imageNamed:@"1000"];
            }
            
            // Flag view
            NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@",_individual_M.Codecountry];
            
            if(_individual_M.Codecountry ) {
                _countryCode.image = [UIImage imageNamed:imagePath];
            }
            else {
                _countryCode.image = [UIImage imageNamed:@"CountryPicker.bundle/CN"];

            }
            
            
            
            

            if (_individual_M.nationality)
            {
                _nationality.text = _individual_M.nationality;
            }else
            {
                _nationality.text = @"";
            }
           
            if (_individual_M.fullName) {
                _FullnameLabel.text = _individual_M.fullName;
            }else
            {
                _FullnameLabel.text = @"";
            }
            
            // Comments count
            if (_individual_M.comment_total) {
                _commentsTotal.text = _individual_M.comment_total;
            }else
            {
                _commentsTotal.text = @"";
            }
            
            // major count
            if (_individual_M.major_total) {
                _majorTotal.text = _individual_M.major_total;
            }else
            {
                _majorTotal.text = @"";
            }
            
            //_viewsTotal
            if (_individual_M.view_total) {
                _viewsTotal.text = _individual_M.view_total;
            }else
            {
                _viewsTotal.text = @"";
            }
            
            
            if (_individual_M.tweet_sent) {
                _sendTotal.text = _individual_M.tweet_sent;
            }else
            {
                _sendTotal.text = @"";
            }
            
            if (_individual_M.tweet_receive) {
                _receiveTotal.text = _individual_M.tweet_receive;
            }else
            {
                _receiveTotal.text = @"";
            }
            
            
                if([_individual_M.sex  isEqualToString:@"0"])
                {
                    _sex.text = @"\U0000e6bf";
                }
                else if ([_individual_M.sex  isEqualToString:@"1"])
                {
                    _sex.text = @"\U0000e60f";
                }
                else if ([_individual_M.sex  isEqualToString:@"2"])
                {
                    _sex.text = @"\U0000e690";
                }
        
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            _tableView.hidden = YES;
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
        [block_self.tableView.header endRefreshing];
    }];
}

//=====================================================  SOCIAL NETWORK CONNEXION SETTING    =====================================================//


-(void)loginSocialConnexion
{
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    if ([_linkedlnIsLogin isEqualToString:@"0"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"LinkedIn" iconName:@"linkedln" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    else if ([_linkedlnIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"" iconName:@"linkedln_login" glowColor:KCOLOR_RED];
        [items addObject:menuItem];
    }
    
    
    if ([_googleIsLogin isEqualToString:@"0"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Googleplus" iconName:@"google" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    else if ([_googleIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"" iconName:@"google_login" glowColor:KCOLOR_RED];
        [items addObject:menuItem];
    }
    
    
    if ([_facebookIsLogin isEqualToString:@"0"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Facebook" iconName:@"facebook" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    else if ([_facebookIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"" iconName:@"facebook_login" glowColor:KCOLOR_RED];
        [items addObject:menuItem];
    }
    
    
    if ([_twitterIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Twitter" iconName:@"twitter" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    else if ([_twitterIsLogin isEqualToString:@"0"])
    {
       // MenuItem *menuItem = [MenuItem itemWithTitle:@"" iconName:@"twitterk_login" glowColor:KCOLOR_RED];
       // [items addObject:menuItem];
    }
    
    if ([_yahooIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Yahoo" iconName:@"yahoo" glowColor:KCOLOR_WHITE];
        [items addObject:menuItem];
    }
    else if ([_yahooIsLogin isEqualToString:@"0"])
    {
        // its logged
    }
    
    
    if ([_instagramIsLogin isEqualToString:@"1"])
    {
        MenuItem *menuItem = [MenuItem itemWithTitle:@"Instagram" iconName:@"Instagram" glowColor:KCOLOR_CLEAR];
        [items addObject:menuItem];
    }
    else if ([_instagramIsLogin isEqualToString:@"0"])
    {
       // MenuItem *menuItem = [MenuItem itemWithTitle:@"" iconName:@"instagram_login" glowColor:KCOLOR_RED];
       // [items addObject:menuItem];
    }
    
    
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
        _popMenu.perRowItemCount = 3;
        _popMenu.backgroundColor = KTHEME_COLOR;
       // [_popMenu showMenuAtView:self.view];
    }
    if (_popMenu.isShowed) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        NSLog(@"selectedItem-------------> %@",selectedItem.title);
        if ([selectedItem.title isEqualToString:@"LinkedIn"]) {
            _topSelectedTag = 1;
            _socialLoginTag = @"linkedln";
           [weakSelf linkedInLogin];  // Ok
        }
        else if ([selectedItem.title isEqualToString:@"Googleplus"])
        {
            _topSelectedTag = 2;
            _socialLoginTag = @"google";
           [weakSelf googlePlusLogin];
        }
        else if ([selectedItem.title isEqualToString:@"Facebook"])
        {
            _topSelectedTag = 3;
            _socialLoginTag = @"facebook";
           [weakSelf facebookLogin];  // OK
        }
        
        
        else if ([selectedItem.title isEqualToString:@"Twitter"])
        {
            _topSelectedTag = 4;
            _socialLoginTag = @"twitter";
           [weakSelf TwitterLogin];
        }
        else if ([selectedItem.title isEqualToString:@"Instagram"])
        {
            _topSelectedTag = 5;
            _socialLoginTag = @"instagram";
           [weakSelf instagramLogin];
        }
        else if ([selectedItem.title isEqualToString:@"Yahoo"])
        {
            _topSelectedTag = 6;
            _socialLoginTag = @"yahoo";
          [weakSelf flickerLogin];
        }
        
    };
    
    [_popMenu showMenuAtView:self.view];
    
}


#pragma mark
#pragma mark netWork
- (void)getAllDataSocial
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSMutableString *string = [NSMutableString stringWithString:urlHeader];
    [string appendString:@"manager/my_social"];
    [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([[responseObject objectForKey:@"code"] isEqual:@200])
        {
            _conig_app = [Mobile_Config objectWithKeyValues:responseObject[@"data"]];
            
            // Statement social login
            _googleIsLogin      = _conig_app.google;
            _facebookIsLogin    = _conig_app.facebook;
            _twitterIsLogin     = _conig_app.twitter;
            _instagramIsLogin   = _conig_app.instagram;
            _linkedlnIsLogin    = _conig_app.linkedln;
            _yahooIsLogin       = _conig_app.yahoo;
            
        }
        if([[responseObject objectForKey:@"code"] isEqual:@500])
        {
            //  [self MBShowHint:responseObject[@"message"]];
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
    }];
}











#pragma mark - Auth

- (void) userAuthenticateCallback:(NSNotification *)notification {
    NSURL *callbackURL = notification.object;
    self.completeAuthOp = [[FlickrKit sharedFlickrKit] completeAuthWithURL:callbackURL completion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
        NSLog(@"User id %@,User name %@",userId,userName);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self userLoggedIn:userName userID:userId];
            } else {
                [self showingAlert:@"Error" :error.localizedDescription];
                
                
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
}

- (void) userLoggedIn:(NSString *)username userID:(NSString *)userID {
    self.userID = userID;
    [self showAlertForLoggedIn:username];
    [_userDefaults setObject:username forKey:@"flickerLogin"];
    [_userDefaults synchronize];
}

- (void) userLoggedOut {
}


- (void)startLocating:(NSNotification *)notification {
    
    NSDictionary *dict = [notification userInfo];
    
    NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
    desc =[[NSMutableDictionary alloc] initWithDictionary:dict];
    [self showAlertForLoggedIn:desc];
    
}



-(void)facebookLogin {
    
    __block  NSMutableDictionary *fbResultData;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         [SVProgressHUD showWithStatus:@"Login..."];
         
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
             [[FBSDKLoginManager new] logOut];
         } else {
             NSLog(@"Logged in OK");
             [SVProgressHUD dismiss];
             
             if ([FBSDKAccessToken currentAccessToken])
             {
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,name,age_range,birthday,devices,email,gender,last_name,family,friends,location,picture" parameters:nil]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                          
                          NSString * accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
                          NSLog(@"fetched user:%@ ,%@", result,accessToken);
                          
                          fbResultData =[[NSMutableDictionary alloc]init];
                          
                          if ([result objectForKey:@"email"]) {
                              [fbResultData setObject:[result objectForKey:@"email"] forKey:@"email"];
                          }
                          if ([result objectForKey:@"gender"]) {
                              [fbResultData setObject:[result objectForKey:@"gender"] forKey:@"gender"];
                          }
                          if ([result objectForKey:@"name"]) {
                              NSArray *arrName;
                              arrName=[[result objectForKey:@"name"] componentsSeparatedByString:@" "];
                              
                              [fbResultData setObject:[arrName objectAtIndex:0] forKey:@"name"];
                          }
                          if ([result objectForKey:@"last_name"]) {
                              [fbResultData setObject:[result objectForKey:@"last_name"] forKey:@"last_name"];
                          }
                          if ([result objectForKey:@"id"]) {
                              [fbResultData setObject:[result objectForKey:@"id"] forKey:@"id"];
                          }
                          
                          FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                                        initWithGraphPath:[NSString stringWithFormat:@"me/picture?type=large&redirect=false"]
                                                        parameters:nil
                                                        HTTPMethod:@"GET"];
                          [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                                id result,
                                                                NSError *error) {
                              if (!error){
                                  
                                  if ([[result objectForKey:@"data"] objectForKey:@"url"]) {
                                      [fbResultData setObject:[[result objectForKey:@"data"] objectForKey:@"url"] forKey:@"picture"];
                                  }
                                  
                                  //You get all detail here in fbResultData
                                  NSLog(@"Final data of FB login********%@",fbResultData);
                                  
                                  [_userDefaults setObject:fbResultData forKey:@"facebookLogin"];
                                  
                                  [_userDefaults synchronize];
                                  
                                  [SVProgressHUD dismiss];
                                  [self showAlertForLoggedIn:fbResultData];
                                  
                              } }];
                      }
                      else {
                          NSLog(@"result:----------> %@",[error description]);
                          //                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error description] delegate:nil cancelButtonTitle:NSLocalizedString(@"DISMISS", nil) otherButtonTitle:nil];
                          // [alert showInView:self.view.window];
                          // [self showAlertForLoggedIn:[error description]];
                      }
                  }];
             }
             else{
                 [[FBSDKLoginManager new] logOut];
                 //                     [_customFaceBookButton setImage:[UIImage imageNamed:@"fb_connected"] forState:UIControlStateNormal];
             }
         }
     }];
}




-(void)fbLogin {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    [login logInWithReadPermissions: @[@"public_profile"] fromViewController:self  handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
            [login logOut];
            
        } else {
            NSLog(@"Logged in");
            [self GetData];
        }
    }];
}


- (void)GetData {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSString * accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, first_name, picture.type(large) ,last_name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 //NSDictionary *Result = result;
                 [_userDefaults setObject:[result objectForKey:@"name"] forKey:@"facebookLogin"];
                 [_userDefaults synchronize];
                 // self.facebookLogoutButtonInstance.enabled=YES;
                 [self showAlertForLoggedIn:[result objectForKey:@"name"]];
                 NSDictionary *params = [NSMutableDictionary dictionaryWithObject:accessToken forKey:@"access_token"];
                 NSLog(@"Params %@ ",params);
                 
             } else {
                 NSLog(@"Error %@",[error description]);
             }
         }];
    } }

-(void)TwitterLogin{
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            
            // NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
            //  desc =[[NSMutableDictionary alloc] initWithDictionary:session];
            
            
            NSLog(@"signed in as %@", [session userName]);
            [self showAlertForLoggedIn:[session userName]];
            [_userDefaults setObject:[session userName] forKey:@"twitterLogin"];
            [_userDefaults synchronize];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
    
}




-(void)linkedInLogin
{
    LinkedInHelper *linkedIn = [LinkedInHelper sharedInstance];
    // If user has already connected via linkedin in and access token is still valid then
    // No need to fetch authorizationCode and then accessToken again!
    if (linkedIn.isValidToken) {
       // [SVProgressHUD showWithStatus:@"Login..."];
        
        linkedIn.customSubPermissions = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@",Id,email_address, first_name, last_name,phone_numbers,date_of_birth,location_name,picture_url];
        // So Fetch member info by elderyly access token
        
        [linkedIn autoFetchUserInfoWithSuccess:^(NSDictionary *userInfo) {
            // Whole User Info
            
            NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
            desc =[[NSMutableDictionary alloc] initWithDictionary:userInfo];
            [self showAlertForLoggedIn:desc];
            [SVProgressHUD dismiss];
        } failUserInfo:^(NSError *error) {
            NSLog(@"error : %@", error.userInfo.description);
        }];
    } else {
        linkedIn.cancelButtonText = @"Close"; // Or any other language But Default is Close
        NSArray *permissions = @[@(BasicProfile),
                                 @(EmailAddress),
                                 @(Share),
                                 @(CompanyAdmin)];
        
        linkedIn.showActivityIndicator = YES;
        ///#warning - Your LinkedIn App ClientId - ClientSecret - RedirectUrl - And state
        [linkedIn requestMeWithSenderViewController:self
                                           clientId:@"8115cxe5zwk8ey"
                                       clientSecret:@"5E5usdpQsK82ElIA"
                                        redirectUrl:@"https://com.appcoda.linkedin.oauth/oauth"
                                        permissions:permissions
                                              state:@"linkedin\(Int(NSDate().timeIntervalSince1970))"
                                    successUserInfo:^(NSDictionary *userInfo) {
                                        
                                        /// self.linkedInLogoutButtonInstance.hidden = !linkedIn.isValidToken;
                                        [SVProgressHUD showWithStatus:@"Login..."];
                                        
                                        NSMutableDictionary *desc =  [NSMutableDictionary dictionary];
                                        desc =[[NSMutableDictionary alloc] initWithDictionary:userInfo];
                                        [self showAlertForLoggedIn:desc];
                                        NSLog(@"mon profile Bas ------------------------------>%@",desc);
                                        
                                        // Whole User Info
                                        NSLog(@"user Info : %@", userInfo);
                                        // You can also fetch user's those informations like below
                                        NSLog(@"job title : %@",     [LinkedInHelper sharedInstance].title);
                                        NSLog(@"company Name : %@",  [LinkedInHelper sharedInstance].companyName);
                                        NSLog(@"email address : %@", [LinkedInHelper sharedInstance].emailAddress);
                                        NSLog(@"Photo Url : %@",     [LinkedInHelper sharedInstance].photo);
                                        NSLog(@"Industry : %@",      [LinkedInHelper sharedInstance].industry);
                                    }
                                  failUserInfoBlock:^(NSError *error) {
                                      NSLog(@"error  ------------------------------> %@", error.userInfo.description);
                                      [SVProgressHUD dismiss];
                                  }
         ];
    }
}


-(void)googlePlusLogin {
    [[GIDSignIn sharedInstance] signIn];
}


-(void)showAlertForLoggedIn:(NSMutableDictionary *)dataToshow {
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Login Done" message:nil  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action=[UIAlertAction actionWithTitle:@"Thanks" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSMutableString *string = [NSMutableString stringWithString:urlHeader];
        kSetDict(self.sess_id, @"sess_id");
        if (_topSelectedTag == 1)  // linkedln
        {
            _social_type =@"Linkedln Login";
            _L_ID = [NSString stringWithFormat:@"%@",dataToshow[@"id"]];
            _email = [NSString stringWithFormat:@"%@",dataToshow[@"emailAddress"]];
            kSetDict(self.L_ID, @"L_ID");
            kSetDict(self.email, @"email");
            NSLog(@"Linkedln ID------------------------------>%@",self.L_ID);
            [string appendString:@"Social/linkdedln_update"];
            [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                if([[responseObject objectForKey:@"code"] isEqual:@200])
                {
                    [self presentViewController:alert animated:YES completion:nil];
                }
                if([[responseObject objectForKey:@"code"] isEqual:@500])
                {
                }
            } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                
            }];
            
            
        }
        else if (_topSelectedTag == 2)  // Google
        {
            
            _social_type =@"Google Login";
            _G_ID = [NSString stringWithFormat:@"%@",dataToshow[@"userID"]];
            _email = [NSString stringWithFormat:@"%@",dataToshow[@"email"]];
            kSetDict(self.G_ID, @"G_ID");
            kSetDict(self.email, @"email");
            NSLog(@"Google ID------------------------------>%@",self.G_ID);
            [string appendString:@"Social/google_update"];
            [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                if([[responseObject objectForKey:@"code"] isEqual:@200])
                {
                    [self presentViewController:alert animated:YES completion:nil];
                }
                if([[responseObject objectForKey:@"code"] isEqual:@500])
                {
                }
            } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                
            }];
            
            
        }
        else if (_topSelectedTag == 3)  //Facebook
        {
            _social_type =@"Facebook Login";
            _S_ID = [NSString stringWithFormat:@"%@",dataToshow[@"id"]];
            _email = [NSString stringWithFormat:@"%@",dataToshow[@"email"]];
            kSetDict(self.S_ID, @"S_ID");
            kSetDict(self.email, @"email");
            NSLog(@"facebook ID------------------------------>%@",self.S_ID);
            [string appendString:@"Social/facebook_update"];
            [[NetWork shareInstance] netWorkWithUrl:string params:params isPost:YES sucessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                if([[responseObject objectForKey:@"code"] isEqual:@200])
                {
                    [self presentViewController:alert animated:YES completion:nil];
                }
                if([[responseObject objectForKey:@"code"] isEqual:@500])
                {
                }
            } failBlock:^(AFHTTPRequestOperation *operation, NSError *eror) {
                
            }];
            
            
        }
        else if (_topSelectedTag == 4)  // Twitter
        {
            NSLog(@" TwitterLogin----------------------- 4 ");
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
        else if (_topSelectedTag == 5)  // Instagram
        {
            NSLog(@" instagramLogin----------------------- 5 ");
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
        else if (_topSelectedTag == 6)  // yahoo
        {
            NSLog(@" yahoo Login----------------------- 6 ");
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
        
        
    });
    
    
}







-(void)flickerLogin{
    self.checkAuthOp = [[FlickrKit sharedFlickrKit] checkAuthorizationOnCompletion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self userLoggedIn:userName userID:userId];
            } else {
                [self userLoggedOut];
                FKAuthViewController *vc = [[FKAuthViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        });
    }];
    
    
}
-(void)instagramLogin{
    InstagramLoginViewController *vc = [[InstagramLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}





-(void)showingAlert:(NSString*)title :(NSString*)message{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@" showingAlert  login----------------------------> 2");
        [self presentViewController:alert animated:YES completion:nil];
    });
    
}










@end
