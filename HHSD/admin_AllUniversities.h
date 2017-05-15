//
//  admin_AllUniversities.h
//  HHSD
//
//  Created by alain serge on 5/10/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BaseViewController.h"
#import "SWTableViewCell.h"

typedef void (^AddViewCellBlock) ();

@protocol MySchoolListDelegate <NSObject>
//- (void)mySchool:(School_Details *)mySchoolCenter;
- (void)AddViewActionBtnClick:(School_data *)mode;

@end

@interface adminAllSchoolListCell : SWTableViewCell
@property (nonatomic, strong) UIImageView *logoImageView,*maintenance;
@property (nonatomic, strong) UILabel *titleALbel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *o_priceLabel ;
@property (nonatomic, strong) UIButton *actionBtn; ;
@property (nonatomic, strong) UILabel *SchoolName,*totalStudent,*province,*cityName,*details;

@property (nonatomic, strong) UILabel *cityTypeIcone,*cityTypeLabel,*cityTypeName,*climateTypeIcone,*climateTypeLabel,*climateTypeName,*livingTypeIcone,*livingTypeLabel,*livingTypeName,*lineOne,*lineTwo,*lineTree;


@property (nonatomic, strong) ColorLabel *priceLAbel;
@property (nonatomic, strong) ColorLabel *effective;
@property (nonatomic, strong) School_data *mainMode;

- (void)setInfoWith:(School_data *)school_data;
//- (void)setClickView:(School_data *) school_data;
@property (nonatomic, weak) AddViewCellBlock actionBtnBlock;


@end



@interface admin_AllUniversities : BaseViewController
@property (nonatomic, assign) BOOL isDelete; //if u want clean
@property (nonatomic, assign) BOOL isMySetting;
@property (nonatomic, weak) id <MySchoolListDelegate> delegate;
@end
