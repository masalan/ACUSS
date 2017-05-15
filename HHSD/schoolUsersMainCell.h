//
//  schoolUsersMainCell.h
//  HHSD
//
//  Created by alain serge on 3/18/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SchoolCellBlock) ();
@protocol SchoolCellDelegate <NSObject>

- (void)SchoolActionBtnClick:(School_data *)mode;

@end



@interface schoolUsersMainCell : UITableViewCell
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleALbel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@property (nonatomic, strong) UILabel *o_priceLabel ;
@property (nonatomic, strong) ColorLabel *priceLAbel;
@property (nonatomic, strong) ColorLabel *effective;
@property (nonatomic, strong) UILabel *SchoolName,*totalStudent,*province,*cityName,*details;

@property (nonatomic, weak) SchoolCellBlock actionBtnBlock;
@property (nonatomic, weak) id<SchoolCellDelegate>delegate;

- (void)setMode:(School_data *)mode;
@end
