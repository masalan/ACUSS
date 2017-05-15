//
//  MyNavBar.m
//  YWYiphone2
//
//  Created by liufengting on 15/1/12.
//  Copyright (c) 2015年 liufengting. All rights reserved.
//

#import "MyNavBar.h"

@implementation MyNavBar

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title leftAction:(SEL )leftAction forViewController:(UIViewController *)vc
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KCOLOR_CLEAR;
        
        _leftButton = [UIButton createButtonwithFrame:CGRectMake(KMARGIN_10, STATUSBAR_HEIGHT+(KBOUNDS_HEIGHT-STATUSBAR_HEIGHT-KHEIGHT_20)/2, KHEIGHT_30,KHEIGHT_20)
                                      backgroundColor:KCOLOR_CLEAR
                                                image:[UIImage imageNamed:@"返回箭头"]];
        [_leftButton addTarget:vc action:leftAction forControlEvents:UIControlEventTouchUpInside];
        _leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_leftButton];
        
        _titleLabel = [UILabel createLabelWithFrame:CGRectMake(KBOUNDS_HEIGHT-STATUSBAR_HEIGHT, STATUSBAR_HEIGHT, kBOUNDS_WIDTH-(KBOUNDS_HEIGHT-STATUSBAR_HEIGHT)*2, KBOUNDS_HEIGHT-STATUSBAR_HEIGHT)
                                    backgroundColor:KCOLOR_CLEAR
                                          textColor:KCOLOR_WHITE
                                               font:kNavgationTitleFont
                                      textalignment:NSTextAlignmentCenter
                                               text:title];
        [self addSubview:_titleLabel];
    }
    return self;
}








@end
