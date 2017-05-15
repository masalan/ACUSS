//
//  sellectEditCell.m
//  HHSD
//
//  Created by alain serge on 3/24/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "sellectEditCell.h"


@implementation sellectEditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        return nil;
    }
    if(!_titleLabel)
    {
        _titleLabel = [UILabel createLabelWithFrame:CGRectMake(20, 10, 80, 20)
                                    backgroundColor:KCOLOR_WHITE
                                          textColor:KCOLOR_Black_343434
                                               font:KICON_FONT_(15)
                                      textalignment:NSTextAlignmentLeft
                                               text:@""];
        [self addSubview:_titleLabel];
    }
    if(!_contentLabel)
    {
        _contentLabel = [UILabel createLabelWithFrame:CGRectMake(_titleLabel.right, 10, SCREEN_WIDTH-(_titleLabel.right+25), 20)
                                      backgroundColor:KCOLOR_WHITE
                                            textColor:KCOLOR_Black_343434
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
