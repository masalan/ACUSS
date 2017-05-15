//
//  GroupStudentHeadView.m
//  HHSD
//
//  Created by alain serge on 3/19/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "GroupStudentHeadView.h"

@implementation GroupStudentHeadView

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 23)];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = KTHEME_COLOR_SELECT;
    
    _titleLabel = [UILabel createLabelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 23)
                                backgroundColor:KCOLOR_CLEAR
                                      textColor:KCOLOR_BLACK
                                           font:KSYSTEM_FONT_15
                                  textalignment:NSTextAlignmentLeft
                                           text:title];
    [self addSubview:_titleLabel];
    return self;
}


@end
