//
//  MySegementedControl.m
//  YWYiphone2
//
//  Created by liufengting on 15/1/23.
//  Copyright (c) 2015年 liufengting. All rights reserved.
//

#import "MySegementedControl.h"

@implementation MySegementedControlButton

-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image name:(NSString *)name backgroundColor:(UIColor *)backgroundColor selectedBackgroudColor:(UIColor *)selectedBackgroudColor
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = backgroundColor;
        
        CGFloat nameWidth = [PublicMethod getWidthWithHeight:KHEIGHT_20 text:name font:KSYSTEM_FONT_15];
        CGFloat originX = (kBOUNDS_WIDTH-nameWidth)/2;
        CGFloat labelOriginX = originX;
        if (image) {
            originX = (kBOUNDS_WIDTH-nameWidth-MySegementedControlButtonImageWidth-KMARGIN_10)/2;
            labelOriginX = originX+MySegementedControlButtonImageWidth+KMARGIN_10;

            UIImageView * iconImageView = [UIImageView createImageViewWithFrame:CGRectMake(originX, (KBOUNDS_HEIGHT-MySegementedControlButtonImageWidth)/2, MySegementedControlButtonImageWidth, MySegementedControlButtonImageWidth)
                                                   backgroundColor:KCOLOR_CLEAR
                                                             image:image];
            [self addSubview:iconImageView];
            
            
        }
        
        UILabel *nameLabel = [UILabel createLabelWithFrame:CGRectMake(labelOriginX, (KBOUNDS_HEIGHT-KHEIGHT_20)/2, nameWidth, KHEIGHT_20)
                                   backgroundColor:KCOLOR_CLEAR
                                         textColor:KCOLOR_WHITE
                                              font:KSYSTEM_FONT_14
                                     textalignment:NSTextAlignmentLeft
                                              text:name];
        [self addSubview:nameLabel];
    }
    return self;
}


@end




@implementation MySegementedControl

-(id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray nameArray:(NSArray *)nameArray selectedIndex:(NSInteger)selectedIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KCOLOR_CLEAR;
        self.layer.borderColor = KCOLOR_WHITE_TRANSPARENT.CGColor;
        self.layer.borderWidth = KBORDER_WIDTH_03;
        
        NSInteger count = MIN([imageArray count], [nameArray count]);
        CGFloat width = kBOUNDS_WIDTH/count;
        for (NSInteger i = 0; i< count; i++) {
            MySegementedControlButton *button = [[MySegementedControlButton alloc]initWithFrame:CGRectMake(width*i, 0, width, KBOUNDS_HEIGHT)
                                                                                      withImage:imageArray[i]
                                                                                           name:nameArray[i]
                                                                                backgroundColor:KCOLOR_CLEAR
                                                                         selectedBackgroudColor:KCOLOR_WHITE_TRANSPARENT];
            [button setTag:i];
            if (i == selectedIndex) {
                [button setBackgroundColor:KCOLOR_WHITE_TRANSPARENT];
            }
            [button addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
        
        
    }
    return self;
}
-(void)onButtonTapped:(MySegementedControlButton *)sender
{
    for (MySegementedControlButton *button in self.subviews) {
        if (button.tag == sender.tag) {
            [button setBackgroundColor:KCOLOR_WHITE_TRANSPARENT];
        }else{
            [button setBackgroundColor:KCOLOR_CLEAR];
        }
    }
    if (_delegate && [_delegate  respondsToSelector:@selector(mySegementedControlDidSelectIndex:)]) {
        [_delegate mySegementedControlDidSelectIndex:sender.tag];
    }
}

@end




