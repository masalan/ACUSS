//
//  DescriptionTableViewCell.m
//  HHSD
//
//  Created by alain serge on 4/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "DescriptionTableViewCell.h"

@implementation DescriptionTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(10, 0, 80, 40)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_Black_343434
                                           font:kAutoFont_(15)
                                  textalignment:NSTextAlignmentLeft
                                           text:@""];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(95, 5, SCREEN_WIDTH-105, 130)];
    _textView.textColor = KCOLOR_Black_343434;
    _textView.font = kAutoFont_(15);
    
    _placeholderLabel = [UILabel createLabelWithFrame:CGRectMake(5, 5, _textView.width-10, 23)
                                      backgroundColor:KCOLOR_Clear
                                            textColor:KCOLOR_Line_Color
                                                 font:kAutoFont_(15)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@""];
    _placeholderLabel.numberOfLines = 0;
    _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_textView addSubview:_placeholderLabel];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_textView];
    
    return self;
}

@end
