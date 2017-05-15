//
//  userProfileCell.m
//  HHSD
//
//  Created by alain serge on 3/23/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "userProfileCell.h"

@implementation userProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.backgroundColor=KCOLOR_WHITE;
    _iconLabel = [UILabel createLabelWithFrame:CGRectMake(10, 15, 25,25)
                               backgroundColor:KCOLOR_Clear
                                     textColor:KCOLOR_GRAY_676767
                                          font:KICON_FONT_(20)
                                 textalignment:NSTextAlignmentCenter
                                          text:@""];
    _iconLabel.centerY = self.size.height/2;
    [self addSubview:_iconLabel];
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(50, 17, 160,30)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_GRAY_676767
                                           font:kAutoFont_(13)
                                  textalignment:NSTextAlignmentLeft
                                           text:@""];
    _titleLabel.centerY = self.size.height/2+ 2;
    [self addSubview:_titleLabel];
    
    
    _rightLabel = [UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 100, 17, 50,30)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KTHEME_COLOR
                                           font:KICON_FONT_(15)
                                  textalignment:NSTextAlignmentRight
                                           text:@""];
    _rightLabel.centerY = self.size.height/2+ 2;
    _rightLabel.hidden = YES;
    [self addSubview:_rightLabel];
    
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 17,50,30)];
        _bgImageView.backgroundColor = KCOLOR_CLEAR;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImageView];
   
    
    _arrowLabel = [UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 40, 15, 15,15)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_GRAY_999999
                                           font:KICON_FONT_(15)
                                  textalignment:NSTextAlignmentCenter
                                           text:@"\U0000e684"];
   // [self addSubview:_arrowLabel];
    
    return self;
}






- (id)initWithFrame:(CGRect)frame iconString:(NSString *)iconString titleString:(NSString *)titleString{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=KCOLOR_WHITE;
        _iconString = iconString;
        _titleString= titleString;
        [self drawView];
    }
    return self;
}
-(void)drawView {
    _iconLabel = [UILabel createLabelWithFrame:CGRectMake(10, 15, 25,25)
                               backgroundColor:KCOLOR_Clear
                                     textColor:KCOLOR_GRAY_676767
                                          font:KICON_FONT_(20)
                                 textalignment:NSTextAlignmentCenter
                                          text:_iconString];
    _iconLabel.centerY = self.size.height/2;
    [self addSubview:_iconLabel];
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(40, 17, 160,30)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_GRAY_676767
                                           font:kAutoFont_(13)
                                  textalignment:NSTextAlignmentLeft
                                           text:_titleString];
    _titleLabel.centerY = self.size.height/2+ 2;
    [self addSubview:_titleLabel];
    _rightLabel = [UILabel createLabelWithFrame:CGRectMake((SCREEN_WIDTH/2), 17, (SCREEN_WIDTH/1.9)-20,30)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KTHEME_COLOR
                                           font:KICON_FONT_(13)
                                  textalignment:NSTextAlignmentRight
                                           text:@""];
    _rightLabel.centerY = self.size.height/2+ 2;
    _rightLabel.hidden = YES;
    [self addSubview:_rightLabel];
    
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 17,50,30)];
    _bgImageView.backgroundColor = KCOLOR_CLEAR;
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_bgImageView];
    
    
    _arrowLabel = [UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH - 40, 15, 15,15)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_GRAY_999999
                                           font:KICON_FONT_(15)
                                  textalignment:NSTextAlignmentCenter
                                           text:@"\U0000e684"];
   // [self addSubview:_arrowLabel];
}


@end
