//
//  landlordTableViewCell.m
//  HHSD
//
//  Created by alain serge on 5/3/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "landlordTableViewCell.h"

@implementation landlordTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(10, 0, 80, 45)
                                backgroundColor:KCOLOR_Clear
                                      textColor:KCOLOR_Black_343434
                                           font:kAutoFont_(15)
                                  textalignment:NSTextAlignmentLeft
                                           text:@""];
    UILabel *femaleLabel = [UILabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH-10-40, 0, 40, 45)
                                         backgroundColor:KCOLOR_Clear
                                               textColor:KCOLOR_GRAY_999999
                                                    font:kAutoFont_(15)
                                           textalignment:NSTextAlignmentRight
                                                    text:@"女士"];
    _femaleSexLabel = [UILabel createLabelWithFrame:CGRectMake(femaleLabel.left-18, 0, 20, 45)
                                    backgroundColor:KCOLOR_Clear
                                          textColor:KCOLOR_Line_Color
                                               font:KICON_FONT_(15)
                                      textalignment:NSTextAlignmentRight
                                               text:@"\U0000e64e"];
    _femaleButton = [UIButton createButtonwithFrame:CGRectMake(_femaleSexLabel.left, 0, SCREEN_WIDTH-_femaleSexLabel.left, 45)
                                    backgroundColor:KCOLOR_Clear
                                              image:nil];
    
    UILabel *maleLabel = [UILabel createLabelWithFrame:CGRectMake(_femaleSexLabel.left - 48, 0, 40, 45)
                                       backgroundColor:KCOLOR_Clear
                                             textColor:KCOLOR_GRAY_999999
                                                  font:kAutoFont_(15)
                                         textalignment:NSTextAlignmentRight
                                                  text:@"先生"];
    _maleSexLabel = [UILabel createLabelWithFrame:CGRectMake(maleLabel.left-18, 0, 20, 45)
                                  backgroundColor:KCOLOR_Clear
                                        textColor:KCOLOR_Line_Color
                                             font:KICON_FONT_(15)
                                    textalignment:NSTextAlignmentRight
                                             text:@"\U0000e64e"];
    _maleButton = [UIButton createButtonwithFrame:CGRectMake(_maleSexLabel.left, 0, 70, 45)
                                  backgroundColor:KCOLOR_Clear
                                            image:nil];
    
    _textField = [UITextField createTextFieldWithFrame:CGRectMake(_titleLabel.right+10, 0, SCREEN_WIDTH-_maleSexLabel.left-5, 45)
                                       backgroundColor:KCOLOR_Clear
                                           borderStyle:UITextBorderStyleNone
                                           placeholder:@"请填写联系人"
                                                  text:@""
                                             textColor:KCOLOR_Black_343434
                                                  font:kAutoFont_(15)
                                         textalignment:NSTextAlignmentLeft];
    
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_textField];
    [self.contentView addSubview:maleLabel];
    [self.contentView addSubview:_maleSexLabel];
    [self.contentView addSubview:_maleButton];
    [self.contentView addSubview:femaleLabel];
    [self.contentView addSubview:_femaleSexLabel];
    [self.contentView addSubview:_femaleButton];
    
    return self;
}


@end
