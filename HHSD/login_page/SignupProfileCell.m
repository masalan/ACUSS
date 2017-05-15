//
//  SignupProfileCell.m
//  HHSD
//
//  Created by alain serge on 3/21/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "SignupProfileCell.h"
#define SW3 SCREEN_WIDTH/3
@implementation SignupProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        return nil;
    }
    if(!_titleLabel)
    {
        _titleLabel = [UILabel createLabelWithFrame:CGRectMake(10, 10,SW3, 20)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_Black_343434
                                               font:KICON_FONT_(13)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        [self addSubview:_titleLabel];
    }
    if(!_contentLabel)
    {
        _contentLabel = [UILabel createLabelWithFrame:CGRectMake(_titleLabel.right+2, 10,(2*SW3)-40, 20)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KTHEME_COLOR
                                                 font:KICON_FONT_(13)
                                        textalignment:NSTextAlignmentRight
                                                 text:@""];
        [self addSubview:_contentLabel];
    }
    
    return self ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
