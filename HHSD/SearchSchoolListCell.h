//
//  SearchSchoolListCell.h
//  HHSD
//
//  Created by alain serge on 4/12/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SWTableViewCell.h"
#import "BaseViewController.h"
@interface SearchSchoolListCell : SWTableViewCell
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleALbel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *o_priceLabel ;
@property (nonatomic, strong) ColorLabel *priceLAbel;
@property (nonatomic, strong) ColorLabel *effective;
@property (nonatomic, strong) UILabel *SchoolName,*totalStudent,*province,*cityName,*details;
- (void)setInfoWith:(School_data *)school_data;
@end
