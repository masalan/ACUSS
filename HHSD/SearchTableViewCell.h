//
//  SearchTableViewCell.h
//  HHSD
//
//  Created by alain serge on 4/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *codeBtn;

- (void)showText:(NSIndexPath *)indexP
            type:(NSString *)type
      dictionary:(NSDictionary *)dict;

@end
