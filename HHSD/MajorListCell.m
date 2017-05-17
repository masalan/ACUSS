//
//  MajorListCell.m
//  HHSD
//
//  Created by alain serge on 3/31/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "MajorListCell.h"


#define honorLabel 30
#define marginX 10
#define Length (SCREEN_WIDTH-40)

@implementation MajorListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self)
    {
        return  nil;
    }
    _startingDateText = [[UILabel alloc] init];
    _IconeFee = [[UILabel alloc] init];
    _IconeSLang = [[UILabel alloc] init];
    _IconeStarting = [[UILabel alloc] init];
    _IconeName = [[UILabel alloc] init];
    _CourseName = [[UILabel alloc] init];
    _startingDate = [[UILabel alloc] init];
    _deadline = [[UILabel alloc] init];
    _language = [[UILabel alloc] init];
    _fee = [[UILabel alloc] init];
    _IconeFeeText = [[UILabel alloc] init];
    _IconDeadline = [[UILabel alloc] init];
    _deadLineText = [[UILabel alloc] init];
    _deadlineText = [[UILabel alloc] init];
    _IconDuration = [[UILabel alloc] init];
    _Icondurationtext = [[UILabel alloc] init];
    _lineZero = [[UILabel alloc] init];
    _lineOne = [[UILabel alloc] init];
    _lineTtwo = [[UILabel alloc] init];
    _lineTree = [[UILabel alloc] init];
    _lineFour = [[UILabel alloc] init];
    _languageText = [[UILabel alloc] init];
    _IconDurationLabel = [[UILabel alloc] init];
    _degreIcon = [[UIImageView alloc] init];
    
    // UIImage *degreIcon;
    return self;
}
- (void)setMode:(SchoolDetail_Column_M *)mode
{
   
    // course name
    _CourseName = [UILabel resizeFrameWithLabel:_CourseName
                                          frame:CGRectMake(marginX,3,SCREEN_WIDTH-20,35)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_NAME_SCHOOL
                                           font:KSYSTEM_FONT_(13)
                                  textalignment:NSTextAlignmentCenter
                                           text:nil];
    if (mode.CourseName) {
        _CourseName.text = [NSString stringWithFormat:@"%@",mode.CourseName];
    }else{
        _CourseName.text = [NSString stringWithFormat:@"..."];
    }
    _CourseName.numberOfLines =2;
    [self addSubview:_CourseName];
    
    
    
   _degreIcon = [UIImageView  resizeImageViewWithImageView:_degreIcon
                                                     Frame:CGRectMake(SCREEN_WIDTH-80,_CourseName.bottom,60,60)
                                           backgroundColor:KCOLOR_CLEAR
                                                     image:nil];
    if ([mode.cycle_id isEqualToString:@"2"])
    {
        _degreIcon.image = [UIImage imageNamed:@"BachelorDegree"];
    }
    else if ([mode.cycle_id isEqualToString:@"3"])
    {
        _degreIcon.image = [UIImage imageNamed:@"MasterDegree"];
    }
    else if ([mode.cycle_id isEqualToString:@"4"])
    {
        _degreIcon.image = [UIImage imageNamed:@"PhdDegree"];
    }

    [self addSubview:_degreIcon];
    
    
    

    
    // course Starting date Icone
    _IconeStarting = [UILabel resizeFrameWithLabel:_IconeStarting
                                             frame:CGRectMake(10,_CourseName.bottom,18,18)
                                          backgroundColor:KCOLOR_CLEAR
                                                textColor:KCOLOR_GRAY_Cell
                                                     font:KICON_FONT_(13)
                                            textalignment:NSTextAlignmentLeft
                                                     text:@"\U0000e771"];
    [self addSubview:_IconeStarting];
    
    //  startingDateText
    _startingDateText = [UILabel resizeFrameWithLabel:_startingDateText
                                             frame:CGRectMake(_IconeStarting.right+2,_CourseName.bottom,100,18)
                                   backgroundColor:KCOLOR_CLEAR
                                         textColor:KCOLOR_GRAY_Cell
                                              font:KICON_FONT_(13)
                                     textalignment:NSTextAlignmentLeft
                                              text:@"Starting Date :"];
    [self addSubview:_startingDateText];
    // course Starting date
    _startingDate = [UILabel resizeFrameWithLabel:_startingDate
                                            frame:CGRectMake(_startingDateText.right,_CourseName.bottom,Length,18)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_GRAY
                                             font:KSYSTEM_FONT_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:nil];
    if (mode.startingDate) {
        _startingDate.text = [NSString stringWithFormat:@"%@",mode.startingDate];
    }else{
        _startingDate.text = [NSString stringWithFormat:@""];
    }
    
    [self addSubview:_startingDate];
    
    
    // Line One  --------------------------------------------------------------------------------------------> 1
    _lineOne = [UILabel resizeFrameWithLabel:_lineOne
                                            frame:CGRectMake(15,_startingDate.bottom+8,SCREEN_WIDTH-110,0.5)
                                  backgroundColor:KCOLOR_GRAY_Cell
                                        textColor:KCOLOR_GRAY_Cell
                                             font:KICON_FONT_(13)
                                    textalignment:NSTextAlignmentCenter
                                             text:nil];
    [self addSubview:_lineOne];
    
    
    // IconDeadline
    _IconDeadline = [UILabel resizeFrameWithLabel:_IconDeadline
                                             frame:CGRectMake(10,_lineOne.bottom,18,18)
                                   backgroundColor:KCOLOR_CLEAR
                                         textColor:KCOLOR_DEAD_LINE
                                              font:KICON_FONT_(13)
                                     textalignment:NSTextAlignmentLeft
                                              text:@"\U0000e616"];
    [self addSubview:_IconDeadline];
    
    
    // deadLineText
    _deadLineText = [UILabel resizeFrameWithLabel:_deadLineText
                                                frame:CGRectMake(_IconDeadline.right+2,_lineOne.bottom,130,18)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_GRAY_Cell
                                                 font:KICON_FONT_(13)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"Application DeadLine:"];
    [self addSubview:_deadLineText];
    
    
    // deadlineText
    _deadlineText = [UILabel resizeFrameWithLabel:_deadlineText
                                            frame:CGRectMake(_deadLineText.right,_lineOne.bottom,Length,18)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_GRAY
                                             font:KSYSTEM_FONT_(12)
                                    textalignment:NSTextAlignmentLeft
                                             text:@"May 7, 2017"];
    
    if (mode.deadline) {
        _deadlineText.text = [NSString stringWithFormat:@"%@",mode.deadline];
    }else{
        _deadlineText.text = [NSString stringWithFormat:@"Jul 15"];
    }
    [self addSubview:_deadlineText];
    
    
    
    // Line Two  --------------------------------------------------------------------------------------------> 2
    _lineTtwo = [UILabel resizeFrameWithLabel:_lineTtwo
                                       frame:CGRectMake(15,_deadlineText.bottom+8,SCREEN_WIDTH-110,0.5)
                             backgroundColor:KCOLOR_GRAY_Cell
                                   textColor:KCOLOR_GRAY_Cell
                                        font:KICON_FONT_(13)
                               textalignment:NSTextAlignmentCenter
                                        text:nil];
    [self addSubview:_lineTtwo];
    
    //IconDuration
    _IconDuration = [UILabel resizeFrameWithLabel:_IconDuration
                                            frame:CGRectMake(10,_lineTtwo.bottom,18,18)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_GRAY_Cell
                                             font:KICON_FONT_(13)
                                    textalignment:NSTextAlignmentLeft
                                             text:@"\U0000e647 "];
    [self addSubview:_IconDuration];
    
    //  _IconDurationLabel
    _IconDurationLabel = [UILabel resizeFrameWithLabel:_IconDurationLabel
                                                frame:CGRectMake(_IconDuration.right,_lineTtwo.bottom,80,18)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_GRAY_Cell
                                                 font:KICON_FONT_(13)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"Duration"];
    [self addSubview:_IconDurationLabel];
    
    
    //Icondurationtext
    _Icondurationtext = [UILabel resizeFrameWithLabel:_Icondurationtext
                                            frame:CGRectMake(_IconDurationLabel.right,_lineTtwo.bottom,Length,18)
                                  backgroundColor:KCOLOR_CLEAR
                                        textColor:KCOLOR_GRAY
                                             font:KICON_FONT_(13)
                                    textalignment:NSTextAlignmentLeft
                                             text:nil];
    
    if (mode.duration) {
        _Icondurationtext.text = [NSString stringWithFormat:@"%@ Years",mode.duration];
    }else{
        _Icondurationtext.text = [NSString stringWithFormat:@""];
    }
    [self addSubview:_Icondurationtext];
    
    
    
    // Line 3  --------------------------------------------------------------------------------------------> 3
    _lineTree = [UILabel resizeFrameWithLabel:_lineTree
                                        frame:CGRectMake(15,_Icondurationtext.bottom+8,SCREEN_WIDTH-30,0.5)
                              backgroundColor:KCOLOR_GRAY_Cell
                                    textColor:KCOLOR_GRAY_Cell
                                         font:KICON_FONT_(13)
                                textalignment:NSTextAlignmentCenter
                                         text:nil];
    [self addSubview:_lineTree];
    
    // course Starting date Icone
    _IconeSLang = [UILabel resizeFrameWithLabel:_IconeSLang
                                          frame:CGRectMake(10,_lineTree.bottom,18, 18)
                                        backgroundColor:KCOLOR_CLEAR
                                              textColor:KCOLOR_GRAY_Cell
                                                   font:KICON_FONT_(15)
                                          textalignment:NSTextAlignmentLeft
                                                   text:@"\U0000e606"];
    [self addSubview:_IconeSLang];
    
    // _languageText
    _languageText = [UILabel resizeFrameWithLabel:_languageText
                                          frame:CGRectMake(_IconeSLang.right+2,_lineTree.bottom,130, 18)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_GRAY_Cell
                                           font:KICON_FONT_(13)
                                  textalignment:NSTextAlignmentLeft
                                           text:@"Teaching Language:"];
    [self addSubview:_languageText];
    
    
    // course language
    _language = [UILabel resizeFrameWithLabel:_language
                                        frame:CGRectMake(_languageText.right,_lineTree.bottom,Length, 18)
                              backgroundColor:KCOLOR_CLEAR
                                    textColor:KCOLOR_GRAY
                                         font:KSYSTEM_FONT_(12)
                                textalignment:NSTextAlignmentLeft
                                         text:nil];
    if (mode.language) {
        _language.text = [NSString stringWithFormat:@"%@",mode.language];
    }else{
        _language.text = [NSString stringWithFormat:@""];
    }
    
    [self addSubview:_language];
    
    
    // startingDate deadline
    // _lineFour --------------------------------------------------------------------------------------------> 4
    _lineFour = [UILabel resizeFrameWithLabel:_lineFour
                                        frame:CGRectMake(15,_language.bottom+8,SCREEN_WIDTH-30,0.5)
                              backgroundColor:KCOLOR_GRAY_Cell
                                    textColor:KCOLOR_GRAY_Cell
                                         font:KICON_FONT_(13)
                                textalignment:NSTextAlignmentCenter
                                         text:nil];
    [self addSubview:_lineFour];
    
    _IconeFee = [UILabel resizeFrameWithLabel:_IconeFee
                                        frame:CGRectMake(10, _lineFour.bottom,18, 18)
                                      backgroundColor:KCOLOR_CLEAR
                                            textColor:KCOLOR_GRAY_Cell
                                                 font:KICON_FONT_(15)
                                        textalignment:NSTextAlignmentLeft
                                                 text:@"\U0000e715"];
    [self addSubview:_IconeFee];
    //_IconeFeeText
    _IconeFeeText = [UILabel resizeFrameWithLabel:_IconeFeeText
                                        frame:CGRectMake(_IconeFee.right+2, _lineFour.bottom,100, 18)
                              backgroundColor:KCOLOR_CLEAR
                                    textColor:KCOLOR_GRAY_Cell
                                         font:KICON_FONT_(15)
                                textalignment:NSTextAlignmentLeft
                                         text:@"Tuition Fee:"];
    [self addSubview:_IconeFeeText];
    
    
    // Fee course
    _fee = [UILabel resizeFrameWithLabel:_fee
                                   frame:CGRectMake(_IconeFeeText.right,_lineFour.bottom,Length, 18)
                         backgroundColor:KCOLOR_CLEAR
                               textColor:KCOLOR_GRAY
                                    font:KSYSTEM_FONT_(12)
                           textalignment:NSTextAlignmentLeft
                                    text:nil];
    
    if (mode.fee) {
        _fee.text = [NSString stringWithFormat:@" RMB %@ /year",mode.fee];
    }else{
        _fee.text = [NSString stringWithFormat:@""];
    }
    
    
    [self addSubview:_fee];
    
    // _lineFour --------------------------------------------------------------------------------------------> 4
    _lineFive = [UILabel resizeFrameWithLabel:_lineFive
                                        frame:CGRectMake(15,_fee.bottom+8,SCREEN_WIDTH-30,0.5)
                              backgroundColor:KCOLOR_GRAY_Cell
                                    textColor:KCOLOR_GRAY_Cell
                                         font:KICON_FONT_(13)
                                textalignment:NSTextAlignmentCenter
                                         text:nil];
    [self addSubview:_lineFive];
    
}

+ (CGFloat)getCellHeight:(SchoolDetail_Column_M *)mode
{
    CGFloat height = 180;
    return  height ;
}

- (void)btnClickLogin
{
    DLog(@"messageButtonClick");
    if(_messageView.hidden)
    {
        [UIView animateWithDuration:1.0
                              delay:0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             _messageView.hidden = NO;
                         }
                         completion:^(BOOL finished) {}];
    }else
    {
        
        [UIView animateWithDuration:1.0
                              delay:0
                            options:UIViewAnimationOptionTransitionCrossDissolve
                         animations:^{
                             _messageView.hidden = YES;
                         }
                         completion:^(BOOL finished) {}];
    }
}





@end
