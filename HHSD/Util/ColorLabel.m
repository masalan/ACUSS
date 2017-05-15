//
//  ColorLabel.m
//  HHSD
//
//  Created by alain serge on 3/10/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "ColorLabel.h"

@implementation ColorLabel
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}
- (void)instance:(NSString *)string LeftStringFont:(UIFont *)left_font LeftStringColor:(UIColor *)left_Color RightStringFont:(UIFont *)right_font RightStringColor:(UIColor *)right_color
{
    NSUInteger left_length = string.length;
    NSString *tmpString = [NSString stringWithFormat:@"%@ 元",string];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   left_font,NSFontAttributeName,
                                   KCOLOR_GRAY_ff7800,NSForegroundColorAttributeName,nil];
    NSDictionary *attributeDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    right_font,NSFontAttributeName,
                                    [UIColor blackColor],NSForegroundColorAttributeName,nil];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:tmpString];
    [AttributedStr setAttributes:attributeDict range:NSMakeRange(0, left_length)];
    [AttributedStr setAttributes:attributeDict1 range:NSMakeRange(left_length, 2)];
    
}
- (void)instance:(NSString *)left_string LeftStringFont:(UIFont *)left_font LeftStringColor:(UIColor *)left_Color RightStringFont:(UIFont *)right_font RightStringColor:(UIColor *)right_color Right_String:(NSString *)right_string
{
    NSUInteger left_length = left_string.length;
    NSUInteger right_length = right_string.length;
    NSString *tmpString = [NSString stringWithFormat:@"%@%@",left_string,right_string];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   left_font,NSFontAttributeName,
                                   left_Color,NSForegroundColorAttributeName,nil];
    NSDictionary *attributeDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    right_font,NSFontAttributeName,
                                    right_color,NSForegroundColorAttributeName,nil];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:tmpString];
    [AttributedStr setAttributes:attributeDict range:NSMakeRange(0, left_length)];
    [AttributedStr setAttributes:attributeDict1 range:NSMakeRange(left_length, right_length)];
    self.attributedText = AttributedStr;
    
}
@end
