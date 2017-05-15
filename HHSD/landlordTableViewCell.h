//
//  landlordTableViewCell.h
//  HHSD
//
//  Created by alain serge on 5/3/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface landlordTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *maleSexLabel;
@property (nonatomic, strong) UILabel *femaleSexLabel;
@property (nonatomic, strong) UIButton *maleButton;
@property (nonatomic, strong) UIButton *femaleButton;
@end
