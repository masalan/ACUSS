//
//  SearchListStudentViewController.h
//  HHSD
//
//  Created by alain serge on 3/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"
@interface SearchListStudentViewController : BaseViewController
@property (nonatomic, assign) BOOL isDelete; //if u want clean
@end

@interface SearchStudentCell : UITableViewCell
@property (nonatomic, strong) UIImageView *avatarUser,*verifyStatus,*countryCode;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *o_priceLabel ;
@property (nonatomic, strong) ColorLabel *priceLAbel;
@property (nonatomic, strong) ColorLabel *MyMobile;
@property (nonatomic, strong) UILabel *fullNameUser,*totalStudent,*province,*cityName,*areaName,*details,*locationUser,*locationIcon,*signForCall,*userNationality,*userNationalityIcon,*phoneIcon;
- (void)setInfoWith:(Student_data *)student_data;
@end
