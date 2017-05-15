//
//  SearchSchoolListCell.m
//  HHSD
//
//  Created by alain serge on 4/12/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SearchSchoolListCell.h"
#define kNumberOfObjects 200
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2

#define D 50
@implementation SearchSchoolListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor=KCOLOR_WHITE;
        [self addContent];
    }
    return  self;
}

-(void)addContent {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, SW2/2, SW2/2)];
        _logoImageView.backgroundColor = KCOLOR_CLEAR;
        _logoImageView.layer.cornerRadius = _logoImageView.size.height/2;
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.backgroundColor = KCOLOR_CLEAR;
        _logoImageView.image = [UIImage imageNamed:NSLocalizedString(@"COMMUN_HOLDER_IMG",comment:"")];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.cellScrollView addSubview:_logoImageView ];
        
    }
    //_SchoolName
    if (!_SchoolName) {
        _SchoolName = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, 5, SCREEN_WIDTH-(_logoImageView.right+30),45)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_BLUE
                                               font:kAutoFont_(18)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        _SchoolName.numberOfLines = 3;
        [self.cellScrollView addSubview:_SchoolName];
    }
    // Province
    if (!_province)
    {
        _province = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, _SchoolName.bottom+1,(SCREEN_WIDTH-140)/2,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_Black_343434
                                             font:kAutoFont_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
        [self.cellScrollView addSubview:_province];
    }
    // City Name
    if (!_cityName)
    {
        _cityName = [UILabel createLabelWithFrame:CGRectMake(_province.right+5, _SchoolName.bottom+1,(SCREEN_WIDTH-135)/2,20)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_Black_343434
                                             font:kAutoFont_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:@""];
        [self.cellScrollView addSubview:_cityName];
    }
    // Foreigner students total
    
    if (!_effective) {
        _effective = [[ColorLabel alloc] initWithFrame:CGRectMake(_logoImageView.right+10, _cityName.bottom+1,SCREEN_WIDTH-(_logoImageView.right+50),20)];
        _effective.backgroundColor = KCOLOR_CLEAR;
        [self.cellScrollView addSubview:_effective];
    }
    
    
    // Description
    if (!_detailLabel) {
        _detailLabel =[UILabel createLabelWithFrame:CGRectMake(10, _effective.bottom+5,SCREEN_WIDTH-20,SW2-((SW2/2)+30))
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_GRAY_999999
                                               font:kAutoFont_(10)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        _detailLabel.numberOfLines = 12;
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.cellScrollView addSubview:_detailLabel];
    }
    
    if (!_integralLabel) {
        _integralLabel =[UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 120, 70, 110, 20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_GRAY_999999
                                                 font:kAutoFont_(12)
                                        textalignment:NSTextAlignmentRight
                                                 text:@""];
        [self.cellScrollView addSubview:_integralLabel];
        _integralLabel.hidden = YES; //hidden
    }
    
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                   backgroundColor:KCOLOR_Line_Color];
    [self.cellScrollView addSubview:lineView];
}

- (void)setInfoWith:(School_data *)school_data {
    [_effective instance:NSLocalizedString(@"Localized_SearchListViewController_effective",comment:"")
          LeftStringFont:kAutoFont_(12)
         LeftStringColor:KTHEME_COLOR
         RightStringFont:kAutoFont_(20)
        RightStringColor:KTHEME_COLOR
            Right_String:[NSString stringWithFormat:@"%@ ",school_data.effective]];
    
    if(school_data) {
        if([school_data.photo hasPrefix:@"http"]) {
            [_logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",school_data.photo]] placeholderImage:[UIImage imageNamed:@"netPlaceHoder"] options:SDWebImageRetryFailed];
        }
        _SchoolName.text = school_data.nameSchool;
        _province.text = school_data.province;
        _cityName.text = school_data.cityName;
        _detailLabel.text = school_data.details;
        
        
    }
}
@end







