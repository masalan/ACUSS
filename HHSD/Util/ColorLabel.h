//
//  ColorLabel.h
//  HHSD
//
//  Created by alain serge on 3/10/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorLabel : UILabel
- (void)instance:(NSString *)string LeftStringFont:(UIFont *)left_font LeftStringColor:(UIColor *)left_Color RightStringFont:(UIFont *)right_font RightStringColor:(UIColor *)right_color;
- (void)instance:(NSString *)left_string LeftStringFont:(UIFont *)left_font LeftStringColor:(UIColor *)left_Color RightStringFont:(UIFont *)right_font RightStringColor:(UIColor *)right_color Right_String:(NSString *)right_string;
@end
