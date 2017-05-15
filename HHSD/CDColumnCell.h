//
//  CDColumnCell.h
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//


#import <UIKit/UIKit.h>
@protocol CDColumnCellDelegate<NSObject>
- (void)CDColumnCellOpenClick:(StudentDetail_Column_M *)mode;
@end
@interface CDColumnCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel,*majorName,*schoolName,*start,*end,*startLabel,*endLabel;
@property (nonatomic, strong) UIView *bottomView,*lineView;
@property (nonatomic, assign) id<CDColumnCellDelegate> delegate;
- (void)setMode:(StudentDetail_Column_M *)mode;
+ (CGFloat )getHeight:(StudentDetail_Column_M *)mode;
@end
