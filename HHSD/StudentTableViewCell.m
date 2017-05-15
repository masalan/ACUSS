//
//  StudentTableViewCell.m
//  HHSD
//
//  Created by alain serge on 3/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "StudentTableViewCell.h"
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2
#define studentH SCREEN_WIDTH/2
#define schoolH SCREEN_WIDTH/2.2
#define D 50
#define BtnH SCREEN_WIDTH/12
#define rowH SCREEN_WIDTH/2.2

@implementation StudentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        self.backgroundColor =KTHEME_COLOR;
        return nil;
    }
                _leftImageView = [[UIImageView alloc] init];
                _countryCode = [[UIImageView alloc] init];
                _bgImageView = [[UIImageView alloc] init];
                _fullNameUser = [[UILabel alloc] init];
                _avatarUser = [[UIImageView alloc] init];
                _userNationalityIcon = [[UILabel alloc] init];
                _userNationality = [[UILabel alloc] init];
                _locationIcon = [[UILabel alloc] init];
                _locationUser = [[UILabel alloc] init];
                _phoneIcon = [[UILabel alloc] init];
                _phoneCall = [[UILabel alloc] init];
                _signForCall = [[UILabel alloc] init];
                _detailLabel = [[UILabel alloc] init];
    return self;
}

- (void)setMode:(Student_data *)mode 
{
    
    // Background image
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, studentH)];
    _bgImageView.backgroundColor = KTHEME_COLOR;
    _bgImageView.backgroundColor = KCOLOR_CLEAR;
    _bgImageView.contentMode = UIViewContentModeScaleToFill;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",mode.bg_image]] placeholderImage:[UIImage imageNamed:@"6000"] options:SDWebImageRetryFailed];
    
    [self addSubview:_bgImageView ];
    
    
    
    //avatar
    _avatarUser = [[UIImageView alloc] initWithFrame:CGRectMake(10,30, SW2/2, SW2/2)];
    _avatarUser.backgroundColor = KCOLOR_CLEAR;
    _avatarUser.layer.cornerRadius = _avatarUser.size.height/2;
    _avatarUser.layer.masksToBounds = YES;
    _avatarUser.backgroundColor = KCOLOR_CLEAR;
    _avatarUser.contentMode = UIViewContentModeScaleAspectFill;
    
   [_avatarUser sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",mode.avatar_user]] placeholderImage:[UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")] options:SDWebImageRetryFailed];
    [_bgImageView addSubview:_avatarUser ];
    
    
    // name
    _fullNameUser = [UILabel resizeFrameWithLabel:_fullNameUser
                                          frame:CGRectMake(_avatarUser.right+5, 5, SCREEN_WIDTH-(_avatarUser.right+30),50)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE_fafbfc
                                           font:kAutoFont_(18)
                                  textalignment:NSTextAlignmentCenter
                                           text:@""];
    
    
    
    _fullNameUser.numberOfLines = 2;

    if (mode.fullName) {
        _fullNameUser.text = [NSString stringWithFormat:@"%@",mode.fullName];
    }
    else
    {
        _fullNameUser.text = [NSString stringWithFormat:@"%@",mode.realname];
    }
    [_bgImageView addSubview:_fullNameUser];
    
    
    // userNationalityIcon
    _userNationalityIcon = [UILabel resizeFrameWithLabel:_userNationalityIcon
                                                   frame:CGRectMake(_avatarUser.right+10, _fullNameUser.bottom+1,20,20)
                                         backgroundColor:KCOLOR_CLEAR
                                               textColor:KCOLOR_WHITE_fafbfc
                                                    font:KICON_FONT_(11)
                                           textalignment:NSTextAlignmentLeft
                                                    text:@"\U0000e781 : "];
        [_bgImageView addSubview:_userNationalityIcon];
    
    
    
    // Background image
        _countryCode = [[UIImageView alloc] initWithFrame:CGRectMake(_userNationalityIcon.right+1, _fullNameUser.bottom+1,20,17)];
        _countryCode.backgroundColor = KCOLOR_CLEAR;
        _countryCode.contentMode = UIViewContentModeScaleToFill;
        [_bgImageView addSubview:_countryCode ];
   
    // Flag view
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@",mode.Codecountry];
    
    if(mode.Codecountry) {
        _countryCode.image = [UIImage imageNamed:imagePath];
    }
    else {
        _countryCode.image = [UIImage imageNamed:@""];
        
    }
    
    
    [self addSubview:_bgImageView ];
    
    
    
    // userNationality
    _userNationality = [UILabel resizeFrameWithLabel:_userNationality
                                               frame:CGRectMake(_countryCode.right+2, _fullNameUser.bottom+1,(SCREEN_WIDTH-140)-31,20)
                                     backgroundColor:KCOLOR_CLEAR
                                           textColor:KCOLOR_WHITE_fafbfc
                                                font:kAutoFont_(11)
                                       textalignment:NSTextAlignmentLeft
                                                text:@""];
    if (mode.nationality) {
        _userNationality.text = [NSString stringWithFormat:@"%@",mode.nationality];
    }
    else
    {
        _userNationality.text = @"";
    }
        [_bgImageView addSubview:_userNationality];
    
    
    // locationIcon
    _locationIcon = [UILabel resizeFrameWithLabel:_locationIcon
                                            frame:CGRectMake(_avatarUser.right+10, _userNationality.bottom+1,20,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_WHITE_fafbfc
                                             font:KICON_FONT_(11)
                                    textalignment:NSTextAlignmentLeft
                                             text:@"\U0000e739 : "];
    [_bgImageView addSubview:_locationIcon];
    
    // User location locationUser
    
    _locationUser = [UILabel resizeFrameWithLabel:_locationUser
                                            frame:CGRectMake(_locationIcon.right+3, _userNationality.bottom+1,(SCREEN_WIDTH-140)-10,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_WHITE_fafbfc
                                             font:kAutoFont_(11)
                                    textalignment:NSTextAlignmentLeft
                                             text:[NSString stringWithFormat:@"%@/%@/%@ ",mode.province_name,mode.city_name,mode.area_name]];
 
    [_bgImageView addSubview:_locationUser];
    
    //phoneIcon
        _phoneIcon = [UILabel resizeFrameWithLabel:_phoneIcon
                                             frame:CGRectMake(_avatarUser.right+10, _locationUser.bottom+1,20,20)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_WHITE_fafbfc
                                          font:KICON_FONT_(11)
                                 textalignment:NSTextAlignmentLeft
                                          text:@"\U0000e649 : "];
    [_bgImageView addSubview:_phoneIcon];
    
    //phoneCall
    _phoneCall = [UILabel resizeFrameWithLabel:_phoneCall
                                         frame:CGRectMake(_phoneIcon.right+3, _locationUser.bottom+1,((SCREEN_WIDTH-(_avatarUser.right+10))/2)-25,20)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_WHITE_fafbfc
                                          font:KICON_FONT_(11)
                                 textalignment:NSTextAlignmentLeft
                                          text:[NSString stringWithFormat:@"%@ ",mode.mobile]];
    [_bgImageView addSubview:_phoneCall];

    
    _signForCall =[ UILabel createLabelWithFrame:CGRectMake(_phoneCall.right+1, _locationUser.bottom+1,((SCREEN_WIDTH-(_avatarUser.right+10))/2)-20,BtnH)
                                 backgroundColor:KCOLOR_CALL_ME
                                       textColor:KCOLOR_WHITE_fafbfc
                                            font:kAutoFont_(12)
                                   textalignment:NSTextAlignmentCenter
                                            text:NSLocalizedString(@"Localized_SearchListStudentViewController_signForCall",comment:"")
                                   conrnerRadius:8.0
                                     borderWidth:1
                                     borderColor:KCOLOR_CALL_ME];
    
    [_bgImageView addSubview:_signForCall];
    
    
    // Description
    _detailLabel =[UILabel resizeFrameWithLabel:_detailLabel
                                          frame:CGRectMake(10, _phoneCall.bottom+10,SCREEN_WIDTH-20,(SW2-((SW2/2)+30))-20)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_GRAY_999999
                                           font:kAutoFont_(16)
                                  textalignment:NSTextAlignmentCenter
                                           text:@""];
    _detailLabel.numberOfLines = 2;
    _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_bgImageView addSubview:_detailLabel];
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
    
    
    
    
}



+ (CGFloat)getHeight
{
    CGFloat height = studentH;
    return height;
}

@end
