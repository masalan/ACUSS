//
//  studentsUsersMainCell.h
//  HHSD
//
//  Created by alain serge on 3/18/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^StudentCellBlock) ();
@protocol StudentCellDelegate <NSObject>

- (void)StudentActionBtnClick:(Student_data *)mode;

@end
@interface studentsUsersMainCell : UITableViewCell
@property (nonatomic, strong) UIImageView *avatarUser;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *o_priceLabel ;
@property (nonatomic, strong) ColorLabel *priceLAbel;
@property (nonatomic, strong) ColorLabel *MyMobile;
@property (nonatomic, strong) UILabel *fullNameUser,*totalStudent,*province,*cityName,*areaName,*details,*locationUser,*locationIcon,*signForCall,*userNationality,*userNationalityIcon,*phoneIcon;

@property (nonatomic, weak) StudentCellBlock actionBtnBlock;
@property (nonatomic, weak) id<StudentCellDelegate>delegate;

- (void)setMode:(Student_data *)mode;
@end
