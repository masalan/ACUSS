//
//  CDInteractView.m
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//



#import "CDInteractView.h"

#define honorLabel 30
#define AL  SCREEN_WIDTH/2
@implementation CDInteractView
- (instancetype)initWithMode:(Student_Details *)mode
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    
   // self.backgroundColor = KCOLOR_WHITE;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, [[self class] getHeight:mode]);
    
    
    
    // Background image
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    _bgImageView.backgroundColor = KCOLOR_CLEAR;
    _bgImageView.contentMode = UIViewContentModeScaleToFill;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",mode.bg_image]] placeholderImage:[UIImage imageNamed:@"6000"] options:SDWebImageRetryFailed];
    [self addSubview:_bgImageView ];
    
    
    
    
    
    _headView = [UIImageView createImageViewWithFrame:CGRectMake(0, 20, AL, AL)
                                      backgroundColor:KTHEME_COLOR
                                                image:nil];
    _headView.layer.cornerRadius = _headView.width/2.0;
    _headView.layer.borderColor = KCOLOR_WHITE_fafbfc.CGColor;
    _headView.layer.borderWidth = 2.0;
    _headView.layer.masksToBounds = YES;
    _headView.centerX = SCREEN_WIDTH/2.0;
    [_headView imageCacheWithImageView:_headView urlString:mode.avatar_user];
    [_bgImageView addSubview:_headView];
    
    // Status user
    _verify = [UIImageView createImageViewWithFrame:CGRectMake(0,(20+AL)-20, 40, 40)
                                      backgroundColor:KCOLOR_WHITE_fafbfc
                                                image:nil];
    _verify.layer.cornerRadius = _verify.width/2.0;
    _verify.layer.borderColor = KCOLOR_WHITE_fafbfc.CGColor;
    _verify.layer.borderWidth = 3.0;
    _verify.layer.masksToBounds = YES;
    _verify.centerX = SCREEN_WIDTH/2.0;
    _verify.contentMode = UIViewContentModeScaleAspectFill;


    if ([mode.verify isEqualToString:@"0"])
    {
        _verify.image = [UIImage imageNamed:@"0"];
    }
    else if ([mode.verify isEqualToString:@"1"])
    {
        _verify.image = [UIImage imageNamed:@"1"];
    }
    else if ([mode.verify isEqualToString:@"2"])
    {
        _verify.image = [UIImage imageNamed:@"2"];
    }
    else if ([mode.verify isEqualToString:@"3"])
    {
        _verify.image = [UIImage imageNamed:@"3"];
    }
    else if ([mode.verify isEqualToString:@"4"])
    {
        _verify.image = [UIImage imageNamed:@"4"];
    }
    else if ([mode.verify isEqualToString:@"5"])
    {
        _verify.image = [UIImage imageNamed:@"5"];
    }
    else if ([mode.verify isEqualToString:@"6"])
    {
        _verify.image = [UIImage imageNamed:@"6"];
    }
    else if ([mode.verify isEqualToString:@"7"])
    {
        _verify.image = [UIImage imageNamed:@"7"];
    }
    [_bgImageView addSubview:_verify];
    
    
    
    // name user
    _nameLabel = [UILabel createLabelWithFrame:CGRectMake(15, _verify.bottom + 10, SCREEN_WIDTH-20, 30)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_WHITE_fafbfc
                                          font:KSYSTEM_FONT_(18)
                                 textalignment:NSTextAlignmentCenter
                                          text:nil];
    
    if (mode.realname)
    {
        _nameLabel.text = [NSString stringWithFormat:@" %@",mode.realname];
    }else
    {
        _nameLabel.text = @"";
    }
    
    _nameLabel.centerX = SCREEN_WIDTH/2.0;
    [_bgImageView addSubview:_nameLabel];
    
    _professionIcone = [UILabel createLabelWithFrame:CGRectMake(10, _nameLabel.bottom + 2,20, 20)
                                             backgroundColor:KCOLOR_CLEAR
                                                   textColor:KCOLOR_WHITE_fafbfc
                                                        font:KICON_FONT_(12)
                                               textalignment:NSTextAlignmentLeft
                                                        text:@"\U0000e76a"];
    [_bgImageView addSubview:_professionIcone];

    // profession
    _profession = [UILabel createLabelWithFrame:CGRectMake(_professionIcone.right, _nameLabel.bottom + 2,((SCREEN_WIDTH/2)-20)/2, 20)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_WHITE_fafbfc
                                          font:KSYSTEM_FONT_(12)
                                 textalignment:NSTextAlignmentLeft
                                          text:nil];
            if([mode.profession isEqualToString:@"0"])
        {
            _profession.text = @"Student";
            
        }
        else if ([mode.profession isEqualToString:@"1"])
        {
            _profession.text = @"Teacher";
        }
        else if ([mode.profession isEqualToString:@"2"])
        {
            _profession.text = @"Searcher";
        }
        else if ([mode.profession isEqualToString:@"3"])
        {
            _profession.text = @"Visitor";
        }
        else if ([mode.profession isEqualToString:@"4"])
        {
            _profession.text = @"Other";
        }
    [_bgImageView addSubview:_profession];
    
    _nationalityIcone = [UILabel createLabelWithFrame:CGRectMake(_profession.right, _nameLabel.bottom + 2,20, 20)
                                     backgroundColor:KCOLOR_CLEAR
                                           textColor:KCOLOR_WHITE_fafbfc
                                                font:KICON_FONT_(12)
                                       textalignment:NSTextAlignmentLeft
                                                text:@"\U0000e769"];
    [_bgImageView addSubview:_nationalityIcone];
    
    
    
    _nationality= [UILabel createLabelWithFrame:CGRectMake(_nationalityIcone.right, _nameLabel.bottom + 2,((SCREEN_WIDTH/2)-20)/2, 20)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE_fafbfc
                                           font:KSYSTEM_FONT_(12)
                                  textalignment:NSTextAlignmentLeft
                                           text:[NSString stringWithFormat:@" %@",mode.nationality]];
    [_bgImageView addSubview:_nationality];
    
    //cityIcone
    _cityIcone = [UILabel createLabelWithFrame:CGRectMake(_nationality.right, _nameLabel.bottom + 2,20, 20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_WHITE_fafbfc
                                                 font:KICON_FONT_(12)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"\U0000e64b"];
    [_bgImageView addSubview:_cityIcone];
    
    // City name
    _cityName= [UILabel createLabelWithFrame:CGRectMake(_cityIcone.right, _nameLabel.bottom + 2,((SCREEN_WIDTH/2)-1)/2, 20)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE_fafbfc
                                           font:KSYSTEM_FONT_(12)
                                  textalignment:NSTextAlignmentLeft
                                        text:[NSString stringWithFormat:@" %@",mode.city_name]];
    [_bgImageView addSubview:_cityName];
    
    _centerView = [UIView createViewWithFrame:CGRectMake(0, _cityName.bottom + 10, SCREEN_WIDTH, [[self class] getCenterHeight:mode])
                              backgroundColor:KCOLOR_CLEAR];
    [_bgImageView addSubview:_centerView];
    

    
    UILabel *label = [UILabel createLabelWithFrame:CGRectMake(10,_centerView.bottom + 10, SCREEN_WIDTH - 30, 20)
                      
                                   backgroundColor:KCOLOR_CLEAR
                                         textColor:KCOLOR_BLUE
                                              font:KICON_FONT_(15)
                                     textalignment:NSTextAlignmentCenter
                                              text:NSLocalizedString(@"Localized_CDInteractView_bio",comment:"")];
    [_bgImageView addSubview:label];
    
    // Bio
    _bottomLabel= [UILabel createLabelWithFrame:CGRectMake(10,label.bottom + 10, SCREEN_WIDTH - 20, [[self class] getBottomHeight:mode])
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE_fafbfc
                                           font:KSYSTEM_FONT_(12)
                                  textalignment:NSTextAlignmentLeft
                                           text:mode.info];
    _bottomLabel.numberOfLines = 1000;
    [_bottomLabel sizeToFit];
    [_bgImageView addSubview:_bottomLabel];
    
    return self;
}
+ (CGFloat)getHeight:(Student_Details *)mode
{
    CGFloat height = 0;
    if(mode) height = SCREEN_HEIGHT -(height + 190);
   // if(mode) height = height + 190;
    height = height+ [[self class] getCenterHeight:mode];
    height = height+ [[self class] getBottomHeight:mode];
    return height;
}
+ (CGFloat)getCenterHeight:(Student_Details *)mode
{
    return honorLabel *mode.honor.count;
}
+ (CGFloat)getBottomHeight:(Student_Details *)mode
{
    return [PublicMethod getHeightWithWidth:SCREEN_WIDTH - 20 text:mode.info font:KSYSTEM_FONT_(14)];
}
@end
/***
 0 unverify
 1 verify
 2 secure user
 3 spammer
 4 moderateur
 5 graduate
 6 admin
 7teacher
 
 https://www.iconfinder.com/iconsets/education-line-circle-1
 **/
