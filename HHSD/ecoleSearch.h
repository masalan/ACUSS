//
//  ecoleSearch.h
//  HHSD
//
//  Created by alain serge on 4/12/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"

@interface ecoleSearch : BaseViewController
@property (nonatomic, assign) BOOL isDelete; //if u want clean

@end


@interface ecolesCell : UITableViewCell
@property (nonatomic, strong) UIImageView *logoImageView,*maintenance;
@property (nonatomic, strong) UILabel *titleALbel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *o_priceLabel ;
@property (nonatomic, strong) UILabel *SchoolName,*totalStudent,*province,*cityName,*details;
@property (nonatomic, strong) ColorLabel *priceLAbel;
@property (nonatomic, strong) ColorLabel *effective;
- (void)setInfoWith:(School_data *)school_data;
@end

