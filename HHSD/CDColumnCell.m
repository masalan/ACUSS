//
//  CDColumnCell.m
//  HHSD
//
//  Created by alain serge on 3/15/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//


#import "CDColumnCell.h"
#define columnheight 30
@implementation CDColumnCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        return nil;
    }
    _majorName =  [[UILabel alloc] init];
    _schoolName = [[UILabel alloc] init];
    _start =      [[UILabel alloc] init];
    _end =      [[UILabel alloc] init];
    _startLabel =      [[UILabel alloc] init];
    _endLabel =      [[UILabel alloc] init];
    return self;
}
- (void)setMode:(StudentDetail_Column_M *)mode
{
    self.backgroundColor = KTHEME_COLOR;
    
    //Major Nme
    _majorName = [UILabel resizeFrameWithLabel:_majorName
                                          frame:CGRectMake(10,8, SCREEN_WIDTH - 20, 28)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE
                                           font:KICON_FONT_(18)
                                  textalignment:NSTextAlignmentCenter
                                           text:[NSString stringWithFormat:@"%@",mode.major_name]];
    
    [self addSubview:_majorName];
    
    //School Name
    _schoolName = [UILabel resizeFrameWithLabel:_schoolName
                                         frame:CGRectMake(10,_majorName.bottom, SCREEN_WIDTH - 20,35)
                               backgroundColor:KCOLOR_CLEAR
                                     textColor:KCOLOR_WHITE
                                          font:KICON_FONT_(14)
                                 textalignment:NSTextAlignmentCenter
                                          text:[NSString stringWithFormat:@"%@",mode.school_name]];
    _schoolName.numberOfLines = 3;
    
    [self addSubview:_schoolName];
    
    
    // Start
    _start = [UILabel resizeFrameWithLabel:_start
                                          frame:CGRectMake(10,_schoolName.bottom+2, (SCREEN_WIDTH-20)/2, 15)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_WHITE
                                           font:KICON_FONT_(8)
                                  textalignment:NSTextAlignmentCenter
                                           text:NSLocalizedString(@"Localized_CDColumnCell_start",comment:"")];
    
    [self addSubview:_start];
    
    // Start Label
    _startLabel = [UILabel resizeFrameWithLabel:_startLabel
                                     frame:CGRectMake(10,_start.bottom, (SCREEN_WIDTH-20)/2, 18)
                           backgroundColor:KCOLOR_CLEAR
                                 textColor:KCOLOR_WHITE
                                      font:KICON_FONT_(11)
                             textalignment:NSTextAlignmentCenter
                                           text:nil];
    if (mode.start_study) {
        _startLabel.text = [PublicMethod getYMDUsingCreatedTimestamp:mode.start_study];
    }else
    {
        _startLabel.text = @"00";
    }
    
    [self addSubview:_startLabel];
    

    // End
    _end = [UILabel resizeFrameWithLabel:_end
                                     frame:CGRectMake(10+((SCREEN_WIDTH-20)/2),_schoolName.bottom+2, (SCREEN_WIDTH-20)/2, 15)
                           backgroundColor:KCOLOR_CLEAR
                                 textColor:KCOLOR_WHITE
                                      font:KICON_FONT_(8)
                             textalignment:NSTextAlignmentCenter
                                      text:NSLocalizedString(@"Localized_CDColumnCell_end",comment:"")];
    
    [self addSubview:_end];
    
    
    // End Label
    _endLabel = [UILabel resizeFrameWithLabel:_endLabel
                                   frame:CGRectMake(10+((SCREEN_WIDTH-20)/2),_end.bottom, (SCREEN_WIDTH-20)/2, 18)
                         backgroundColor:KCOLOR_CLEAR
                               textColor:KCOLOR_WHITE
                                    font:KICON_FONT_(11)
                           textalignment:NSTextAlignmentCenter
                                         text:nil];
    if (mode.end_study) {
        _endLabel.text = [PublicMethod getYMDUsingCreatedTimestamp:mode.end_study];
    }else
    {
        _endLabel.text = @"00";
    }

    
    [self addSubview:_endLabel];

    
    
    
}
+ (CGFloat )getHeight:(StudentDetail_Column_M *)mode
{
    CGFloat height = 120;
    if(!mode.isOpen)
    {
        return height;
    }
    if([mode.content isKindOfClass:[NSArray class]])
    {
        return height + mode.content.count * columnheight;
    }
    return height;
}
@end
