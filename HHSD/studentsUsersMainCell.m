//
//  studentsUsersMainCell.m
//  HHSD
//
//  Created by alain serge on 3/18/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "studentsUsersMainCell.h"
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2
#define D 50
#define BtnH SCREEN_WIDTH/12
#define rowH SCREEN_WIDTH/2.2

@implementation studentsUsersMainCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor=KCOLOR_WHITE;
        return nil;
    }
    return  self;
}


- (void)setMode:(Student_data *)mode
{
      _avatarUser = [[UIImageView alloc] initWithFrame:CGRectMake(10,30, SW2/2, SW2/2)];
        _avatarUser.backgroundColor = KCOLOR_CLEAR;
        _avatarUser.layer.cornerRadius = _avatarUser.size.height/2;
        _avatarUser.layer.masksToBounds = YES;
        _avatarUser.backgroundColor = KCOLOR_CLEAR;
        _avatarUser.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
        _avatarUser.contentMode = UIViewContentModeScaleAspectFill;
    
    [_avatarUser sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",mode.head_image]] placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")] options:SDWebImageRetryFailed];
         [self addSubview:_avatarUser ];
        
   
    
    //_SchoolName
        _fullNameUser = [UILabel createLabelWithFrame:CGRectMake(_avatarUser.right+5, 5, SCREEN_WIDTH-(_avatarUser.right+30),35)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_BLUE
                                                 font:kAutoFont_(18)
                                        textalignment:NSTextAlignmentLeft
                                                 text:[NSString stringWithFormat:@"%@",mode.realname]];
        _fullNameUser.numberOfLines = 2;
        [self addSubview:_fullNameUser];
    
    // userNationalityIcon
    
        _userNationalityIcon = [UILabel createLabelWithFrame:CGRectMake(_avatarUser.right+10, _fullNameUser.bottom+1,20,20)
                                             backgroundColor:KCOLOR_CLEAR
                                                   textColor:KTHEME_COLOR
                                                        font:KICON_FONT_(11)
                                               textalignment:NSTextAlignmentLeft
                                                        text:@"\U0000e781 : "];
        [self addSubview:_userNationalityIcon];
    
    
    // userNationality
   
        _userNationality = [UILabel createLabelWithFrame:CGRectMake(_userNationalityIcon.right+1, _fullNameUser.bottom+1,(SCREEN_WIDTH-140)-10,20)
                                         backgroundColor:KCOLOR_CLEAR
                                               textColor:KCOLOR_BLUE
                                                    font:kAutoFont_(11)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@""];
        [self addSubview:_userNationality];
   
    
    // locationIcon
   
        _locationIcon = [UILabel createLabelWithFrame:CGRectMake(_avatarUser.right+10, _userNationality.bottom+1,20,20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KTHEME_COLOR
                                                 font:KICON_FONT_(11)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"\U0000e739 : "];
        [self addSubview:_locationIcon];
    
    // User location locationUser
   
        _locationUser = [UILabel createLabelWithFrame:CGRectMake(_locationIcon.right+3, _userNationality.bottom+1,(SCREEN_WIDTH-140)-10,20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_BLUE
                                                 font:kAutoFont_(11)
                                        textalignment:NSTextAlignmentLeft
                                                 text:[NSString stringWithFormat:@"%@/%@/%@ ",mode.province_name,mode.city_name,mode.area_name]];
        [self addSubview:_locationUser];
    
    
    
    //phoneIcon
   
        _phoneIcon = [UILabel createLabelWithFrame:CGRectMake(_avatarUser.right+10, _locationUser.bottom+1,20,20)
                                   backgroundColor:KCOLOR_CLEAR
                                         textColor:KTHEME_COLOR
                                              font:KICON_FONT_(11)
                                     textalignment:NSTextAlignmentLeft
                                              text:@"\U0000e649 : "];
        [self addSubview:_phoneIcon];
    
    
    // Phone Number
    
        _MyMobile = [[ColorLabel alloc] initWithFrame:CGRectMake(_phoneIcon.right+3, _locationUser.bottom+1,((SCREEN_WIDTH-(_avatarUser.right+10))/2)-10,20)];
        _MyMobile.backgroundColor = KCOLOR_CLEAR;
        [self addSubview:_MyMobile];
    
    [_MyMobile instance:@""
         LeftStringFont:kAutoFont_(12)
        LeftStringColor:KTHEME_COLOR
        RightStringFont:kAutoFont_(20)
       RightStringColor:KTHEME_COLOR
           Right_String:[NSString stringWithFormat:@"%@ ",mode.mobile]];
    
   
    
           _signForCall =[ UILabel createLabelWithFrame:CGRectMake(_MyMobile.right+1, _locationUser.bottom+1,((SCREEN_WIDTH-(_avatarUser.right+10))/2)-20,BtnH)
                                          backgroundColor:KCOLOR_CALL_ME
                                                textColor:KCOLOR_WHITE
                                                     font:kAutoFont_(12)
                                            textalignment:NSTextAlignmentCenter
                                                     text:NSLocalizedString(@"Localized_SearchListStudentViewController_signForCall",comment:"")
                                            conrnerRadius:8.0
                                              borderWidth:1
                                              borderColor:KCOLOR_CALL_ME];
        
        [self addSubview:_signForCall];
    
    
    
    // Description
        _detailLabel =[UILabel createLabelWithFrame:CGRectMake(10, _MyMobile.bottom+10,SCREEN_WIDTH-20,(SW2-((SW2/2)+30))-20)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_GRAY_999999
                                               font:kAutoFont_(16)
                                      textalignment:NSTextAlignmentCenter
                                               text:@""];
        _detailLabel.numberOfLines = 2;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_detailLabel];
        _detailLabel.hidden = YES; //hidden
    
    
    if ([mode.living_in_china isEqualToString:@"0"])
    {
        _detailLabel.text = NSLocalizedString(@"Localized_SearchListStudentViewController_detailLabel",comment:"");
        _detailLabel.textColor = KCOLOR_RED;
        _detailLabel.hidden = NO; //show
    }
    else if ([mode.living_in_china isEqualToString:@"1"])
    {
        _detailLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Localized_SearchListStudentViewController_detailLabel_living",comment:""),mode.city_name];
        _detailLabel.textColor = KCOLOR_BLUE;
        _detailLabel.hidden = NO; //show
    }
   
    
        _integralLabel =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 120, 70, 110, 20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_GRAY_999999
                                                 font:KSYSTEM_FONT_Px_KFont(12)
                                        textalignment:NSTextAlignmentRight
                                                 text:@""];
        [self addSubview:_integralLabel];
        _integralLabel.hidden = YES; //hidden
   
    
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                   backgroundColor:KCOLOR_Line_Color];
    [self addSubview:lineView];
}



@end

