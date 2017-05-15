//
//  admin_AllUsersApp.h
//  HHSD
//
//  Created by alain serge on 5/11/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//


#import "BaseViewController.h"
#import "SWTableViewCell.h"

typedef void (^AddViewCellBlock) ();

@protocol MyUsersListDelegate <NSObject>
//- (void)mySchool:(School_Details *)mySchoolCenter;
- (void)AddViewActionBtnClick:(Users_data *)mode;

@end

@interface adminAllUsersListCell : SWTableViewCell
@property (nonatomic, strong) UIImageView *livingTypeIcone,*climateTypeIcone,*cityTypeIcone,*logoImageView,*smallAvatar,*maintenance,*fbook,*google,*linkedln,*countryCode;
@property (nonatomic, strong) UILabel *titleALbel,*detailLabel,*integralLabel,*o_priceLabel,*iconeUserSex;
@property (nonatomic, strong) UIButton *actionBtn; ;
@property (nonatomic, strong) UILabel *SchoolName,*totalStudent,*province,*cityName,*details,*userLocationChina,*userIconeLocationChina,*userAdressIcone,*userAdressIconeNow;

@property (nonatomic, strong) UILabel *cityTypeLabel,*cityTypeName,*climateTypeLabel,*climateTypeName,*livingTypeLabel,*livingTypeName,*lineOne,*lineTwo,*lineTree,*userFullname,*userBirthday,*userMobile;


@property (nonatomic, strong) ColorLabel *priceLAbel;
@property (nonatomic, strong) ColorLabel *effective;
@property (nonatomic, strong) Users_view_data *mainMode;

- (void)setInfoWith:(Users_view_data *)users_data;
//- (void)setClickView:(School_data *) school_data;
@property (nonatomic, weak) AddViewCellBlock actionBtnBlock;


@end



@interface admin_AllUsersApp : BaseViewController
@property (nonatomic, assign) BOOL isDelete; //if u want clean
@property (nonatomic, assign) BOOL isMySetting;
@property (nonatomic, weak) id <MyUsersListDelegate> delegate;
@end
