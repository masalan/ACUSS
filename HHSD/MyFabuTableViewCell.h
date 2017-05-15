//
//  MyFabuTableViewCell.h
//  HHSD
//
//  Created by alain serge on 4/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondHandModel.h"

@interface MyFabuTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *photoImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *liuLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *ciLabel;
@property (nonatomic, strong) UILabel *rightIconLabel;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *delBtn;

- (void)setMode:(SecondHandModel *)mode withIndexSection:(NSInteger)section;

+ (CGFloat)getHeight;

@end
