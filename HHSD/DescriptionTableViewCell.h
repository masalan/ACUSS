//
//  DescriptionTableViewCell.h
//  HHSD
//
//  Created by alain serge on 4/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DescriptionTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;

@end
