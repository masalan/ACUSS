//
//  GroupStudentHeadView.h
//  HHSD
//
//  Created by alain serge on 3/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupStudentHeadView : UIView
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithTitle:(NSString *)title;
@end
