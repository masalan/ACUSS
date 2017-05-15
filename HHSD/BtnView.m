//
//  BtnView.m
//  HHSD
//
//  Created by alain serge on 4/20/17.
//  Copyright © 2017 Alain Serge. All rights reserved.
//

#import "BtnView.h"

@implementation BtnView

- (instancetype)initWithTitle:(NSString *)title;
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    
    if (self) {
        return nil;
    }
    
    
    _bottomBtn = [UIButton createButtonwithFrame:CGRectMake(KMARGIN_10, 27, SCREEN_WIDTH-20, 42)
                                 backgroundColor: KTHEME_COLOR
                                      titleColor:KCOLOR_WHITE
                                            font:KSYSTEM_FONT_18
                                           title:title];
    _bottomBtn.layer.cornerRadius = KCORNER_RADIUS_5;
    
    [self addSubview:_bottomBtn];
    
    
    return self;
}

@end
