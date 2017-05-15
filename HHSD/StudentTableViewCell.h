//
//  StudentTableViewCell.h
//  HHSD
//
//  Created by alain serge on 3/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *leftImageView,*bgImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *avatarUser,*countryCode;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *o_priceLabel ;
@property (nonatomic, strong) ColorLabel *priceLAbel;
@property (nonatomic, strong) ColorLabel *MyMobile;
@property (nonatomic, strong) UILabel *fullNameUser,*totalStudent,*province,*cityName,*areaName,*details,*locationUser,*locationIcon,*signForCall,*userNationality,*userNationalityIcon,*phoneIcon,*phoneCall;

- (void)setMode:(Student_data *)mode ;
+ (CGFloat)getHeight;
@end
