//
//  majorViewDetailsCell.h
//  HHSD
//
//  Created by alain serge on 4/14/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface majorViewDetailsCell : UITableViewCell

@property (nonatomic, strong) UILabel *iconLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *arrowLabel;
@property (nonatomic, strong) UILabel *NOLabel;
@property (nonatomic, strong) UIImageView *bgImageView;

//left detail
@property (nonatomic, copy) NSString *iconString;
@property (nonatomic, copy) NSString *titleString;
- (id)initWithFrame:(CGRect)frame iconString:(NSString *)iconString titleString:(NSString *)titleString;
//
//- (void)setIconWithTitleString:(NSString *)titleString;
@end

