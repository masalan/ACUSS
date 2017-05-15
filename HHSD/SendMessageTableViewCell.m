//
//  SendMessageTableViewCell.m
//  HHSD
//
//  Created by alain serge on 5/3/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SendMessageTableViewCell.h"

@implementation SendMessageTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        return nil;
    }
    
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(10, 0, 80, 45)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_Black_343434
                                           font:kAutoFont_(15)
                                  textalignment:NSTextAlignmentLeft
                                           text:@""];
    
    _textField = [UITextField createTextFieldWithFrame:CGRectMake(_titleLabel.right+10, 0, SCREEN_WIDTH-_titleLabel.right-70, 45)
                                       backgroundColor:KCOLOR_Clear
                                           borderStyle:UITextBorderStyleNone
                                           placeholder:@""
                                                  text:@""
                                             textColor:KCOLOR_Black_343434
                                                  font:kAutoFont_(15)
                                         textalignment:NSTextAlignmentLeft];
    
    _unitLabel = [UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH-10-60, 0, 60, 45)
                               backgroundColor:KCOLOR_Clear
                                     textColor:KCOLOR_GRAY_999999
                                          font:kAutoFont_(15)
                                 textalignment:NSTextAlignmentRight
                                          text:@""];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_textField];
    [self.contentView addSubview:_unitLabel];
    
    return self;
}

@end
