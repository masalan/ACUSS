//
//  schoolUsersMainCell.m
//  HHSD
//
//  Created by alain serge on 3/18/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "schoolUsersMainCell.h"
#define imageStartX 60
#define textFieldStartX 25
#define H4 SCREEN_HEIGHT/4
#define TL SCREEN_WIDTH-4*textFieldStartX
#define SW2 SCREEN_WIDTH/2

#define D 50



@implementation schoolUsersMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.backgroundColor=KCOLOR_WHITE;
        return nil;
    }
    return  self;
}
- (void)setMode:(School_data *)mode
{
    
    _logoImageView = [UIImageView resizeImageViewWithImageView:_logoImageView
                                                         Frame:CGRectMake(10, 10, SW2/2, SW2/2)
                                               backgroundColor:KCOLOR_CLEAR
                                                         image:nil];
[_logoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",mode.photo]] placeholderImage:[UIImage imageNamed:@"netPlaceHoder"] options:SDWebImageRetryFailed];
    [self addSubview:_logoImageView];
    
    // School Name
    _SchoolName = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, 5, SCREEN_WIDTH-(_logoImageView.right+30),45)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_BLUE
                                           font:kAutoFont_(18)
                                  textalignment:NSTextAlignmentLeft
                                           text:[NSString stringWithFormat:@"%@",mode.nameSchool]];
    _SchoolName.numberOfLines = 3;
    [self addSubview:_SchoolName];
    
    // Province
    _province = [UILabel createLabelWithFrame:CGRectMake(_logoImageView.right+10, _SchoolName.bottom+1,(SCREEN_WIDTH-140)/2,20)
                              backgroundColor:KCOLOR_CLEAR
                                    textColor:KCOLOR_Black_343434
                                         font:kAutoFont_(12)
                                textalignment:NSTextAlignmentLeft
                                         text:[NSString stringWithFormat:@"%@",mode.province]];
    [self addSubview:_province];
    
    // City Name
    _cityName = [UILabel createLabelWithFrame:CGRectMake(_province.right+5, _SchoolName.bottom+1,(SCREEN_WIDTH-135)/2,20)
                              backgroundColor:KCOLOR_CLEAR
                                    textColor:KCOLOR_Black_343434
                                         font:kAutoFont_(12)
                                textalignment:NSTextAlignmentLeft
                                         text:[NSString stringWithFormat:@"%@",mode.cityName]];
    [self addSubview:_cityName];
    
    // Foreigner students total
    _effective = [[ColorLabel alloc] initWithFrame:CGRectMake(_logoImageView.right+10, _cityName.bottom+1,SCREEN_WIDTH-(_logoImageView.right+50),20)];
    _effective.backgroundColor = KCOLOR_CLEAR;
    
    [_effective instance:NSLocalizedString(@"Localized_SearchListViewController_effective",comment:"")
          LeftStringFont:kAutoFont_(12)
         LeftStringColor:KTHEME_COLOR
         RightStringFont:kAutoFont_(20)
        RightStringColor:KTHEME_COLOR
            Right_String:[NSString stringWithFormat:@"%@ ",mode.effective]];
    
    
    [self addSubview:_effective];
    
    // Description
    _detailLabel =[UILabel createLabelWithFrame:CGRectMake(10, _effective.bottom+5,SCREEN_WIDTH-20,SW2-((SW2/2)+30))
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_GRAY_999999
                                           font:kAutoFont_(10)
                                  textalignment:NSTextAlignmentLeft
                                           text:[NSString stringWithFormat:@"%@",mode.details]];
    _detailLabel.numberOfLines = 12;
    _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:_detailLabel];
    
    UIView *lineView = [UIView createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)
                                   backgroundColor:KCOLOR_Line_Color];
    [self addSubview:lineView];
    
     
    
    
    
}




@end
